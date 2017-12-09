//
//  NewDoctorAppointtmentViewController.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/10/21.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON
import MJRefresh
import DZNEmptyDataSet

class NewDoctorAppointtmentViewController: Wx_baseViewController {

    var doctorID = String()
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource = [NewMain_ProjectListModel]()
    var pageIndex : Int = 1
    var maxPage : NSInteger = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createNaviController(title: "医生预约", leftBtn: buildLeftBtn(), rightBtn: nil)
        buildUI()
        buildData()
    }

    private func buildUI() {
        
        tableView.register(NewMainCaseListTableViewCell.self, forCellReuseIdentifier: "NewMainCaseListTableViewCell")
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        
        weak var weakSelf = self
        tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            weakSelf?.pageIndex = 1
            weakSelf?.buildData()
        })
    }
    
    fileprivate func buildData() {
        
        var up = ["id":doctorID,
                  "pageNo":pageIndex]
            as [String: Any]
        
        if Defaults.hasKey("SESSIONID") {
            up["mobileCode"] = Defaults["mobileCode"].stringValue
            up["SESSIONID"] = Defaults["SESSIONID"].stringValue
        }
        
        SVPWillShow("载入中...")
        delog(up)
        
        Net.share.getRequest(urlString: CBBGetDoctorProductsJoggle, params: up, success: { (datas) in
            let json = JSON(datas)
            delog(json)
            SVPHide()
            if json["code"].int == 1 {
                
                self.maxPage = json["data"]["totalPage"].int!
                if self.pageIndex == 1 {
                    self.dataSource.removeAll()
                }
                let data = json["data"]
                for (_, subJson):(String, JSON) in data["products"] {
                    let model = NewMain_ProjectListModel()
                    model.isAD = false
                    model.id = subJson["id"].string!
                    model.thumbnail = subJson["thumbnail"].string!
                    model.salaPrice = subJson["salaPrice"].float!
                    model.productName = subJson["productName"].string!
                    model.productChildName = subJson["productChildName"].string!
                    model.reservationPrice = subJson["reservationPrice"].float!
                    model.disPrice = subJson["disPrice"].float!
                    model.reservationCount = "\(subJson["reservationCount"].int!)"
                    model.doctorNames = subJson["doctorNames"].string!
                    self.dataSource.append(model)
                }
                self.tableView.reloadData()
            }else {
                SVPwillShowAndHide(json["message"].string!)
            }
            self.endRefresh()
        }) { (error) in
            delog(error)
            SVPwillShowAndHide("请检查您的网路")
            self.endRefresh()
        }
    }
    
    private func endRefresh() {
        tableView.mj_header.endRefreshing()
    }
}

// MARK: - UITableViewDelegate
extension NewDoctorAppointtmentViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detail = NewStoresDetailViewController.init(nibName: "NewStoresDetailViewController", bundle: nil)
        detail.isProject = true
        detail.id = dataSource[indexPath.row].id
        navigationController?.pushViewController(detail, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return GET_SIZE * 246
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row >= dataSource.count - 3 {
            if self.pageIndex < self.maxPage {
                self.pageIndex += 1
                self.buildData()
            }
        }
        var cell:NewMainCaseListTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "NewMainCaseListTableViewCell") as? NewMainCaseListTableViewCell
        if nil == cell {
            cell! = NewMainCaseListTableViewCell.init(style: .default, reuseIdentifier: "NewMainCaseListTableViewCell")
        }
        cell?.selectionStyle = .none
        cell?.model = dataSource[indexPath.row]
        return cell!
    }
}

// MARK: - UITableViewDataSource
extension NewDoctorAppointtmentViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataSource.count
    }
}

// MARK: -
extension NewDoctorAppointtmentViewController: DZNEmptyDataSetSource,DZNEmptyDataSetDelegate {
    
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
