//
//  FYHSearchViewController.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/27.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

@objc protocol SearchBeginDelegate {
    
    func addSearchRecord(key:String)
}

class FYHSearchViewController: Base2ViewController,UITextFieldDelegate {
    
    var delegate : SearchBeginDelegate?
    
    var searchTextfield = UITextField()
    
    var typeArr = ["综合","案例","项目","商品","医生","用户"]
    var underLine = UIView()
    var headView = UIView()
    var currentIndex = 1

    var totalDatas = [Array<Any>]()
    var totalMarks = [String]()

    var caseDatas =     [NewMain_NoteListModel]()
    var projectDatas =  [NewStoreProjectModel]()
    var goodsDatas =    [NewStoreGoodsModel]()
    var doctorDatas =   [NewMineFollowListModel]()
    var userDatas =     [NewMineFollowListModel]()
    
    public var searchKey = ""
    
    let identyfierTable3 = "identyfierTable3"
    
    
    var touchedSection = 100
    
//    回调搜索内容
    var searchRecordBlock:((String)->())?  //声明闭包

//    空数据
    var emptyView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        addImageWhenEmpty()
    }
    
    
    override func configSubViews() {
        
        //        密码
        searchTextfield.frame = CGRect(x: 30, y: (navHeight-32)/2, width: Int(kSCREEN_WIDTH - 110)+10, height: 30)
        searchTextfield.borderStyle = .none
        searchTextfield.leftViewRect(forBounds: CGRect(x: 0, y: 0, width: 26, height: 17))
        searchTextfield.placeholder = "搜一搜"
        searchTextfield.leftViewMode = .always
        searchTextfield.returnKeyType = .search
        searchTextfield.delegate = self
        searchTextfield.textColor = kGaryColor(num: 69)
        searchTextfield.font = kFont32
        searchTextfield.backgroundColor = kGaryColor(num: 233)
        searchTextfield.clipsToBounds = true
        searchTextfield.layer.cornerRadius = 3
        searchTextfield.centerY = rightBtn.centerY
        searchTextfield.centerX = navigaView.centerX-10
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: 26, height: 17))
        
        let leftImage = UIImageView.init(frame: CGRect(x: 8, y: 0, width: 17, height: 17))
        leftImage.image = UIImage.init(named: "16_search")
        
        view.addSubview(leftImage)
        searchTextfield.leftView = view
        searchTextfield.text = searchKey
        self.navigaView.addSubview(searchTextfield)
        btnTitle = "搜索"
        
