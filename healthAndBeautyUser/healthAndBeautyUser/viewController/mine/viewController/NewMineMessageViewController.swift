//
//  newMineMessageViewController.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/17.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewMineMessageViewController: Wx_baseViewController {
    
    let topView = Wx_scrollerBtnView()
    
    var pageNum = 1
    var messageType = 1
    
    lazy var tableView : UITableView = {
        let table = UITableView()
        table.backgroundColor = backGroundColor
        table.delegate = self
        table.dataSource = self
        table.tableFooterView = UIView()
        table.separatorStyle = .none
        
        table.estimatedRowHeight = 80
        
        table.register(NewMineMessage_privateLetter_noticeTableViewCell.self, forCellReuseIdentifier: "NewMineMessage_privateLetter_noticeTableViewCell")
        table.register(NewMineMessage_assitTableViewCell.self, forCellReuseIdentifier: "NewMineMessage_assitTableViewCell")
        table.register(NewMineMessage_CommentTableViewCell.self, forCellReuseIdentifier: "NewMineMessage_CommentTableViewCell")

        table.register(UINib.init(nibName: "FYHShowMessagesCell", bundle: nil), forCellReuseIdentifier: "FYHShowMessagesCell")
        table.register(UINib.init(nibName: "FYHMineShowNitifCell", bundle: nil), forCellReuseIdentifier: "FYHMineShowNitifCell")

        return table
    }()
    
    var modelSource = NSMutableArray()
    var assitSource = NSMutableArray()
    var newFansSource = NSMutableArray()
    var commentSource = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createNaviController(title: "我的消息", leftBtn: buildLeftBtn(), rightBtn: nil)
        buildUI()
