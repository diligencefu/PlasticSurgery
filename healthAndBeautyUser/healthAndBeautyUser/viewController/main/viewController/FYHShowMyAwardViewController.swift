//
//  FYHShowMyAwardViewController.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/21.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class FYHShowMyAwardViewController: Base2ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addFooterRefresh()
    }
    
    override func configSubViews() {
        
        setupTitleViewSectionStyle(titleStr: "我的奖品")
        
        mainTableView = UITableView.init(frame: CGRect(x: 0,
                                                       y: CGFloat(navHeight),
                                                       width: kSCREEN_WIDTH,
                                                       height: kSCREEN_HEIGHT - 64 ),
                                         style: .grouped)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.estimatedRowHeight = 80
        mainTableView.register(UINib(nibName: "FYHShowCJGooddsCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
        self.view.addSubview(mainTableView)
    }
    
    
    override func refreshHeaderAction() {
        currentPage = 1
        requestData()
    }
    
    
    override func refreshFooterAction() {
        currentPage = currentPage+1
        requestData()
    }
    
    
    override func requestData() {
        
        let params = [
            "mobileCode" : Defaults["mobileCode"].stringValue,
            "SESSIONID" : Defaults["SESSIONID"].stringValue,
            "pageNO":String(currentPage)
        ]
        SVPWillShow("加载中...")
        NetWorkForUserPrizes(params: params) { (datas,pages,flag) in
            if flag {
                if self.currentPage == 1 {
                    self.mainTableArr.removeAllObjects()
                    self.mainTableView.mj_header.endRefreshing()
                    if self.currentPage == pages {
                        self.mainTableView.mj_footer.endRefreshingWithNoMoreData()
                    }else{
                        self.mainTableView.mj_footer.resetNoMoreData()
                    }
                }else{
                    if self.currentPage >= pages {
                        self.mainTableView.mj_footer.endRefreshingWithNoMoreData()
                    }else{
                        self.mainTableView.mj_footer.endRefreshing()
                    }
                }
                self.mainTableArr.addObjects(from: datas)
                self.mainTableView.reloadData()
                SVPHide()
            }else{
                SVPwillShowAndHide("加载失败")
            }
        }
    }
    
    
    //    ******************代理 ： UITableViewDataSource,UITableViewDelegate  ************
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainTableArr.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = mainTableArr[indexPath.row] as! FYHShowGetGoodsModel
        
        let cell : FYHShowCJGooddsCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! FYHShowCJGooddsCell
        cell.setValuesForFYHShowCJGooddsCell(model: model,isGet: false)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 19 * kSCREEN_SCALE))
        view.backgroundColor = UIColor.blue
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 19 * kSCREEN_SCALE))
        view.backgroundColor = kSetRGBColor(r: 239, g: 239, b: 244)
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.001
        }
        
        return 19 * kSCREEN_SCALE
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01 * kSCREEN_SCALE
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
        }
    }
    
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        
        return "删除记录"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if mainTableArr.count>0 {
            self.mainTableView.mj_header.beginRefreshing()
        }
    }
    
}
