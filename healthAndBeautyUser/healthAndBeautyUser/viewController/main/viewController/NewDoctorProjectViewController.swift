//
//  NewDoctorProjectViewController.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/10/21.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON
import MJRefresh
import DZNEmptyDataSet

class NewDoctorProjectViewController: Wx_baseViewController {

    var doctorID = String()
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource = [NewMain_NoteListModel]()
    var pageIndex : Int = 1
    var maxPage : NSInteger = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createNaviController(title: "医生案例", leftBtn: buildLeftBtn(), rightBtn: nil)
        buildUI()
        buildData()
    }
    
    private func buildUI() {
        
        tableView.register(NewMineNoteListTableViewCell.self, forCellReuseIdentifier: "NewDoctorProjectViewController")
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
        
        Net.share.getRequest(urlString: CBBGetDoctorArticlesJoggle, params: up, success: { (datas) in
            let json = JSON(datas)
            delog(json)
            SVPHide()
            if json["code"].int == 1 {
                self.maxPage = json["data"]["totalPage"].int!
                if self.pageIndex == 1 {
                    self.dataSource.removeAll()
                }
                let data = json["data"]
                for (_, subJson):(String, JSON) in data["articleList"] {
                    let model = NewMain_NoteListModel()
                    model.id = subJson["id"].string!
                    model.preopImages = subJson["preopImages"].string!
                    model.allowFollow = subJson["allowFollow"].bool!
                    model.follow = subJson["follow"].bool!
                    let personal = subJson["personal"]
                    model.personald = personal["id"].string!
                    model.nickName = personal["nickName"].string!
                    model.photo = personal["photo"].string!
                    model.gender = personal["gender"].string!
                    let article = subJson["article"]
                    model.aId = article["id"].string!
                    model.content = article["content"].string!
                    model.images = article["images"].string!
                    model.createDate = article["createDate"].string!
                    model.comments = article["comments"].string!
                    model.thumbs = article["thumbs"].string!
                    model.hits = article["hits"].string!
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
extension NewDoctorProjectViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let detail = NewNote_DetailVC()
        detail.id = dataSource[indexPath.row].id
        navigationController?.pushViewController(detail, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return GET_SIZE * 640
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row >= dataSource.count - 3 {
            if self.pageIndex < self.maxPage {
                self.pageIndex += 1
                self.buildData()
            }
        }
        var cell:NewMineNoteListTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "NewDoctorProjectViewController") as? NewMineNoteListTableViewCell
        if nil == cell {
            cell! = NewMineNoteListTableViewCell.init(style: .default, reuseIdentifier: "NewDoctorProjectViewController")
        }
        cell?.selectionStyle = .none
        cell?.model = dataSource[indexPath.row]
        cell?.follow.isHidden = true
        return cell!
    }
}

// MARK: - UITableViewDataSource
extension NewDoctorProjectViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataSource.count
    }
}

// MARK: -
extension NewDoctorProjectViewController: DZNEmptyDataSetSource,DZNEmptyDataSetDelegate {
    
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