//        requestData()
    }
    
    private func buildUI() {
        
        view.backgroundColor = backGroundColor
        
        view.addSubview(topView)
        _ = topView.sd_layout()?
            .topSpaceToView(naviView,0)?
            .leftSpaceToView(view,0)?
            .widthIs(WIDTH)?
            .heightIs(GET_SIZE * 86)
        
        topView.btnArray = ["评论","赞","新粉丝","通知"]
        topView.scrollerViewColor = getColorWithNotAlphe(0xF1931A)
        topView.scrollerViewHeight = 3.0
        topView.btnColor = UIColor.black
        topView.buildUI()
        topView.callBackBlock { (type) in
            self.buildData()
        }
        
        view.addSubview(tableView)
        _ = tableView.sd_layout()?
            .topSpaceToView(topView,0)?
            .leftSpaceToView(view,0)?
            .rightSpaceToView(view,0)?
            .bottomSpaceToView(view,0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        buildData()
    }
    
    private func buildData() {
        
        if !Defaults.hasKey("SESSIONID") {
            SVPwillShowAndHide("请登录后重新操作")
            let login = NewLoginLocationViewController.init(nibName: "NewLoginLocationViewController", bundle: nil)
            let loginVC = Wx_baseNaviViewController.init(rootViewController: login)
            self.present(loginVC, animated: true, completion: nil)
            return
        }

        pageNum = 1
        switch topView.currentBtn {
            
        case 0:
            commentSource.removeAllObjects()
            messageType = 2
            requestData()
//            commentSource.removeAll()
//            buildCommentModel()
            break
        case 1:
            assitSource.removeAllObjects()
            messageType = 1
            requestData()
//            完成
//            buildAssitModel()
            break
        case 2:
            newFansSource.removeAllObjects()
            messageType = 3
            requestData()
//            完成
//            requestDataForFans()
            break
        case 3:
            
            modelSource.removeAllObjects()
            requestDataForNoti()
            //            完成
            //            requestDataForFans()
            break

        default:
            break
        }
        tableView.reloadData()
    }
    
   private func requestData() {
        let params = [
            "mobileCode":Defaults["mobileCode"].stringValue,
            "SESSIONID":Defaults["SESSIONID"].stringValue,
            "pageNo":pageNum,
            "messageType":String(messageType),
            ] as [String : Any]
        SVPWillShow("加载中")
        NetWorkForUseMessages(params: params,type:messageType) { (datas, pages, flag) in
            if flag {
//                if self.pageNum >= Int(pages)! {
////                    self.tableView.mj_footer.endRefreshingWithNoMoreData()
//                }else{
                
                    if self.messageType == 1 {
                        self.assitSource.addObjects(from: datas)
                    }
                    if self.messageType == 2 {
                        self.commentSource.addObjects(from: datas)
                    }
                    if self.messageType == 3 {
                        self.newFansSource.addObjects(from: datas)
                    }
                    self.tableView.reloadData()
//                    self.tableView.mj_footer.endRefreshing()
//                }
            }
            SVPHide()
        }
    }
    
    
    func requestDataForNoti() {
        
        SVPWillShow("加载中")
        let params = [
            "mobileCode":Defaults["mobileCode"].stringValue,
            "SESSIONID":Defaults["SESSIONID"].stringValue,
            "pageNo":pageNum
            ] as [String : Any]
        NetWorkForUseNotifies(params: params) { (datas, pages, flag) in
            if flag {
                self.modelSource.addObjects(from: datas)
                self.tableView.reloadData()
            }
            SVPHide()
        }
    }
    
    
//    var modelSource : [newMineMessageModel] = []
//    var assitSource : [newMineMessageAssitModel] = []
//    var commentSource : [newMineMessageCommentModel] = []
    
//    private func requestDataForFans(){
//
//        let params = [
//            "mobileCode":Defaults["mobileCode"].stringValue,
//            "SESSIONID":Defaults["SESSIONID"].stringValue,
//            "pageNo":pageNum
//            ] as [String : Any]
//        NetWorkForNewFansList(params: params, type: <#NSInteger#>) { (datas, pageNum, flag) in
//            if flag {
//                self.newFansSource.removeAllObjects()
//                self.newFansSource.addObjects(from: datas)
//                self.tableView.reloadData()
//            }
//        }
//    }
//
//
//    private func buildModel() {
//        for _ in 0...10 {
//            let model = NewMineMessageModel()
//            model.head = "banner_240"
//            model.name = "徐大壮"
//            model.time = "5天前"
//            model.detail = "commentSource : [newMineMessageCommentModel] = []"
//            modelSource.append(model)
//        }
//    }
    
//    点赞列表
//    private func buildAssitModel() {
//
//        let params = [
//            "mobileCode":Defaults["mobileCode"].stringValue,
//            "SESSIONID":Defaults["SESSIONID"].stringValue,
//            "pageNo":pageNum
//            ] as [String : Any]
//        NetWorkForthumbList(params: params) { (datas, pageNum, flag) in
//            if flag {
//                self.assitSource.removeAllObjects()
//                self.assitSource.addObjects(from: datas)
//                self.tableView.reloadData()
//            }
//        }
//    }
    
////    评论列表
//    private func buildCommentModel() {
//        for _ in 0...10 {
//            let model = NewMineMessageCommentModel()
//            model.head = "banner_240"
//            model.name = "李4"
//            model.time = "4小时前"
//            model.detail = "我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁我是谁"
//            model.repeatComment = "adfasdhjkasdjkjdsvnjknadvadlkjvb jksdbfvjhhbsdvisdvh"
//            commentSource.append(model)
//        }
//    }
}