//        顶部选择栏
        headView = UIView.init(frame: CGRect(x: 0, y: CGFloat(navHeight), width: kSCREEN_WIDTH, height: 80*kSCREEN_SCALE))
        headView.backgroundColor = UIColor.white
        
        let kHeight = CGFloat(80 * kSCREEN_SCALE)
        var contentWidth = CGFloat()
        var totalWidth = CGFloat()
        
        //MARK: 因为按钮字数不一样，长短有别，所以我先看看一共有多长再平分space
        for index in 0...typeArr.count-1{
            let kWidth = getSizeOnString(typeArr[index], Int(32*kSCREEN_SCALE)).width+10
            totalWidth += kWidth
        }
        let kSpace = CGFloat(kSCREEN_WIDTH - totalWidth)/CGFloat(typeArr.count+1)
        for index in 0..<typeArr.count{
            
            let kWidth = getSizeOnString(typeArr[index], Int(32*kSCREEN_SCALE)).width+10
            
            let markBtn = UIButton.init(frame: CGRect(x: kSpace + (contentWidth + kSpace * CGFloat(index)) , y: 0, width: kWidth, height: kHeight))
            //            markBtn.center.y = headView.center.y
            markBtn.setTitle(typeArr[index], for: .normal)
            markBtn.setTitleColor(kGaryColor(num: 117), for: .normal)
            markBtn.titleLabel?.font = kFont28
            markBtn.addTarget(self, action: #selector(goodAtProject(sender:)), for: .touchUpInside)
            contentWidth += kWidth
            markBtn.tag = 131 + index
            headView.addSubview(markBtn)
        }
        
        let view1 = headView.viewWithTag(131) as! UIButton
        view1.setTitleColor(kMainColor(), for: .normal)
        underLine = UIView.init(frame: CGRect(x: 0, y: 80 * kSCREEN_SCALE - 3, width:getSizeOnString(typeArr[0], Int(32*kSCREEN_SCALE)).width - 5, height: 2))
        underLine.backgroundColor = kMainColor()
        underLine.layer.cornerRadius = 1
        underLine.clipsToBounds = true
        underLine.center.x = view1.center.x
        headView.addSubview(underLine)
        self.view.addSubview(headView)
        
        mainTableView = UITableView.init(frame: CGRect(x: 0,
                                                       y: 80*kSCREEN_SCALE+CGFloat(navHeight),
                                                       width: kSCREEN_WIDTH,
                                                       height: kSCREEN_HEIGHT - 64-80*kSCREEN_SCALE),
                                         style: .grouped)
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.estimatedRowHeight = 44
        
        mainTableView.register(NewMineNoteListTableViewCell.self, forCellReuseIdentifier: "NewMineNoteListTableViewCell")
        mainTableView.register(NewStoreListTabCell.self, forCellReuseIdentifier: "NewStoreListTabCell")
        mainTableView.register(NewMineFollowListTableViewCell.self, forCellReuseIdentifier: "NewMineFollowListTableViewCell")
        
        self.view.addSubview(mainTableView)
        mainTableView.backgroundColor = kSetRGBColor(r: 239, g: 239, b: 244)
    }
    
    
    //MARK:   顶部选择栏选择事件
    @objc func goodAtProject(sender:UIButton) {
        
        let view = headView.viewWithTag(currentIndex+130) as! UIButton
        
        if view == sender {
            return
        }
        view.setTitleColor(kGaryColor(num: 117), for: .normal)
        sender.setTitleColor(kMainColor(), for: .normal)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.underLine.bounds.size.width = getSizeOnString((sender.titleLabel?.text)!, Int(32*kSCREEN_SCALE)).width-5
            
            self.underLine.center = CGPoint(x:  sender.center.x, y:  self.underLine.center.y)
        })
        
        currentIndex = sender.tag - 130
        
        self.totalDatas.removeAll()
        self.caseDatas.removeAll()
        self.projectDatas.removeAll()
        self.goodsDatas.removeAll()
        self.doctorDatas.removeAll()
        self.userDatas.removeAll()
        
        requestData()
        
        mainTableView.reloadData()
    }

    
    override func addHeaderRefresh() {
        
    }
    
    override func requestData() {
        
        var params = [String:Any]()
        if currentIndex==1 {
            
            params = [
                "mobileCode" : Defaults["mobileCode"].stringValue,
                "SESSIONID" : Defaults["SESSIONID"].stringValue,
                "keyWords" : searchKey
            ]
        }else{
            
            params = [
                "mobileCode" : Defaults["mobileCode"].stringValue,
                "SESSIONID" : Defaults["SESSIONID"].stringValue,
                "serchType" : currentIndex-1,
                "pageNo" : currentPage,
                "keyWords" : searchKey
            ]
        }
        
        beginSearch(params: params)
    }
    
    
    func beginSearch(params:[String:Any]) {
        SVPWillShow("加载中")
        Net.share.getRequest(urlString: kApi_serch, params: params, success: { (datas) in
            let json = JSON(datas)
            delog(json)
            SVPHide()
            if json["code"].int == 1 {

                let data = json["data"]
                if self.currentPage == 1 {
                    self.totalDatas.removeAll()
                    self.caseDatas.removeAll()
                    self.projectDatas.removeAll()
                    self.goodsDatas.removeAll()
                    self.doctorDatas.removeAll()
                    self.userDatas.removeAll()
                }
                
                //案例数据
                for (_ , subJson) : (String , JSON) in data["serchArticle"] {
                    let model = NewMain_NoteListModel()
                    model.id = subJson["id"].string!
                    model.preopImages = subJson["preopImages"].stringValue
                    model.allowFollow = subJson["allowFollow"].boolValue
                    model.follow = subJson["follow"].boolValue
                    let personal = subJson["personal"]
                    model.personald = personal["id"].stringValue
                    model.nickName = personal["nickName"].stringValue
                    model.photo = personal["photo"].stringValue
                    model.gender = personal["gender"].stringValue
                    let article = subJson["article"]
                    model.aId = article["id"].stringValue
                    model.content = article["content"].stringValue
                    model.images = article["images"].string!
                    model.createDate = article["createDate"].stringValue
                    model.comments = article["comments"].stringValue
                    model.thumbs = article["thumbs"].stringValue
                    model.hits = article["hits"].stringValue
                    self.caseDatas.append(model)
                }
                
                //项目数据
                for (_, subJson):(String, JSON) in data["serchProducts"] {
                    let model = NewStoreProjectModel()
                    model.disPrice = subJson["disPrice"].floatValue
                    model.doctorNames = subJson["doctorNames"].stringValue
                    model.id = subJson["id"].stringValue
                    model.productChildName = subJson["productChildName"].stringValue
                    model.productDescrible = subJson["productDescrible"].stringValue
                    model.productName = subJson["productName"].stringValue
                    model.reservationCount = subJson["reservationCount"].intValue
                    model.reservationPrice = subJson["reservationPrice"].floatValue
                    model.salaPrice = subJson["salaPrice"].floatValue
                    model.thumbnail = subJson["thumbnail"].stringValue
                    model.isFree = subJson["isFree"].stringValue
                    self.projectDatas.append(model)
                }
                
                //商品数据
                for (_, subJson):(String, JSON) in data["serchGoods"] {
                    let model = NewStoreGoodsModel()
                    model.disPrice = subJson["disPrice"].floatValue
                    model.goodItemChildName = subJson["goodItemChildName"].stringValue
                    model.goodItemDescrible = subJson["goodItemDescrible"].stringValue
                    model.goodItemName = subJson["goodItemName"].stringValue
                    model.id = subJson["id"].stringValue
                    model.isNew = subJson["isNew"].stringValue
                    model.isReconment = subJson["isReconment"].stringValue
                    model.isSale = subJson["isSale"].stringValue
                    model.postage = subJson["postage"].intValue
                    model.reservationCount = subJson["reservationCount"].intValue
                    model.salaPrice = subJson["salaPrice"].floatValue
                    model.thumbnail = subJson["thumbnail"].stringValue
                    self.goodsDatas.append(model)
                }
                
                //医生数据
                for (_, subJson):(String, JSON) in data["serchDoctors"] {
                    
                    let model = NewMineFollowListModel()
                    model.id = subJson["id"].stringValue
                    model.isUser = false
                    model.doctorName = subJson["doctorName"].stringValue
                    model.headImage = subJson["headImage"].stringValue
                    model.sex = subJson["sex"].stringValue
                    model.bespoke = subJson["bespoke"].stringValue
                    model.cases = subJson["cases"].stringValue
                    model.currentPosition = subJson["currentPosition"].stringValue
                    self.doctorDatas.append(model)
                }
                
                //用户数据
                for (_, subJson):(String, JSON) in data["serchUsers"] {
                    
                    let model = NewMineFollowListModel()
                    //粉丝只可能是用户
                    model.id = subJson["id"].stringValue
                    model.isUser = true
                    model.followType = subJson["followType"].stringValue
                    model.nickName = subJson["nickName"].stringValue
                    model.photo = subJson["photo"].stringValue
                    model.gender = subJson["gender"].stringValue
                    model.age = subJson["age"].stringValue
                    self.userDatas.append(model)
                }
                
                if self.caseDatas.count > 0{
                    self.totalDatas.append(self.caseDatas)
                    self.totalMarks.append("2")
                }
                if self.projectDatas.count > 0{
                    self.totalDatas.append(self.projectDatas)
                    self.totalMarks.append("3")
                }
                if self.goodsDatas.count > 0{
                    self.totalDatas.append(self.goodsDatas)
                    self.totalMarks.append("4")
                }
                if self.doctorDatas.count > 0{
                    self.totalDatas.append(self.doctorDatas)
                    self.totalMarks.append("5")
                }
                if self.userDatas.count > 0{
                    self.totalDatas.append(self.userDatas)
                    self.totalMarks.append("6")
                }
                
                self.mainTableView.reloadData()
            }else {
                SVPwillShowAndHide(json["message"].string!)
            }
            SVPHide()
        }) { (error) in
            delog(error)
            SVPwillShowAndHide("请检查您的网路")
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField.text?.count)! > 0 {
//            setToast(str: "开始搜索")
            searchKey = textField.text!

//            if searchRecordBlock != nil {
//                searchRecordBlock!(searchKey)
//            }
            if self.delegate != nil {
                self.delegate?.addSearchRecord(key: searchKey)
            }

            requestData()
            return true
        } else {
            setToast(str: "请输入搜索内容")
            return false
        }
    }
    
    
    override func rightAction(sender: UIButton) {
        if (searchTextfield.text?.count)! > 0 {
            searchKey = searchTextfield.text!
            
//            if searchRecordBlock != nil {
//                searchRecordBlock!(searchKey)
//            }
            
            if self.delegate != nil {
                self.delegate?.addSearchRecord(key: searchKey)
            }

            
            requestData()
//            setToast(str: "开始搜索")
            return
        } else {
            setToast(str: "请输入搜索内容")
            return
        }
    }
    
    
    func addImageWhenEmpty() {
        
        emptyView = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT - 64 - 80*kSCREEN_SCALE))
        emptyView.backgroundColor = kBGColor()
        let imageView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 200 * kSCREEN_SCALE, height: 200 * kSCREEN_SCALE))
        imageView.image = #imageLiteral(resourceName: "no-data_icon")
        imageView.center = CGPoint(x: emptyView.centerX, y: emptyView.centerY - 200 * kSCREEN_SCALE)
        emptyView.addSubview(imageView)
        
        let label = UILabel.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 18))
        label.textAlignment = .center
        label.textColor = kGaryColor(num: 163)
        label.center = CGPoint(x: emptyView.centerX, y: emptyView.centerY-40)
        label.font = kFont34
        label.numberOfLines = 2
        label.text = "暂无数据"
        emptyView.addSubview(label)
