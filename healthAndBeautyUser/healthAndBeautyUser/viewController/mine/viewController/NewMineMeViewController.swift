//
//  newMineMeViewController.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/17.
//  Copyright © 2017年 RXSoft. All rights reserved.

import UIKit
import SwiftyJSON
import MJRefresh
import DZNEmptyDataSet

class newMineMeViewController: Wx_baseViewController {
    
    var id = String()
    
    lazy var tableView : UITableView = {
        let table = UITableView()
        table.backgroundColor = backGroundColor
        table.delegate = self
        table.dataSource = self
        table.emptyDataSetSource = self
        table.emptyDataSetDelegate = self
        table.tableFooterView = UIView.init()
        table.separatorStyle = .none
        
        table.register(NewMineNoteListTableViewCell.self, forCellReuseIdentifier: "NewMineNoteListTableViewCell")
        table.register(NewMainMe_meTableViewCell.self, forCellReuseIdentifier: "NewMainMe_meTableViewCell")
        table.register(NewMineMe_detailTableViewCell.self, forCellReuseIdentifier: "NewMineMe_detailTableViewCell")
        table.register(NewMineMe_didTableViewCell.self, forCellReuseIdentifier: "NewMineMe_didTableViewCell")
        
        return table
    }()
    
    var dateSource : [NewMain_NoteListModel] = []
    var meModel = NewMineMeModel()
    var isLoad = false
    
    let headView : Wx_scrollerBtnView = {
        
        let headView = Wx_scrollerBtnView()
        headView.btnArray = ["主页","发表日记"]
        headView.scrollerViewColor = getColorWithNotAlphe(0xF1931A)
        headView.scrollerViewHeight = 3.0
        headView.btnColor = UIColor.black
        headView.frame = CGRect.init(x: 0, y: 0, width: WIDTH, height: 48)
        headView.buildUI()
        return headView
    }()
    
    override func rightClick() {
        
        navigationController?.pushViewController(NewEditMeViewController(), animated: true)
    }
    
    var isMe = false
    var currentPage = 1
    var pageNo = 1
    var maxPage : NSInteger = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isMe {
            createNaviController(title: "我", leftBtn: buildLeftBtn(), rightBtn: buildRightBtnWithName("编辑资料"))
        }else {
            createNaviController(title: "用户主页", leftBtn: buildLeftBtn(), rightBtn: nil)
        }
        buildUI()
        buildData()
        
        //  接收登录成功的通知
        NotificationCenter.default.addObserver(self, selector: #selector(receiveNitification(nitofication:)), name: NSNotification.Name(rawValue: SuccessRefreshNotificationCenter_Login), object: nil)
        
    }
    
    @objc func receiveNitification(nitofication:Notification) {
        self.tableView.mj_header.beginRefreshing()
    }

