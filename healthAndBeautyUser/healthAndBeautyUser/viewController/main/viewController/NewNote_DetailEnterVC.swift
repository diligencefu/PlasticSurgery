//
//  NewNote_DetailEnterVC.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/9/26.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewNote_DetailEnterVC: Wx_baseViewController {
    
    var articlesId = String()
    var isMe = Bool()
    //是否加载完数据   因为数据结构只有一个列表 定死了 全是除了日记列表外全是1 所以必须得强制写1  如果数据没有请求完就自动刷新页面 会崩溃 所以加载完后修改这个值即可
    var isLoadData = false
    
    lazy var tableView : UITableView = {
        let table = UITableView()
        table.backgroundColor = backGroundColor
        table.delegate = self
        table.dataSource = self
        table.tableFooterView = UIView()
        table.separatorStyle = .none
        
        table.register(NewNote_DetailEnterMessageTableViewCell.self,
                       forCellReuseIdentifier: "NewNote_DetailEnterMessageTableViewCell")
        table.register(NewNote_EnterProjectTableViewCell.self,
                       forCellReuseIdentifier: "NewNote_EnterProjectTableViewCell")
        table.register(NewNote_noteCharAndIMGTabCell.self,
                       forCellReuseIdentifier: "NewNote_noteCharAndIMGTabCell")
        table.register(NewNote_EnterCommentTableViewCell.self,
                       forCellReuseIdentifier: "NewNote_EnterCommentTableViewCell")
        
        return table
    }()
    
    var dateModel = NewNoteEnterDetail_2Model()
    //支付页面
    var payView = NewNoteRewardView()
    
    //当前评价的数据
    var currentContent = String()
    //返回字段
    var returnContent = String()
    //是否是回复
    var isRepeat = Bool()
    //id
    var comment_id = String()
    
    //收藏按钮
    let collection = UIButton()

    //这个是第一次进来的时候  用来增加浏览次数的
    var isFirstWatch : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createNaviController(title: "日记",
                             leftBtn: buildLeftBtn(),
                             rightBtn: buildRightBtnWithIMG(UIImage(named:"share_icon_default")!))
        //收藏按钮
        collection.setImage(UIImage(named:"Collection_icon_default"), for: .normal)
        collection.addTarget(self, action: #selector(collectionBtn), for: .touchUpInside)
        naviView.addSubview(collection)
        _ = collection.sd_layout()?
            .topSpaceToView(naviView,(HEIGHT == 812 ? 44 : 20))?
            .rightSpaceToView(naviView,44)?
            .widthIs(44)?
            .heightIs(44)
        
        buildUI()
        buildData()
    }
    
    let tf = UITextField()
    private func buildUI() {
        
        view.addSubview(tableView)
        _ = tableView.sd_layout()?
            .topSpaceToView(naviView,0)?
            .leftSpaceToView(view,0)?
            .rightSpaceToView(view,0)?
            .bottomSpaceToView(view,(HEIGHT == 812 ? 49+34 : 49))
        
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.white
        view.addSubview(bottomView)
        _ = bottomView.sd_layout()?
            .bottomSpaceToView(view,(HEIGHT == 812 ? 34 : 0))?
            .leftSpaceToView(view,0)?
            .rightSpaceToView(view,0)?
            .heightIs(49)
        
        let line = UIView()
        line.backgroundColor = getColorWithNotAlphe(0xD7D7D7)
        bottomView.addSubview(line)
        _ = line.sd_layout()?
            .topSpaceToView(bottomView,0)?
            .leftSpaceToView(bottomView,0)?
            .rightSpaceToView(bottomView,0)?
            .heightIs(0.5)
        
        let send = UIButton()
        send.setTitle("评论", for: .normal)
        send.backgroundColor = tabbarColor
        send.setTitleColor(UIColor.white, for: .normal)
        send.titleLabel?.font = UIFont.systemFont(ofSize: GET_SIZE * 32)
        send.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        viewRadius(send, 5.0, 0.5, tabbarColor)
        bottomView.addSubview(send)
        _ = send.sd_layout()?
            .rightSpaceToView(bottomView,GET_SIZE * 36)?
            .centerYEqualToView(bottomView)?
            .widthIs(GET_SIZE * 102)?
            .heightIs(GET_SIZE * 68)
        
        tf.backgroundColor = getColorWithNotAlphe(0xF3F3F3)
        tf.borderStyle = .none
        tf.placeholder = "发表评论..."
        tf.delegate = self
        tf.textColor = darkText
        tf.returnKeyType = .done
        bottomView.addSubview(tf)
        _ = tf.sd_layout()?
            .centerYEqualToView(bottomView)?
            .rightSpaceToView(send,GET_SIZE * 36)?
            .leftSpaceToView(bottomView,GET_SIZE * 36)?
            .heightIs(GET_SIZE * 64)
        
        let leftView = UIView()
        leftView.frame = CGRect.init(x: 0, y: 0, width: 20, height: 20)
        tf.leftView = leftView
        tf.leftViewMode = .always
        viewRadius(tf, Float(GET_SIZE * 32), 0.5, backGroundColor)
        
        payView.alpha = 0
        view.addSubview(payView)
        _ = payView.sd_layout()?
            .centerYEqualToView(view)?
            .centerXEqualToView(view)?
            .widthIs(WIDTH)?
            .heightIs(HEIGHT)
    }
    
    private func buildData() {
        
        var up = ["id" : articlesId]
            as [String: Any]
        
        if Defaults.hasKey("SESSIONID") {
            up["mobileCode"] = Defaults["mobileCode"].stringValue
            up["SESSIONID"] = Defaults["SESSIONID"].stringValue
        }
        
        //只有刚进来的一瞬间才需要+1浏览数  之后的刷新都不需要
        if isFirstWatch {
            up["flag"] = "1"
            isFirstWatch = !isFirstWatch
        }else {
            up["flag"] = "0"
        }
        
        SVPWillShow("载入中...")
        delog(up)
        
        Net.share.getRequest(urlString: CBBGetAtricleInfoJoggle, params: up, success: { (datas) in
            
            let json = JSON(datas)
            delog(json)
            SVPHide()
            if json["code"].int == 1 {
                self.dateModel = NewNoteEnterDetail_2Model()
                let data = json["data"]
                for (_,subJson):(String,JSON) in data["dicTags"] {
                    
                    let model = NewNoteEnterDetail_2Model_DicTags()
                    model.id = subJson["id"].string!
                    model.tarContent = subJson["tarContent"].string!
                    self.dateModel.dicTags.append(model)
                }
                for (_,subJson):(String,JSON) in data["comments"] {
                    
                    let model = NewNoteEnterDetail_2Model_Comments()
                    model.id = subJson["id"].string!
                    model.createDate = subJson["createDate"].string!
                    model.content = subJson["content"].string!
                    model.commen = subJson["commen"].string!
                    
                    model.replyCount = subJson["replyCount"].int!
                    if model.replyCount != 0 {
                        for (_,subJson2):(String,JSON) in subJson["replies"] {
                            let model2 = NewNoteEnterDetail_2Model_Replies()
                            model2.id = subJson2["id"].string!
                            model2.createDate = subJson2["createDate"].string!
                            model2.content = subJson2["content"].string!
                            model2.commentId = subJson2["commentId"].string!
                            let user = subJson2["user"]
                            model2.userId = user["id"].string!
                            model2.userName = user["name"].string!
                            model2.admin = user["admin"].boolValue
                            model2.userRoleNames = user["roleNames"].stringValue
                            model.replys.append(model2)
                        }
                    }
                    let personal = subJson["personal"]
                    let personModel = NewNoteDetail_2Model_Personal()
                    personModel.id = personal["id"].string!
                    personModel.follow = personal["follow"].int!
                    personModel.age = personal["age"].int!
                    personModel.userType = personal["userType"].string!
                    personModel.area = personal["area"].string!
                    personModel.article = personal["article"].int!
                    personModel.birthday = personal["birthday"].string!
                    personModel.nickName = personal["nickName"].string!
                    personModel.integral = personal["integral"].int!
                    personModel.fans = personal["fans"].int!
                    personModel.photo = personal["photo"].string!
                    personModel.gender = personal["gender"].string!
                    model.personal = personModel
                    self.dateModel.comments.append(model)
                }
                
                //商品部分
                let product = data["product"]
                self.dateModel.product.id = product["id"].string!
                self.dateModel.product.doctorNames = product["doctorNames"].string!
                self.dateModel.product.createDate = product["createDate"].string!
                self.dateModel.product.productName = product["productName"].string!
                self.dateModel.product.salaPrice = product["salaPrice"].float!
                self.dateModel.product.isDiscount = product["isDiscount"].string!
                self.dateModel.product.disPrice = product["disPrice"].float!
                self.dateModel.product.reservationCount = product["reservationCount"].int!
                self.dateModel.product.productDescrible = product["productDescrible"].string!
                self.dateModel.product.updateDate = product["updateDate"].string!
                self.dateModel.product.thumbnail = product["thumbnail"].string!
                self.dateModel.product.productChildName = product["productChildName"].string!
                self.dateModel.product.reservationPrice = product["reservationPrice"].float!

                //个人信息部分
                let personal = data["personal"]
                self.dateModel.personal.id = personal["id"].string!
                self.dateModel.personal.doneProject = personal["doneProject"].string!
                self.dateModel.personal.follow = personal["follow"].int!
                self.dateModel.personal.age = personal["age"].int!
                self.dateModel.personal.userType = personal["userType"].string!
                self.dateModel.personal.area = personal["area"].string!
                self.dateModel.personal.article = personal["article"].int!
                self.dateModel.personal.birthday = personal["birthday"].string!
                self.dateModel.personal.nickName = personal["nickName"].string!
                self.dateModel.personal.integral = personal["integral"].int!
                self.dateModel.personal.fans = personal["fans"].int!
                self.dateModel.personal.photo = personal["photo"].string!
                self.dateModel.personal.gender = personal["gender"].string!
                
                //日记部分
                let article = data["article"]
                self.dateModel.article.id = article["id"].string!
                self.dateModel.article.comments = article["comments"].string!
                self.dateModel.article.rewards = article["rewards"].string!
                self.dateModel.article.auditState = article["auditState"].string!
                self.dateModel.article.thumbs = article["thumbs"].string!
                self.dateModel.article.createDate = article["createDate"].string!
                self.dateModel.article.imageList = article["imageList"].arrayObject as! [String]
                self.dateModel.article.title = article["title"].string!
                self.dateModel.article.updateDate = article["updateDate"].string!
                self.dateModel.article.diaryId = article["diaryId"].string!
                self.dateModel.article.images = article["images"].string!
                self.dateModel.article.hits = article["hits"].string!
                self.dateModel.article.content = article["content"].string!
                
                //点赞人部分
                for (_, subJson):(String,JSON) in data["personals"] {
                    let model = NewNoteDetail_2Model_Personal()
                    model.id = subJson["id"].string!
                    model.follow = subJson["follow"].int!
                    model.age = subJson["age"].int!
                    model.userType = subJson["userType"].string!
                    model.area = subJson["area"].string!
                    model.article = subJson["article"].int!
                    model.birthday = subJson["birthday"].string!
                    model.nickName = subJson["nickName"].string!
                    model.integral = subJson["integral"].int!
                    model.fans = subJson["fans"].int!
                    model.photo = subJson["photo"].string!
                    model.gender = subJson["gender"].string!
                    self.dateModel.personals.append(model)
                }
                
                //医生详情
                for (_ , subJson) : (String , JSON) in data["docotrs"] {
                    
                    let model = NewNoteDetail_2Model_docotrs()
                    model.doctorName = subJson["doctorName"].string!
                    model.id = subJson["id"].string!
                    model.sex = subJson["sex"].string!
                    model.bespoke = subJson["bespoke"].int!
                    model.cases = subJson["cases"].int!
                    self.dateModel.docotrs.append(model)
                }
                self.dateModel.isThumb = data["isThumb"].bool!
                self.dateModel.isEnshrine = data["isEnshrine"].bool!
                self.dateModel.isReword = data["isReword"].bool!
                self.dateModel.isFollow = data["isFollow"].bool!
                self.dateModel.isMe = self.isMe

                self.isLoadData = true
                self.changeSate()
                self.tableView.reloadData()
                
            }else {
                SVPwillShowAndHide(json["message"].string!)
            }
        }) { (error) in
            delog(error)
            SVPwillShowAndHide("请检查您的网路")
        }
    }
    
    private func changeSate() {
        
        DispatchQueue.main.async {
            
            if self.dateModel.isEnshrine {
                self.collection.setImage(UIImage(named:"Collection_icon_perssed"), for: .normal)
            }else {
                self.collection.setImage(UIImage(named:"Collection_icon_default"), for: .normal)
            }
        }
    }
    
    //作废
    fileprivate func deleteMessage(_ model: String) {
        
        var up = ["comment_id" : model]
            as [String: Any]
        
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
        
        Net.share.getRequest(urlString: DeleteContontJoggle, params: up, success: { (datas) in
            
            let json = JSON(datas)
            delog(json)
            SVPHide()
            if json["code"].int == 1 {
                self.buildData()
            }else {
                SVPwillShowAndHide(json["message"].string!)
            }
        }) { (error) in
            delog(error)
            SVPwillShowAndHide("请检查您的网路")
        }
    }
    
    //作废
    fileprivate func deleteReplyMessage(_ model: String) {
        
        var up = ["Reply_id" : model]
            as [String: Any]
        
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
        
        Net.share.getRequest(urlString: DeleteReplyJoggle, params: up, success: { (datas) in
            
            let json = JSON(datas)
            delog(json)
            SVPHide()
            if json["code"].int == 1 {
                self.buildData()
            }else {
                SVPwillShowAndHide(json["message"].string!)
            }
        }) { (error) in
            delog(error)
            SVPwillShowAndHide("请检查您的网路")
        }
    }
    
    //收藏
    @objc private func collectionBtn() {
        
        var up = ["collectionType":"1",
                  "collection":articlesId]
            as [String: Any]
        
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
        
        if dateModel.isEnshrine {
            up["flag"] = "2"
        }else {
            up["flag"] = "1"
        }
        
        SVPWillShow("载入中...")
        delog(up)
        
        Net.share.postRequest(urlString: saveEnshrineJoggle, params: up, success: { (datas) in
            
            let json = JSON(datas)
            delog(json)
            SVPHide()
            if json["code"].int == 1 {
                
                if self.dateModel.isEnshrine {
                    self.collection.setImage(UIImage(named:"Collection_icon_default"), for: .normal)
                    self.dateModel.isEnshrine = false
                    SVPwillSuccessShowAndHide("取消收藏成功")
                }else {
                    self.collection.setImage(UIImage(named:"Collection_icon_perssed"), for: .normal)
                    self.dateModel.isEnshrine = true
                    SVPwillSuccessShowAndHide("收藏成功")
                }
            }else {
                SVPwillShowAndHide(json["message"].string!)
            }
        }) { (error) in
            delog(error)
            SVPwillShowAndHide("请检查您的网路")
        }
    }
    
    @objc private func sendMessage() {
        
        var up = [String: Any]()
        var url = String()
        
        tf.resignFirstResponder()
        
        if !isRepeat {
            up = ["commenType" : "1",
                  "commen" : articlesId,
                  "content":currentContent]
            url = CBBAddCommentsJoggle
        }else {
            up = ["commentId" : comment_id,
                  "content":currentContent]
            url = CBBAddReplyJoggle
        }
        
        if Defaults.hasKey("SESSIONID") {
            up["mobileCode"] = Defaults["mobileCode"].stringValue
            up["SESSIONID"] = Defaults["SESSIONID"].stringValue
        }else {
            SVPwillShowAndHide("您当前没有登录")
            return
        }
        
        SVPWillShow("载入中...")
        delog(up)
        
        Net.share.postRequest(urlString: url, params: up, success: { (datas) in
            let json = JSON(datas)
            delog(json)
            SVPHide()
            if json["code"].int == 1 {
                self.returnContent = String()
                self.tf.text = ""
                self.buildData()
            }else {
                SVPwillShowAndHide(json["message"].string!)
            }
        }) { (error) in
            delog(error)
            SVPwillShowAndHide("请检查您的网路")
        }
    }
    
    // MARK: 显示打赏页面
    fileprivate func RewardViewData() {
        
        var up = ["rewardType": "1",
                  "rewardSource": articlesId,
                  "id":dateModel.personal.id]
            as [String: Any]
        
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
        
        Net.share.getRequest(urlString: CBBRewordInfoJoggle, params: up, success: { (datas) in
            
            let json = JSON(datas)
            delog(json)
            if json["code"].int == 1 {
//                var balance = Float()
//                var praissedById = String()
//                var praissedByNickName = String()
//                var praissedByPhoto = String()
//                var praissedByGender = String()
//                var maxPrice = Float()
//                var minPrice = Float()
//                var randomMoney = Float()
//                var rewardSource = String()
//                var rewardType = String()
                let data = json["data"]
                let model = NewRewardDetailDataModel()
                model.balance = data["balance"].float!
                model.maxPrice = data["maxPrice"].float!
                model.minPrice = data["minPrice"].float!
                model.randomMoney = data["randomMoney"].float!
                model.rewardSource = data["rewardSource"].string!
                model.rewardType = data["rewardType"].string!
                let praissedBy = data["praissedBy"]
                    model.praissedById = praissedBy["id"].string!
                    model.praissedByNickName = praissedBy["nickName"].string!
                    model.praissedByPhoto = praissedBy["photo"].string!
                self.payView.model = model
                self.checkIsHavePayPassword()
            }else {
                SVPwillShowAndHide(json["message"].string!)
            }
        }) { (error) in
            delog(error)
            SVPwillShowAndHide("请检查您的网路")
        }
    }
    
    private func checkIsHavePayPassword() {
        
        let up = ["mobileCode": Defaults["mobileCode"].stringValue,
                  "SESSIONID": Defaults["SESSIONID"].stringValue]
            as [String: Any]
        
        delog(up)
        Net.share.postRequest(urlString: checkBalance_16_joggle, params: up, success: { (datas) in
            
            let json = JSON(datas)
            delog(json)
            SVPHide()
            if json["code"].int == 1 {
                self.showRewardView()
            }else {
                SVPwillShowAndHide(json["message"].string!)
            }
        }) { (error) in
            delog(error)
            SVPwillShowAndHide("请检查您的网路")
        }
    }
    
    private func showRewardView() {
        
        UIView.animate(withDuration: 0.3) {
            self.payView.alpha = 1
        }
    }
    private func hideRewardView() {
        
        UIView.animate(withDuration: 0.3) {
            self.payView.alpha = 0
        }
    }
}

