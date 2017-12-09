//
//  FYHRCViewController.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/8.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FYHRCViewController: Base2ViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addFooterRefresh()
    }
    
    override func configSubViews() {
        setupTitleViewSectionStyle(titleStr: "会员返现")

        mainTableView = UITableView.init(frame: CGRect(x: 0,
                                                       y: CGFloat(navHeight),
                                                       width: kSCREEN_WIDTH,
                                                       height: kSCREEN_HEIGHT - 64 ),
                                         style: .grouped)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.estimatedRowHeight = 80
        mainTableView.register(UINib(nibName: "FYHReturnCashCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
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
        Alamofire.request(user_VipCashBacks,
                          method: .get, parameters: params,
                          encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                            deBugPrint(item: response.result)
                            switch response.result {
                            case .success:
                                if let j = response.result.value {
                                    //SwiftyJSON解析数据
                                    let JSOnDictory = JSON(j)
                                    let data =  JSOnDictory["data"]["vipCashBacks"].arrayValue
                                    let code =  JSOnDictory["code"].stringValue
                                    if code == "0" {
                                        setToast(str: "请求失败")
                                    }else{
                                        self.totalPage = JSOnDictory["data"]["totalPage"].stringValue
                                        if self.currentPage == 1 {
                                            self.mainTableArr.removeAllObjects()
                                            self.mainTableView.mj_header.endRefreshing()
                                            if self.currentPage == Int(self.totalPage) {
                                                self.mainTableView.mj_footer.endRefreshingWithNoMoreData()
                                            }else{
                                                self.mainTableView.mj_footer.resetNoMoreData()
                                            }

                                        }else{
                                            if self.currentPage == Int(self.totalPage) {
                                                self.mainTableView.mj_footer.endRefreshingWithNoMoreData()
                                            }else{
                                                self.mainTableView.mj_footer.endRefreshing()
                                            }
                                        }

                                        for index in 0..<data.count {
                                            let model = FYHRCModel.setValueForFYHRCModel(json: data[index])
                                            self.mainTableArr.add(model)
                                        }
                                        
                                        self.mainTableView.reloadData()
                                    }
                                    SVPHide()
                                }
                                break
                            case .failure(let error):
                                deBugPrint(item: error)
                                setToast(str: "请求失败")
                            }
        }
        
    }

    
    //    ******************代理 ： UITableViewDataSource,UITableViewDelegate  ************
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return mainTableArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = mainTableArr[indexPath.section] as! FYHRCModel
        
        let cell : FYHReturnCashCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! FYHReturnCashCell
        cell.FYHReturnCashCellSetValues(model: model)
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
        let model = mainTableArr[indexPath.section] as! FYHRCModel
        let detailVC = FYHRCDetailViewController()
        detailVC.id = model.id
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