    private func buildUI() {
        
        view.backgroundColor = backGroundColor
        
        view.addSubview(tableView)
        _ = tableView.sd_layout()?
            .topSpaceToView(naviView,0)?
            .leftSpaceToView(view,0)?
            .rightSpaceToView(view,0)?
            .bottomSpaceToView(view,0)
        tableView.reloadData()
        weak var weakSelf = self
        tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            weakSelf?.pageNo = 1
            weakSelf?.buildData()
        })
        headView.callBackBlock { (type) in
            
            if type == "主页" {
                weakSelf?.currentPage = 1
            }else {
                weakSelf?.pageNo = 1
                weakSelf?.currentPage = 2
            }
            weakSelf?.buildData()
        }
    }
    //停止刷新
    func endRefresh() {
        tableView.mj_header.endRefreshing()
    }
    
    fileprivate func buildData() {
        
//        //7.4.普通用户个人资料接口：
//        let getPersonalInfoJoggle = "\(cbbNew)madical/m/rongxing/user/getPersonalInfo"
//
//        //7.5.普通用户发表的日记列表接口：
//        let getUserArticlesJoggle = "\(cbbNew)madical/m/rongxing/user/getUserArticles"
        
        var up : [String: Any] = ["id":id]
        
        if Defaults.hasKey("SESSIONID") {
            up["mobileCode"] = Defaults["mobileCode"].stringValue
            up["SESSIONID"] = Defaults["SESSIONID"].stringValue
        }else {
            SVPwillShowAndHide("请登录后重新操作")
            let login = NewLoginLocationViewController.init(nibName: "NewLoginLocationViewController", bundle: nil)
            let loginVC = Wx_baseNaviViewController.init(rootViewController: login)
            self.present(loginVC, animated: true, completion: nil)
            return
        }
        
        SVPWillShow("载入中...")
        delog(up)
        
        if currentPage == 1 {
        
            Net.share.getRequest(urlString: getPersonalInfoJoggle, params: up, success: { (datas) in
                let json = JSON(datas)
                delog(json)
                SVPHide()
                if json["code"].int == 1 {
                    let data = json["data"]
                    self.meModel.isFollow = data["isFollow"].bool!
                    
                    let personal = data["personal"]
                    self.meModel.nickName = personal["nickName"].string!
                    self.meModel.photo = personal["photo"].string!
                    self.meModel.gender = personal["gender"].string!
                    self.meModel.age = "\(personal["age"].int!)"
                    self.meModel.area = personal["area"].string!
                    self.meModel.follow = "\(personal["follow"].int!)"
                    self.meModel.fans = "\(personal["fans"].int!)"
                    self.meModel.integral = "\(personal["integral"].int!)"
                    self.meModel.isMe = self.isMe
                    self.meModel.id = self.id
                    self.meModel.projectClassifys.removeAll()
                    for (_, subJson):(String, JSON) in personal["projectClassifys"] {
                        
                        self.meModel.projectClassifys.append(subJson["name"].string!)
                    }
                    self.isLoad = true
                    self.tableView.reloadData()
                    self.endRefresh()
                }else {
                    SVPwillShowAndHide(json["message"].string!)
                }
            }) { (error) in
                delog(error)
                SVPwillShowAndHide("请检查您的网路")
            }
        }else {
            up["pageNo"] = pageNo

            Net.share.getRequest(urlString: getUserArticlesJoggle, params: up, success: { (datas) in
                let json = JSON(datas)
                delog(json)
                SVPHide()
                if json["code"].int == 1 {
                    
                    if self.pageNo == 1 {
                        self.dateSource.removeAll()
                    }
                    self.maxPage = json["data"]["totalPage"].int!
                    let data = json["data"]
                    for (_ , subJson) : (String , JSON) in data["articleList"] {
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
    }
}

// MARK: - UITableViewDelegate
extension newMineMeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if currentPage == 2 && indexPath.section == 1 {
            let detail = NewNote_DetailVC()
            detail.id = dateSource[indexPath.row].id
            navigationController?.pushViewController(detail, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if isMe {
                return GET_SIZE * 292
            }else {
                return GET_SIZE * 372
            }
        }else if indexPath.section == 1 {
            if currentPage == 1 {
                return GET_SIZE * 346
            }else {
                return GET_SIZE * 640
            }
        }
        if currentPage == 1 {
            if indexPath.section == 2 {
                return GET_SIZE * 300
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            var cell:NewMainMe_meTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "NewMainMe_meTableViewCell") as? NewMainMe_meTableViewCell
            if nil == cell {
                cell! = NewMainMe_meTableViewCell.init(style: .default, reuseIdentifier: "NewMainMe_meTableViewCell")
            }
            cell?.selectionStyle = .none
            cell?.model = meModel
            return cell!
        }else if indexPath.section == 1 {
            if currentPage == 1 {
                var cell:NewMineMe_detailTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "NewMineMe_detailTableViewCell") as? NewMineMe_detailTableViewCell
                if nil == cell {
                    cell! = NewMineMe_detailTableViewCell.init(style: .default, reuseIdentifier: "NewMineMe_detailTableViewCell")
                }
                cell?.selectionStyle = .none
                cell?.model = meModel
                return cell!
            }else {
                
                if indexPath.row >= dateSource.count - 3 {
                    if self.pageNo < self.maxPage {
                        self.pageNo += 1
                        self.buildData()
                    }
                }
                var cell:NewMineNoteListTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "NewMineNoteListTableViewCell") as? NewMineNoteListTableViewCell
                if nil == cell {
                    cell! = NewMineNoteListTableViewCell.init(style: .default, reuseIdentifier: "NewMineNoteListTableViewCell")
                }
                cell?.selectionStyle = .none
                cell?.model = dateSource[indexPath.row]
                return cell!
            }
        }
        if currentPage == 1 {
            if indexPath.section == 2 {
                var cell:NewMineMe_didTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "NewMineMe_didTableViewCell") as? NewMineMe_didTableViewCell
                if nil == cell {
                    cell! = NewMineMe_didTableViewCell.init(style: .default, reuseIdentifier: "NewMineMe_didTableViewCell")
                }
                cell?.selectionStyle = .none
                cell?.model = meModel
                return cell!
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 1 {
            return headView
        }else {
            return UIView()
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 1 {
            return 48
        }
        return 0
    }
}

// MARK: - UITableViewDataSource
extension newMineMeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if !isLoad {
            return 0
        }
        if currentPage == 1 {
            return 3
        }
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else if section == 1 {
            if currentPage == 1 {
                return 1
            }else {
                return dateSource.count
            }
        }
        if currentPage == 1 {
            if section == 2 {
                return 1
            }
        }
        return 0
    }
}

// MARK: -
extension newMineMeViewController: DZNEmptyDataSetSource,DZNEmptyDataSetDelegate {
    
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
