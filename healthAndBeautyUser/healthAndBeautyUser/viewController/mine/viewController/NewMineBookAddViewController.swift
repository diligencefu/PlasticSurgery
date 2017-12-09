//
//  NewMineBookAddViewController.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/10/28.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON
import MJRefresh
import DZNEmptyDataSet

class NewMineBookAddViewController: Wx_baseViewController {
    
    lazy var tableView : UITableView = {
        
        let table = UITableView()
        table.backgroundColor = backGroundColor
        table.delegate = self
        table.dataSource = self
        table.emptyDataSetSource = self
        table.emptyDataSetDelegate = self
        
        table.tableFooterView = UIView.init()
        table.separatorStyle = .none
        
        table.register(UINib.init(nibName: "NewDiscountBookTabCell", bundle: nil), forCellReuseIdentifier: "NewDiscountBookTabCell")

        return table
    }()
    
    var dateSource : [NewMineBookCenterModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createNaviController(title: "领券中心", leftBtn: buildLeftBtn(), rightBtn: nil)
        buildUI()
        buildData()
    }
    
    private func buildUI() {
        
        view.addSubview(tableView)
        _ = tableView.sd_layout()?
            .topSpaceToView(naviView,0)?
            .leftSpaceToView(view,0)?
            .rightSpaceToView(view,0)?
            .bottomSpaceToView(view,0)
    }
    
    
    public func buildData() {
        
        var up = [:]
            as [String: Any]
        
        if Defaults.hasKey("SESSIONID") {
            up["mobileCode"] = Defaults["mobileCode"].stringValue
            up["SESSIONID"] = Defaults["SESSIONID"].stringValue
        }
        SVPWillShow("载入中...")
        delog(up)
        
        Net.share.getRequest(urlString: couponList_39_joggle, params: up, success: { (datas) in
            let json = JSON(datas)
            delog(json)
            SVPHide()
            if json["code"].int == 1 {
                
                let data = json["data"]
                self.dateSource.removeAll()
                for (_, subJson):(String, JSON) in data["coupons"] {
                    let model = NewMineBookCenterModel()
                    model.id = subJson["id"].string!
                    model.couponName = subJson["couponName"].string!
                    model.counponAmount = subJson["counponAmount"].int!
                    model.counponStartDate = subJson["counponStartDate"].string!
                    model.couponEndDate = subJson["couponEndDate"].string!
                    model.counponKind = subJson["counponKind"].string!
                    model.counponUsingRange = subJson["counponUsingRange"].string!
                    if subJson["projectNames"].string != nil {
                        model.projectNames = subJson["projectNames"].string!
                    }
                    model.counponExplain = subJson["counponExplain"].string!
                    model.collarNum = subJson["collarNum"].int!
                    model.meetPrice = subJson["meetPrice"].float!
                    self.dateSource.append(model)
                }
                self.tableView.reloadData()
            }else {
                SVPwillShowAndHide(json["message"].string!)
            }
        }) { (error) in
            delog(error)
            SVPwillShowAndHide("请检查您的网路")
        }
    }
}

// MARK: - UITableViewDelegate
extension NewMineBookAddViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : NewDiscountBookTabCell! = tableView.dequeueReusableCell(withIdentifier: "NewDiscountBookTabCell", for: indexPath) as! NewDiscountBookTabCell
        cell.selectionStyle = .none
        cell.getBookModel = dateSource[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDataSource
extension NewMineBookAddViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dateSource.count
    }
}

// MARK: -
extension NewMineBookAddViewController: DZNEmptyDataSetSource,DZNEmptyDataSetDelegate {
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        
        return UIImage(named:"no-data_icon")
    }
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        
        let titles = "没有数据"
        let attributs = [NSFontAttributeName:UIFont.systemFont(ofSize: 16),
                         NSForegroundColorAttributeName:darkText]
        return NSAttributedString.init(string: titles, attributes: attributs)
    }
}
