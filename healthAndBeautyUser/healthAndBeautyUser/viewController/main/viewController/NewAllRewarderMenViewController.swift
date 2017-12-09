//
//  NewAllRewarderMenViewController.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/10/20.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON
import MJRefresh
import DZNEmptyDataSet

class NewAllRewarderMenViewController: Wx_baseViewController {

    var id = String()
    var pageNo = 1
    var maxPage : NSInteger = 0

    @IBOutlet weak var tableView: UITableView!
    
    var dataSource = [NewRewordListModel]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createNaviController(title: "打赏列表", leftBtn: buildLeftBtn(), rightBtn: nil)
        buildUI()
        buildData()
    }
    
    private func buildUI() {
        
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.register(UINib.init(nibName: "NewRewardListTableViewCell", bundle: nil), forCellReuseIdentifier: "NewRewardListTableViewCell")
        
        weak var weakSelf = self
        tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            
            weakSelf?.pageNo = 1
            weakSelf?.buildData()
        })
        tableView.mj_footer = MJRefreshBackNormalFooter.init(refreshingBlock: {
            
            weakSelf?.pageNo += 1
            weakSelf?.buildData()
        })
    }
    
    func buildData() {
        
        let up = ["id":id,
                  "pageNo":pageNo]
            as [String: Any]
        
        SVPWillShow("载入中...")
        delog(up)
        
        Net.share.getRequest(urlString: CBBGetRewordsJoggle, params: up, success: { (datas) in
            let json = JSON(datas)
            delog(json)
            SVPHide()
            if json["code"].int == 1 {
                let data = json["data"]
                if self.pageNo == 1 {
                    self.dataSource.removeAll()
                }
                self.maxPage = json["data"]["totalPage"].int!
                for (_, subJson):(String, JSON) in data["rewords"] {
                    
                    let model = NewRewordListModel()
                    model.id = subJson["id"].string!
                    model.money = subJson["money"].string!
                    model.createDate = subJson["createDate"].string!
                    let person = subJson["personal"]
                        model.personalid = person["id"].string!
                        model.personalnickName = person["nickName"].string!
                        model.personalphoto = person["photo"].string!
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
    //停止刷新
    func endRefresh() {
        tableView.mj_header.endRefreshing()
    }
}

// MARK: - UITableViewDelegate
extension NewAllRewarderMenViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let me = newMineMeViewController()
        me.id = dataSource[indexPath.row].personalid
        me.isMe = false
        navigationController?.pushViewController(me, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row >= dataSource.count - 3 {
            if pageNo < maxPage {
                pageNo += 1
                buildData()
            }
        }
        let cell : NewRewardListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "NewRewardListTableViewCell", for: indexPath) as! NewRewardListTableViewCell
        cell.model = dataSource[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDataSource
extension NewAllRewarderMenViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
}

// MARK: -
extension NewAllRewarderMenViewController: DZNEmptyDataSetSource,DZNEmptyDataSetDelegate {
    
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
