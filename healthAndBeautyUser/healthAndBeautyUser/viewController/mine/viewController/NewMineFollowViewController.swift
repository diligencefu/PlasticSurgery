//
//  newMineFollowViewController.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/16.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import MJRefresh
import SwiftyJSON
import DZNEmptyDataSet

class NewMineFollowViewController: Wx_baseViewController {

    var type : MineList_MeCellBtnTag?
    let btnView = Wx_scrollerBtnView()
    var isUser = true
    
    lazy var tableView : UITableView = {
        let table = UITableView()
        table.backgroundColor = backGroundColor
        table.delegate = self
        table.dataSource = self
        table.emptyDataSetSource = self
        table.emptyDataSetDelegate = self
        table.tableFooterView = UIView.init()
        table.separatorStyle = .none
        
        table.register(NewMineFollowListTableViewCell.self, forCellReuseIdentifier: "NewMineFollowListTableViewCell")
        
        return table
    }()
    
    var dateSource : [NewMineFollowListModel] = []
    var pageNo = 1
    var maxPage : NSInteger = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        

        buildUI()
        if type == .follow {
            
            createNaviController(title: "我的关注", leftBtn: buildLeftBtn(), rightBtn: nil)
            buildData()
        }else if type == .fans {
            
            createNaviController(title: "我的粉丝", leftBtn: buildLeftBtn(), rightBtn: nil)
            buildFansData()
        }
    }
    
    private func buildUI() {
        
        view.addSubview(btnView)
        _ = btnView.sd_layout()?
            .topSpaceToView(naviView,0)?
            .leftSpaceToView(view,0)?
            .widthIs(WIDTH)?
            .heightIs(GET_SIZE * 86)
        
        btnView.btnArray = ["用户","医生"]
        btnView.currentBtn = 0
        btnView.scrollerViewColor = getColorWithNotAlphe(0xF1931A)
        btnView.scrollerViewHeight = 3.0
        btnView.btnColor = darkText
        btnView.buildUI()
        weak var weakSelf = self
        btnView.callBackBlock { (type) in
            delog(type)
            switch type {
            case "用户":
                weakSelf?.isUser = true
                weakSelf?.buildData()
                break
            case "医生":
                weakSelf?.isUser = false
                weakSelf?.buildData()
                break
            default:
                break
            }
        }
        
        view.addSubview(tableView)
        _ = tableView.sd_layout()?
            .topSpaceToView(btnView,0)?
            .leftSpaceToView(view,0)?
            .rightSpaceToView(view,0)?
            .bottomSpaceToView(view,0)
        tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            
            weakSelf?.pageNo = 1
            if weakSelf?.type == .follow {
                weakSelf?.buildData()
            }else {
                weakSelf?.buildFansData()
            }
        })
        
        if type == .fans {
            
            btnView.removeFromSuperview()
            _ = tableView.sd_layout()?
                .topSpaceToView(naviView,0)?
                .leftSpaceToView(view,0)?
                .rightSpaceToView(view,0)?
                .bottomSpaceToView(view,0)
        }
    }
    
    func buildFansData() {
        
        var up : [String: Any] = ["pageNo":pageNo]
        
        if Defaults.hasKey("SESSIONID") {
            up["mobileCode"] = Defaults["mobileCode"].stringValue
            up["SESSIONID"] = Defaults["SESSIONID"].stringValue
        }else {
            SVPwillShowAndHide("请登录后重新操作")
            present(NewLoginLocationViewController(), animated: true, completion: nil)
            return
        }
        
        SVPWillShow("载入中...")
        delog(up)
            
        Net.share.getRequest(urlString: fanListJoggle, params: up, success: { (datas) in
            let json = JSON(datas)
            delog(json)
            SVPHide()
            if json["code"].int == 1 {
                
                let data = json["data"]
                if self.pageNo == 1 {
                    self.dateSource.removeAll()
                }
                self.maxPage = json["data"]["totalPage"].int!

                //共用一个页面 懒得写 就数据转移一下吧  见着别扭 但是工作量大  能偷懒就偷懒了
                for (_, subJson):(String, JSON) in data["fans"] {
                    
                    let model = NewMineFollowListModel()
                    //粉丝只可能是用户
                    model.isUser = self.isUser
                    model.id = subJson["id"].string!
                    model.followType = subJson["followType"].string!
                    model.concernedBy = subJson["concernedBy"].string!
                    model.isFollow = subJson["isFollow"].bool!

                    let object = subJson["object"]
                    model.userId = object["id"].string!
                    model.nickName = object["nickName"].string!
                    model.photo = object["photo"].string!
                    model.gender = object["gender"].string!
                    model.age = "\(object["age"].int!)"
                    self.dateSource.append(model)
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
    
    func buildData() {
        

        var up : [String: Any] = ["pageNo":pageNo]

        if Defaults.hasKey("SESSIONID") {
            up["mobileCode"] = Defaults["mobileCode"].stringValue
            up["SESSIONID"] = Defaults["SESSIONID"].stringValue
        }else {
            SVPwillShowAndHide("请登录后重新操作")
            present(NewLoginLocationViewController(), animated: true, completion: nil)
            return
        }
        if isUser {
            up["followType"] = 1
        }else {
            up["followType"] = 2
        }
        
        SVPWillShow("载入中...")
        delog(up)
            
        Net.share.getRequest(urlString: followListJoggle, params: up, success: { (datas) in
            let json = JSON(datas)
            delog(json)
            SVPHide()
            if json["code"].int == 1 {
                
                let data = json["data"]
                if self.pageNo == 1 {
                    self.dateSource.removeAll()
                }
                self.maxPage = json["data"]["totalPage"].int!

                for (_, subJson):(String, JSON) in data["follows"] {
                    
                    let model = NewMineFollowListModel()
                    model.isUser = self.isUser
                    model.id = subJson["id"].string!
                    model.followType = subJson["followType"].string!
                    model.concernedBy = subJson["concernedBy"].string!

                    let object = subJson["object"]
                    if self.isUser {
                        //没有用户信息
                        if object["nickName"].string == nil {
                            break
                        }
                        model.userId = object["id"].string!
                        model.nickName = object["nickName"].string!
                        model.photo = object["photo"].string!
                        model.gender = object["gender"].string!
                        model.age = "\(object["age"].int!)"
                    }else {
                        //没有医生信息
                        if object["doctorName"].string == nil {
                            break
                        }
                        model.doctorId = object["id"].string!
                        model.doctorName = object["doctorName"].string!
                        model.headImage = object["headImage"].string!
                        model.sex = object["sex"].string!
                        model.currentPosition = object["currentPosition"].string!
                        if object["doctorPrensent"].string != nil {
                            model.doctorPrensent = object["doctorPrensent"].string!
                        }
                        model.education = object["education"].string!
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
extension NewMineFollowViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return GET_SIZE * 132
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row >= dateSource.count - 3 {
            if pageNo < maxPage {
                pageNo += 1
                if type == .follow {
                    buildData()
                }else {
                    buildFansData()
                }
            }
        }
        var cell:NewMineFollowListTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "NewMineFollowListTableViewCell") as? NewMineFollowListTableViewCell
        if nil == cell {
            cell! = NewMineFollowListTableViewCell.init(style: .default, reuseIdentifier: "NewMineFollowListTableViewCell")
        }
        cell?.selectionStyle = .none
        cell?.model = dateSource[indexPath.row]
        return cell!
    }
}

// MARK: - UITableViewDataSource
extension NewMineFollowViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dateSource.count
    }
}

// MARK: -
extension NewMineFollowViewController: DZNEmptyDataSetSource,DZNEmptyDataSetDelegate {
    
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