// MARK: - UITableViewDelegate

extension NewNote_DetailEnterVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 3 {
            comment_id = dateModel.comments[indexPath.row].id
            tf.becomeFirstResponder()
            returnContent = "回复\(dateModel.comments[indexPath.row].personal.nickName):"
            tf.text = returnContent
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return GET_SIZE * (376 - 88)
        }else if indexPath.section == 1 {
            return GET_SIZE * 248
        }else if indexPath.section == 2 {
            
            //术后第几天加浏览评论按钮以及分割线的高
            var height = GET_SIZE * 120

            //日记内容尺寸
            let size = getSizeOnString(dateModel.article.content, 14)
            height += size.height
            height += GET_SIZE * 18
            
            // 中文逗号  不是英文逗号
            let imgViewHeight = GET_SIZE * CGFloat(560 * (dateModel.article.imageList.count) + 16 * (dateModel.article.imageList.count - 1))
            height += imgViewHeight

            if !isMe {
                height += GET_SIZE * 190
            }else {
                height += GET_SIZE * 80
            }
            if dateModel.personals.count != 0 {
                height += GET_SIZE * 140
            }
            return height
        }else {
            
            if dateModel.comments.count == 0 {

                return 0
            }else {

                var sizes = CGSize()
                var height = CGFloat()

                sizes = getSizeOnString(dateModel.comments[indexPath.row].content, 14)
                height += sizes.height + 15

                for index in dateModel.comments[indexPath.row].replys {

                    let tmp = "\(index.userName)回复\(dateModel.comments[indexPath.row].personal.nickName): \(index.content)"
                    sizes = getSizeOnString(tmp, 14)
                    height += sizes.height + 19
                }
                height += GET_SIZE * 120
                height += 25
                return height
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            var cell:NewNote_DetailEnterMessageTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "NewNote_DetailEnterMessageTableViewCell") as? NewNote_DetailEnterMessageTableViewCell
            if nil == cell {
                cell! = NewNote_DetailEnterMessageTableViewCell.init(style: .default, reuseIdentifier: "NewNote_DetailEnterMessageTableViewCell")
            }
            cell?.selectionStyle = .none
            cell?.model = dateModel
            return cell!
        }else if indexPath.section == 1 {
            
            var cell:NewNote_EnterProjectTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "NewNote_EnterProjectTableViewCell") as? NewNote_EnterProjectTableViewCell
            if nil == cell {
                cell! = NewNote_EnterProjectTableViewCell.init(style: .default, reuseIdentifier: "NewNote_EnterProjectTableViewCell")
            }
            cell?.selectionStyle = .none
            cell?.cModel = dateModel
            return cell!
        }else if indexPath.section == 2 {
            
            var cell:NewNote_noteCharAndIMGTabCell? = tableView.dequeueReusableCell(withIdentifier: "NewNote_noteCharAndIMGTabCell") as? NewNote_noteCharAndIMGTabCell
            if nil == cell {
                cell! = NewNote_noteCharAndIMGTabCell.init(style: .default, reuseIdentifier: "NewNote_noteCharAndIMGTabCell")
            }
            cell?.selectionStyle = .none
            cell?.model = dateModel
            weak var weakSelf = self
            cell?.callBackBlock(block: { (type) in
                if type == "reward" {
                    weakSelf?.RewardViewData()
                }
            })
            return cell!
        }else {
            
            var cell:NewNote_EnterCommentTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "NewNote_EnterCommentTableViewCell") as? NewNote_EnterCommentTableViewCell
            if nil == cell {
                cell! = NewNote_EnterCommentTableViewCell.init(style: .default, reuseIdentifier: "NewNote_EnterCommentTableViewCell")
            }
            cell?.selectionStyle = .none
            cell?.model = dateModel.comments[indexPath.row]
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if section != 1 {
            return UIView()
        }
        let foot = UIView()
        foot.backgroundColor = lineColor
        return foot
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section != 1 {
            return 0
        }
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section != 1 {
            return UIView()
        }
        
        let head = UIView()
        head.backgroundColor = backGroundColor
        head.frame = CGRect.init(x: 0, y: 0, width: WIDTH, height: 44)
        
        let icon = UIImageView()
        
        let title = UILabel()
        title.textColor = darkText
        title.font = UIFont.systemFont(ofSize: TEXT32)
        
        icon.image = UIImage(named:"project_icon_default")
        title.text = "相关项目"
        head.addSubview(icon)
        _ = icon.sd_layout()?
            .centerYEqualToView(head)?
            .leftSpaceToView(head,GET_SIZE * 26)?
            .widthIs(GET_SIZE * 36)?
            .heightIs(GET_SIZE * 36)
        
        head.addSubview(title)
        _ = title.sd_layout()?
            .centerYEqualToView(head)?
            .leftSpaceToView(icon,GET_SIZE * 24)?
            .widthIs(WIDTH/2)?
            .heightIs(GET_SIZE * 36)
        return head
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section != 1 {
            return 0
        }
        return 44
    }
}

// MARK: - UITableViewDataSource
extension NewNote_DetailEnterVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if !isLoadData {
            return 0
        }
        if dateModel.comments.count == 0 {
            return 3
        }else {
            return 4
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if !isLoadData {
            return 0
        }
        
        if section <= 2 {
            return 1
        }
        return dateModel.comments.count
    }
}

// MARK: - UITableViewDataSource
extension NewNote_DetailEnterVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        view.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        currentContent = textField.text!
        
        //如果对（回复日记回复人）删除了空格，那么就不是回复了。
        if currentContent.components(separatedBy: returnContent).count > 1 {
            isRepeat = true
        }else {
            isRepeat = false
        }
        if isRepeat {
            
            currentContent = currentContent.replacingOccurrences(of: returnContent, with: "")
        }
    }
}