// MARK: - UITableViewDelegate
extension NewMineMessageViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if topView.currentBtn == 3 {
            let model = modelSource[indexPath.row] as! FYHShowNotiModel
            if model.isRead == "1" {
                return
            }
            let params = [
                "mobileCode":Defaults["mobileCode"].stringValue,
                "SESSIONID":Defaults["SESSIONID"].stringValue,
                "id":model.id
                ] as [String : Any]
            NetWorkForReadNotify(params: params) { ( flag) in
             
                if flag {
                    self.modelSource.removeAllObjects()
                    self.requestDataForNoti()
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if topView.currentBtn == 3 {
            let model = modelSource[indexPath.section] as! FYHShowNotiModel
            let cell : FYHMineShowNitifCell = tableView.dequeueReusableCell(withIdentifier: "FYHMineShowNitifCell", for: indexPath) as! FYHMineShowNitifCell
            cell.setValuesForFYHMineShowNitifCell(model: model)
            cell.selectionStyle = .none
            return cell

        }else{
            var model = FYHMineMessgeAllModel()
            
            if messageType == 1 {
                model = assitSource[indexPath.section] as! FYHMineMessgeAllModel
            }
            if messageType == 2 {
                model = commentSource[indexPath.section] as! FYHMineMessgeAllModel
            }
            if messageType == 3 {
                model = newFansSource[indexPath.section] as! FYHMineMessgeAllModel
            }
            
            let cell : FYHShowMessagesCell = tableView.dequeueReusableCell(withIdentifier: "FYHShowMessagesCell", for: indexPath) as! FYHShowMessagesCell
            cell.setValuesForFYHShowMessagesCell(model: model, type: messageType)
            cell.selectionStyle = .none
            return cell

        }
        
//        switch topView.currentBtn {
//        case -1,3:
//            var cell:NewMineMessage_privateLetter_noticeTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "NewMineMessage_privateLetter_noticeTableViewCell") as? NewMineMessage_privateLetter_noticeTableViewCell
//            if nil == cell {
//                cell! = NewMineMessage_privateLetter_noticeTableViewCell.init(style: .default, reuseIdentifier: "NewMineMessage_privateLetter_noticeTableViewCell")
//            }
//            cell?.selectionStyle = .none
////            cell?.model = modelSource[indexPath.row]
//            return cell!
//        case 0:
//            var cell:NewMineMessage_CommentTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "NewMineMessage_CommentTableViewCell") as? NewMineMessage_CommentTableViewCell
//            if nil == cell {
//                cell! = NewMineMessage_CommentTableViewCell.init(style: .default, reuseIdentifier: "NewMineMessage_CommentTableViewCell")
//            }
//            cell?.selectionStyle = .none
////            cell?.model = commentSource[indexPath.row]
//            return cell!
//        case 1:
//            var cell:NewMineMessage_assitTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "NewMineMessage_assitTableViewCell") as? NewMineMessage_assitTableViewCell
//            if nil == cell {
//                cell! = NewMineMessage_assitTableViewCell.init(style: .default, reuseIdentifier: "NewMineMessage_assitTableViewCell")
//            }
//            cell?.selectionStyle = .none
//            cell?.model = assitSource[indexPath.row] as? NewMineMessageAssitModel
//            return cell!
//        case 2:
//            var cell:NewMineMessage_privateLetter_noticeTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "NewMineMessage_privateLetter_noticeTableViewCell") as? NewMineMessage_privateLetter_noticeTableViewCell
//            if nil == cell {
//                cell! = NewMineMessage_privateLetter_noticeTableViewCell.init(style: .default, reuseIdentifier: "NewMineMessage_privateLetter_noticeTableViewCell")
//            }
//            cell?.selectionStyle = .none
//            cell?.SetValueWithModel(model: newFansSource[indexPath.row] as! NewMineMessageAssitModel)
//            return cell!
//
//        default:
//            break
//        }
//        return UITableViewCell()
        
        
    }
}

// MARK: - UITableViewDataSource
extension NewMineMessageViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        switch topView.currentBtn {
        case -1,3:
            return modelSource.count
        case 0:
            return commentSource.count
        case 1:
            return assitSource.count
        case 2:
            return newFansSource.count
        default:
            return 1
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        if topView.currentBtn == 1 {
            return true
        }
        return false
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let model = assitSource[indexPath.row] as! NewMineMessageAssitModel
        if editingStyle == .delete {
            let params = [
                "mobileCode":Defaults["mobileCode"].stringValue,
                "SESSIONID":Defaults["SESSIONID"].stringValue,
                "id":model.personal.id
                ] as [String : Any]
            NetWorkForDeletethumbList(params: params, callBack: { (flag) in
                if flag {
                    self.assitSource.remove(model)
                    tableView.reloadData()
                }else{
                    SVPwillShowAndHide("删除失败")
                }
            })
        }
    }
    
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        
        return "删除"
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init()
        view.backgroundColor = getColorWithNotAlphe(0xEEEEEE)
        return view    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section != 0{
            return 12*kSCREEN_SCALE
        }
        return 0
    }

    
    
}
