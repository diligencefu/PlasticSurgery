//
//  FYHGetFreeGoodsViewController.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/25.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class FYHGetFreeGoodsViewController: Base2ViewController {

    var goodModel = FYHShowGetGoodsModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func addHeaderRefresh() {
        
    }
    
    override func configSubViews() {
        
        setupTitleViewSectionStyle(titleStr: "领取实物")
        btnTitle = "领取"
        mainTableView = UITableView.init(frame: CGRect(x: 0,
                                                       y: CGFloat(navHeight),
                                                       width: kSCREEN_WIDTH,
                                                       height: kSCREEN_HEIGHT - 64 ),
                                         style: .grouped)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.estimatedRowHeight = 80
        mainTableView.register(UINib(nibName: "FYHShowCJGooddsCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
        mainTableView.register(UINib.init(nibName: "NewRequireLocationTableViewCell", bundle: nil), forCellReuseIdentifier: identyfierTable1)
        mainTableView.register(UINib.init(nibName: "NewLocationNillTabCell", bundle: nil), forCellReuseIdentifier: identyfierTable2)
        mainTableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        
        self.view.addSubview(mainTableView)
    }
    
    override func rightAction(sender: UIButton) {
        
        if NewPostLocationViewControllerLocationModel.area.count == 0 {
            SVPwillShowAndHide("请选择收货地址")
            return
        }
        
        let params = [
            "mobileCode" : Defaults["mobileCode"].stringValue,
            "SESSIONID" : Defaults["SESSIONID"].stringValue,
            "id":goodModel.id,
            "addressId":NewPostLocationViewControllerLocationModel.id,
        ] as [String:Any]
        SVPWillShow("加载中...")
        self.rightBtn.isEnabled = false
        NetWorkForCollarPrize(params: params) { (flag) in
            if flag {
                SVPwillSuccessShowAndHide("领取成功")
                self.navigationController?.popViewController(animated: true)
            }else{
                self.rightBtn.isEnabled = true
            }
        }
    }
    
    override func refreshHeaderAction() {
        currentPage = 1
        requestData()
    }
    
    
    override func refreshFooterAction() {
        currentPage = currentPage+1
        requestData()
    }

    
    //    ******************代理 ： UITableViewDataSource,UITableViewDelegate  ************
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell : FYHShowCJGooddsCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! FYHShowCJGooddsCell
            cell.setValuesForFYHShowCJGooddsCell(model: goodModel,isGet: true)
            cell.selectionStyle = .none
            return cell
        }else{
            if NewPostLocationViewControllerLocationModel.area.count == 0 {
                
                let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
                cell.textLabel?.text = "请选择地址"
                cell.textLabel?.textColor = kGaryColor(num: 171)
                cell.accessoryType = .disclosureIndicator
                return cell
            }else{
                let cell:NewRequireLocationTableViewCell? = tableView.dequeueReusableCell(withIdentifier: identyfierTable1) as? NewRequireLocationTableViewCell
                cell?.selectionStyle = .none
                cell?.model = NewPostLocationViewControllerLocationModel
                return cell!
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 1 {
            let view = NewPostLocationViewController.init(nibName: "NewPostLocationViewController", bundle: nil)
            navigationController?.pushViewController(view, animated: true)
        }
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
            return 0
        }
        
        return 19 * kSCREEN_SCALE
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01 * kSCREEN_SCALE
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainTableView.reloadData()
    }
    
    
}
