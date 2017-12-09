//
//  NewNoteSelectOrderViewController.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/9/20.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON
import MJRefresh
import DZNEmptyDataSet

var SelectOrderId = String()

class NewNoteSelectOrderViewController: Wx_baseViewController {
    
    //页码
    var pageIndex : NSInteger = 1
    var maxPage : NSInteger = 0

    lazy var tableView : UITableView = {
        let table = UITableView()
        table.backgroundColor = backGroundColor
        table.delegate = self
        table.dataSource = self
        table.tableFooterView = UIView.init()
        table.separatorStyle = .none
        table.emptyDataSetSource = self
        table.emptyDataSetDelegate = self
        
        table.register(NewNoteSelectoOrderTabCell.self, forCellReuseIdentifier: "NewNoteSelectoOrderTabCell")
        
        return table
    }()
    
    var dateSource : [NewChoseOrderModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createNaviController(title: "选择订单", leftBtn: buildLeftBtn(), rightBtn: nil)
        buildUI()
        buildData()
    }
    
    private func buildUI() {
        
        view.backgroundColor = backGroundColor
        
        view.addSubview(tableView)
        _ = tableView.sd_layout()?
            .topSpaceToView(naviView,0)?
            .leftSpaceToView(view,0)?
            .rightSpaceToView(view,0)?
            .bottomSpaceToView(view,0)
        
        weak var weakSelf = self
        tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            weakSelf?.pageIndex = 1
            weakSelf?.buildData()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    fileprivate func buildData() {
        
        let up = ["mobileCode":Defaults["mobileCode"].stringValue,
                  "SESSIONID":Defaults["SESSIONID"].stringValue,
                  "pageNo":pageIndex]
            as [String: Any]
        
        SVPWillShow("载入中...")
        
        Net.share.getRequest(urlString: CBBDiaryOrdersJoggle, params: up, success: { (datas) in
            let json = JSON(datas)
            delog(json)
            SVPHide()
            if json["code"].int == 1 {
                
                self.maxPage = json["data"]["totalPage"].int!
                let data = json["data"]
                
                if self.pageIndex == 1 {
                    self.dateSource.removeAll()
                }
                for (_, subJson):(String, JSON) in data["orders"] {
                    let model = NewChoseOrderModel()

                    model.id = subJson["id"].string!
                    let orderProductChild = subJson["orderProductChild"]
                    model.paidPrice = orderProductChild["residualPrice"].float! + orderProductChild["prepaidPrice"].float!
                    model.orderSettlementDate = orderProductChild["orderSettlementDate"].string!
                    model.num = orderProductChild["num"].int!
                    
                    let project = subJson["project"]
                    model.projectId = project["id"].string!
                    model.projectName = project["projectName"].string!
                    
                    let product = subJson["product"]
                    model.productId = product["id"].string!
                    model.productName = product["productName"].string!
                    model.productChildName = product["productChildName"].string!
                    model.thumbnail = product["thumbnail"].string!
                    
                    for (_, subJson):(String, JSON) in subJson["doctors"] {
                        model.doctor.append(subJson["doctorName"].string!)
                    }
                    self.dateSource.append(model)
                }
                self.tableView.reloadData()
            }else {
                SVPwillShowAndHide(json["message"].string!)
            }
            self.endRefresh()
        }) { (error) in
            delog(error)
            SVPwillShowAndHide("网络连接失败!")
        }
    }
    //停止刷新
    private func endRefresh() {
        
        tableView.mj_header.endRefreshing()
    }
}

// MARK: - UITableViewDelegate
extension NewNoteSelectOrderViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        SelectOrderId = dateSource[indexPath.row].id
        navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return GET_SIZE * 248
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row >= dateSource.count - 3 {
            if self.pageIndex < self.maxPage {
                self.pageIndex += 1
                self.buildData()
            }
        }
        var cell:NewNoteSelectoOrderTabCell? = tableView.dequeueReusableCell(withIdentifier: "NewNoteSelectoOrderTabCell") as? NewNoteSelectoOrderTabCell
        if nil == cell {
            cell! = NewNoteSelectoOrderTabCell.init(style: .default, reuseIdentifier: "NewNoteSelectoOrderTabCell")
        }
        cell?.selectionStyle = .none
        cell?.model = dateSource[indexPath.row]
        return cell!
    }
}

// MARK: - UITableViewDataSource
extension NewNoteSelectOrderViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dateSource.count
    }
}

// MARK: -
extension NewNoteSelectOrderViewController: DZNEmptyDataSetSource,DZNEmptyDataSetDelegate {
    
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