//        mainTableView.addSubview(emptyView)
    }
    
    
    //MARK:  ******代理 ：UITableViewDataSource,UITableViewDelegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch currentIndex {
        case 1:
            if totalDatas[section].count>1 {
                return 2
            }else{
                return 1
            }
        case 2:
            
            return caseDatas.count
        case 3:
            
            return projectDatas.count
        case 4:
            
            return goodsDatas.count
        case 5:
            
            return doctorDatas.count
        case 6:
            
            return userDatas.count
        default:
            return 0
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        if currentIndex == 1 {
            if totalDatas.count == 0 {
                tableView.addSubview(emptyView)
            }else{
                emptyView.removeFromSuperview()
            }

            return totalDatas.count
        }
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch currentIndex {
        case 1:
            
            if ((totalDatas[indexPath.section][0] as? NewMain_NoteListModel) != nil) {
                
                var cell:NewMineNoteListTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "NewMineNoteListTableViewCell") as? NewMineNoteListTableViewCell
                if nil == cell {
                    cell! = NewMineNoteListTableViewCell.init(style: .default, reuseIdentifier: identyfierTable)
                }
                cell?.selectionStyle = .none
                cell?.model = (totalDatas[indexPath.section][indexPath.row] as! NewMain_NoteListModel)
                return cell!
            }
            if ((totalDatas[indexPath.section][0] as? NewStoreProjectModel) != nil) {
                var cell:NewStoreListTabCell? = tableView.dequeueReusableCell(withIdentifier: "NewStoreListTabCell") as? NewStoreListTabCell
                if nil == cell {
                    cell! = NewStoreListTabCell.init(style: .default, reuseIdentifier: "NewStoreListTabCell")
                }
                cell?.selectionStyle = .none
                cell?.projectModel = (totalDatas[indexPath.section][indexPath.row] as! NewStoreProjectModel)
                return cell!
                
            }
            if ((totalDatas[indexPath.section][0] as? NewStoreGoodsModel) != nil) {
                
                var cell:NewStoreListTabCell? = tableView.dequeueReusableCell(withIdentifier: "NewStoreListTabCell") as? NewStoreListTabCell
                if nil == cell {
                    cell! = NewStoreListTabCell.init(style: .default, reuseIdentifier: "NewStoreListTabCell")
                }
                cell?.selectionStyle = .none
                cell?.goodsModel = (totalDatas[indexPath.section][indexPath.row] as! NewStoreGoodsModel)
                return cell!

            }
            if ((totalDatas[indexPath.section][0] as? NewMineFollowListModel) != nil) {
                let model = totalDatas[indexPath.section][indexPath.row] as! NewMineFollowListModel
                
                var cell:NewMineFollowListTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "NewMineFollowListTableViewCell") as? NewMineFollowListTableViewCell
                if nil == cell {
                    cell! = NewMineFollowListTableViewCell.init(style: .default, reuseIdentifier: "NewMineFollowListTableViewCell")
                }
                cell?.selectionStyle = .none
                cell?.setValuesForNewMineFollowListTableViewCell(model:model)
                return cell!
            }
            
            let cell : MemberCenterCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable1, for: indexPath) as! MemberCenterCell
            cell.selectionStyle = .none
            return cell
            
        case 2:
            var cell:NewMineNoteListTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "NewMineNoteListTableViewCell") as? NewMineNoteListTableViewCell
            if nil == cell {
                cell! = NewMineNoteListTableViewCell.init(style: .default, reuseIdentifier: "NewMineNoteListTableViewCell")
            }
            cell?.selectionStyle = .none
            cell?.model = caseDatas[indexPath.row] 
            return cell!

        case 3:
            var cell:NewStoreListTabCell? = tableView.dequeueReusableCell(withIdentifier: "NewStoreListTabCell") as? NewStoreListTabCell
            if nil == cell {
                cell! = NewStoreListTabCell.init(style: .default, reuseIdentifier: "NewStoreListTabCell")
            }
            cell?.selectionStyle = .none
            cell?.projectModel = projectDatas[indexPath.row]
            return cell!

        case 4:
            var cell:NewStoreListTabCell? = tableView.dequeueReusableCell(withIdentifier: "NewStoreListTabCell") as? NewStoreListTabCell
            if nil == cell {
                cell! = NewStoreListTabCell.init(style: .default, reuseIdentifier: "NewStoreListTabCell")
            }
            cell?.selectionStyle = .none
            cell?.goodsModel = goodsDatas[indexPath.row]
            return cell!

        case 5:
            var cell:NewMineFollowListTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "NewMineFollowListTableViewCell") as? NewMineFollowListTableViewCell
            if nil == cell {
                cell! = NewMineFollowListTableViewCell.init(style: .default, reuseIdentifier: "NewMineFollowListTableViewCell")
            }
            cell?.selectionStyle = .none
            cell?.setValuesForNewMineFollowListTableViewCell(model:doctorDatas[indexPath.row])
            return cell!

        default:
            var cell:NewMineFollowListTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "NewMineFollowListTableViewCell") as? NewMineFollowListTableViewCell
            if nil == cell {
                cell! = NewMineFollowListTableViewCell.init(style: .default, reuseIdentifier: "NewMineFollowListTableViewCell")
            }
            cell?.selectionStyle = .none
            cell?.setValuesForNewMineFollowListTableViewCell(model:userDatas[indexPath.row])
            return cell!
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch currentIndex {
        case 1:
            if ((totalDatas[indexPath.section][0] as? NewMain_NoteListModel) != nil) {
                
                let model = totalDatas[indexPath.section][0] as! NewMain_NoteListModel
                let detail = NewNote_DetailVC()
                detail.id = model.id
                navigationController?.pushViewController(detail, animated: true)
            } else if ((totalDatas[indexPath.section][0] as? NewStoreProjectModel) != nil) {
                
                let model = totalDatas[indexPath.section][0] as! NewStoreProjectModel
                let detail = NewStoresDetailViewController.init(nibName: "NewStoresDetailViewController", bundle: nil)
                detail.isProject = true
                detail.id = model.id
                navigationController?.pushViewController(detail, animated: true)
            }else if ((totalDatas[indexPath.section][0] as? NewStoreGoodsModel) != nil) {
                
                let model = totalDatas[indexPath.section][0] as! NewStoreGoodsModel
                let detail = NewStoresDetailViewController.init(nibName: "NewStoresDetailViewController", bundle: nil)
                detail.isProject = false
                detail.id = model.id
                navigationController?.pushViewController(detail, animated: true)
            }else{
                
                let model = totalDatas[indexPath.section][0] as! NewMineFollowListModel
                if !model.isUser {
                    let doctorView = NewDoctorMainPageViewController()
                    doctorView.doctorID = model.id
                    self.navigationController?.pushViewController(doctorView, animated: true)
                }else{
                    let me = newMineMeViewController()
                    me.id = model.id
                    me.isMe = false
                    self.navigationController?.pushViewController(me, animated: true)
                }
            }
        case 2:
            
            let detail = NewNote_DetailVC()
            detail.id = caseDatas[indexPath.row].id
            navigationController?.pushViewController(detail, animated: true)
        case 3:
            
            let detail = NewStoresDetailViewController.init(nibName: "NewStoresDetailViewController", bundle: nil)
            detail.isProject = true
            detail.id = projectDatas[indexPath.row].id
            navigationController?.pushViewController(detail, animated: true)
        case 4:
            
            let detail = NewStoresDetailViewController.init(nibName: "NewStoresDetailViewController", bundle: nil)
            detail.isProject = false
            detail.id = goodsDatas[indexPath.row].id
            navigationController?.pushViewController(detail, animated: true)
        case 5:
            
            let doctorView = NewDoctorMainPageViewController()
            doctorView.doctorID = doctorDatas[indexPath.row].id
            self.navigationController?.pushViewController(doctorView, animated: true)
        default:
            
            let me = newMineMeViewController()
            me.id = userDatas[indexPath.row].id
            me.isMe = false
            self.navigationController?.pushViewController(me, animated: true)
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 19 * kSCREEN_SCALE+25))
        view.backgroundColor = UIColor.white
        let showMore = UIButton.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 25))
        showMore.center = view.center
        showMore.setTitle("显示更多>", for: .normal)
        showMore.tag = 10101+section
        showMore.setTitleColor(kGaryColor(num: 117), for: .normal)
        showMore.titleLabel?.font = kFont28
        showMore.addTarget(self, action: #selector(showDetailDatas(sender:)), for: .touchUpInside)
        view.addSubview(showMore)
        return view
    }
    
    
    @objc func showDetailDatas(sender:UIButton) {
        
        var nextIndex = 1000
        
        if ((totalDatas[sender.tag-10101][0] as? NewMain_NoteListModel) != nil) {
            nextIndex = 2
        }
        if ((totalDatas[sender.tag-10101][0] as? NewStoreProjectModel) != nil) {
            nextIndex = 3
        }
        if ((totalDatas[sender.tag-10101][0] as? NewStoreGoodsModel) != nil) {
            nextIndex = 4
        }
        if ((totalDatas[sender.tag-10101][0] as? NewMineFollowListModel) != nil) {
            let model = totalDatas[sender.tag-10101][0] as! NewMineFollowListModel
            
            if !model.isUser {
                nextIndex = 5
            }else{
                nextIndex = 6
            }
        }
        let view1 = headView.viewWithTag(130+nextIndex) as! UIButton
        view1.setTitleColor(kMainColor(), for: .normal)
        goodAtProject(sender: view1)
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 39+10*kSCREEN_SCALE))
        view.backgroundColor = kSetRGBColor(r: 239, g: 239, b: 244)
        
        let label = UILabel.init(frame: CGRect(x: 0, y: 19*kSCREEN_SCALE, width: kSCREEN_WIDTH, height: 44))
        label.backgroundColor = kSetRGBColor(r: 255, g: 255, b: 255)
        label.textColor = kGaryColor(num: 117)
        label.font = kFont32
        
        let line = UIView.init(frame: CGRect(x: 0, y: 39+19*kSCREEN_SCALE, width: kSCREEN_WIDTH, height: 1))
        line.backgroundColor = kSetRGBColor(r: 220, g: 220, b: 220)
        view.addSubview(line)
        
        if ((totalDatas[section][0] as? NewMain_NoteListModel) != nil) {
            label.text = "  案例"
        }
        if ((totalDatas[section][0] as? NewStoreProjectModel) != nil) {
            label.text = "  项目"
        }
        if ((totalDatas[section][0] as? NewStoreGoodsModel) != nil) {
            label.text = "  商品"
        }
        if ((totalDatas[section][0] as? NewMineFollowListModel) != nil) {
            let model = totalDatas[section][0] as! NewMineFollowListModel
            
            if !model.isUser {
                label.text = "  医生"
            }else{
                label.text = "  用户"
            }
        }

        view.addSubview(label)
        
        return view
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch currentIndex {
        case 1:
            if ((totalDatas[indexPath.section][0] as? NewMain_NoteListModel) != nil) {
                return GET_SIZE * 640
            }
            else
            if ((totalDatas[indexPath.section][0] as? NewStoreProjectModel) != nil) {
                return GET_SIZE * 246
            }
            else
            if ((totalDatas[indexPath.section][0] as? NewStoreGoodsModel) != nil) {
                return GET_SIZE * 246
            }
            else
            {
                return GET_SIZE * 132
            }
        case 2:
            return GET_SIZE * 640
        case 3,4:
            return GET_SIZE * 246
        default:
            return GET_SIZE * 132

        }
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if currentIndex != 1 {
            return 0
        }
        return 39+19*kSCREEN_SCALE

    }
    
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if currentIndex != 1 {
            return 0
        }
        if totalDatas[section].count>1 {
            return 19 * kSCREEN_SCALE+25
        }else{
            return 0
        }
    }
    
    
}
