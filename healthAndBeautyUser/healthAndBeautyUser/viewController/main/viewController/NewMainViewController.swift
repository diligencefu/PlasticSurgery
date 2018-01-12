//
//  newMainViewController.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/11.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON
import MJRefresh

class NewMainVCClassessModel: NSObject {
    
    var name = String()
    var id = String()
}

class NewMainViewController: Wx_baseViewController,JTSegmentControlDelegate {

    //是否是特色案例   选择栏0
    var isSurgery = true
    
    //两个选择框
    var headSegment = UISegmentedControl()
    var naviSegment = UISegmentedControl()
    let autoWidthControl = JTSegmentControl(frame: CGRect(x: 0, y: (HEIGHT == 812 ? 88 : 64), width: WIDTH, height: 44))

    // MARK: - header
    var segment = UIView()
    
//    首页轮播广告图片数据
    var mainCircleList = NSMutableArray()
    //    中间表格广告数据
    var mianCenterList = NSMutableArray()
    //    最后列表广告数据
    var mianTableList = NSMutableArray()
//    免费整形广告
    var freeModel = FYHSowMainADModel()
    
    //首页图标
    var icons = NSMutableArray()

    
    
    
    lazy var tableView : UITableView = {
        
        let table = UITableView()
        table.backgroundColor = backGroundColor
        table.delegate = self
        table.dataSource = self
        table.tableFooterView = UIView.init()
        table.separatorStyle = .none
        
        table.register(NewMainBannerCell.self, forCellReuseIdentifier: "NewMainBannerCell")
        table.register(NewMainIconGroupCell.self, forCellReuseIdentifier: "NewMainIconGroupCell")
        table.register(NewMainBannerTableViewCell.self, forCellReuseIdentifier: "NewMainBannerTableViewCell")
        table.register(NewMainCaseListTableViewCell.self, forCellReuseIdentifier: "NewMainCaseListTableViewCell")
        table.register(NewMain_Note_ListTabCell.self, forCellReuseIdentifier: "NewMain_Note_ListTabCell")
        
        table.register(NewMineNoteListTableViewCell.self, forCellReuseIdentifier: "NewMineNoteListTableViewCell")
        table.register(NewStoreListTabCell.self, forCellReuseIdentifier: "NewStoreListTabCell")
        table.register(UINib.init(nibName: "FYHMainShowADCell", bundle: nil), forCellReuseIdentifier: "FYHMainShowADCell")

        table.register(UINib.init(nibName: "NewMainADTableViewCell", bundle: nil), forCellReuseIdentifier: "NewMainADTableViewCell")

        table.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            
            self.refreshHeaderAction()
        })
        
        table.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            
            self.refreshFooterAction()
        })
        return table
    }()
    
    
    func refreshHeaderAction() {
        
//        请求广告
        let params = [
            "mobileCode" : Defaults["mobileCode"].stringValue,
            "SESSIONID" : Defaults["SESSIONID"].stringValue,
            ]
        NetWorkForUserbanner_getBanners(params: params) { (datas, flag) in
            if flag && datas.count > 0{
                if flag && datas.count > 0{
                    self.mainCircleList.removeAllObjects()
                    self.mianCenterList.removeAllObjects()
                    self.mianTableList.removeAllObjects()
                    for json in datas {
                        let model = json as! FYHSowMainADModel
                        if model.bannerSpecific.locationFlag == "1" {
                            self.mainCircleList.add(model)
                        }else if model.bannerSpecific.locationFlag == "2" {
                            self.mianCenterList.add(model)
                        }else if model.bannerSpecific.locationFlag == "3" {
                            self.mianTableList.add(model)
                        }else if model.bannerSpecific.locationFlag == "4" {
                            self.freeModel = model
                        }
                    }
                }
            }
        }

        
        page = 1
        var up = ["pageNo": page]
            as [String: Any]
        var url = String()
        //device
        if Defaults.hasKey("SESSIONID") {
            up["mobileCode"] = Defaults["mobileCode"].stringValue
            up["SESSIONID"] = Defaults["SESSIONID"].stringValue
        }
        if isSurgery {
            //不是手术 使用65号接口  -》 日记列表
            url = getProjectClassifyArticles_65_joggle
            //类别
            if classess.count == 0 {
                //是最新项目分类传1
                up["sortType"] = "1"
            }else {
                up["id"] = classess
                //不是最新项目分类传3
                up["sortType"] = "3"
            }
        }else {
            //是手术 使用64号接口   -》 商品列表
            url = productReconmentList_64_joggle
            //类别
            if classess.count != 0 {
                up["classifyId"] = classess
            }
        }
        
        SVPWillShow("载入中...")
        delog(up)
        
        Net.share.getRequest(urlString: url, params: up, success: { (datas) in
            
            let json = JSON(datas)
            delog(json)
            SVPHide()
            if json["code"].int == 1 {
                if self.isSurgery {
                    
                    self.pageMax = json["data"]["totalPage"].int!
                    if self.page == 1 {
                        self.leftDateSource.removeAllObjects()
                    }
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
                        model.images = article["images"].stringValue
                        model.createDate = article["createDate"].string!
                        model.comments = article["comments"].string!
                        model.thumbs = article["thumbs"].string!
                        model.hits = article["hits"].string!
                        self.leftDateSource.add(model)
                    }
                    if self.mianTableList.count > 0 && self.leftDateSource.count > 0{
                        for admodel in self.mianTableList {
                            let model = admodel as! FYHSowMainADModel
                            var index = Int()
                            if self.leftDateSource.count == 1 {
                                index = 0
                            }else{
                                index = Int(arc4random() % UInt32(self.leftDateSource.count-1))
                            }
                            self.leftDateSource.insert(model, at: index)
                        }
                    }
                    self.isLoad = true
                    self.tableView.reloadData()
                }else {
                    self.pageMax = json["data"]["totalPage"].int!
                    if self.page == 1 {
                        self.rightDateSource.removeAllObjects()
                    }
                    for (_, subJson):(String, JSON) in json["data"]["products"] {
                        let model = NewStoreGoodsModel()
                        model.disPrice = subJson["disPrice"].float!
                        model.goodItemChildName = subJson["productChildName"].string!
                        model.goodItemDescrible = subJson["productDescrible"].string!
                        model.goodItemName = subJson["productName"].string!
                        model.id = subJson["id"].string!
                        model.reservationPrice = subJson["reservationPrice"].float!
                        model.reservationCount = subJson["reservationCount"].int!
                        model.salaPrice = subJson["salaPrice"].float!
                        model.thumbnail = subJson["thumbnail"].string!
                        model.isFree = subJson["isFree"].string!
                        self.rightDateSource.add(model)
                    }
                    if self.mianTableList.count > 0 && self.rightDateSource.count > 0{
                        for admodel in self.mianTableList {
                            let model = admodel as! FYHSowMainADModel
                            var index = Int()
                            if self.rightDateSource.count == 1 {
                                index = 0
                            }else{
                                index = Int(arc4random() % UInt32(self.rightDateSource.count-1))
                            }
                            self.rightDateSource.insert(model, at: index)
                        }
                    }
                    self.isLoad = true
                    self.tableView.reloadData()
                }
                self.tableView.mj_header.endRefreshing()
            }
        }) { (error) in
            delog(error)
            SVPwillShowAndHide("请检查您的网路")
            self.tableView.mj_header.endRefreshing()
        }
    }
    
    func refreshFooterAction() {
        page = page + 1
        self.isFirstLunch = true
        buildData()
    }

    
    var leftDateSource = NSMutableArray()
    var rightDateSource = NSMutableArray()
    var classDataSource = [NewMainVCClassessModel]()
    
    var page : NSInteger = 1
    var pageMax : NSInteger = 1
    
    //是否加载了数据
    var isLoad = Bool()
    //是否是第一次启动
    var isFirstLunch: Bool = true

    var classess = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildUI()
        buildNavi()
        buildClassess()
    }
    
    private func buildClassess() {
        
        Net.share.getRequest(urlString: getProjectClassify_6305_joggle, params: nil, success: { (datas) in
            
            let json = JSON(datas)
            delog(json)
            
            if json["code"].int == 1 {
                
                for (_, subJson):(String, JSON) in json["data"]["projectClassifys"] {
                    
                    let model = NewMainVCClassessModel()
                    model.name = subJson["name"].string!
                    model.id = subJson["id"].string!
                    self.classDataSource.append(model)
                }
                self.buildData()
                self.buildSeg()
            }
        }) { (error) in
            delog(error)
        }
    }
    
    private func buildData() {
        
        //        请求广告
        let params = [
            "mobileCode" : Defaults["mobileCode"].stringValue,
            "SESSIONID" : Defaults["SESSIONID"].stringValue,
            ]
        NetWorkForUserbanner_getBanners(params: params) { (datas, flag) in
            if flag && datas.count > 0{
                //                let model = datas[0] as! FYHSowMainADModel
                //                deBugPrint(item: model)
                
                self.mainCircleList.removeAllObjects()
                self.mianCenterList.removeAllObjects()
                self.mianTableList.removeAllObjects()
                for json in datas {
                    let model = json as! FYHSowMainADModel
                    if model.bannerSpecific.locationFlag == "1" {
                        self.mainCircleList.add(model)
                    }else if model.bannerSpecific.locationFlag == "2" {
                        self.mianCenterList.add(model)
                    }else if model.bannerSpecific.locationFlag == "3" {
                        self.mianTableList.add(model)
                    }else if model.bannerSpecific.locationFlag == "4" {
                        self.freeModel = model
                    }
                }
                
            }
        }

        var up = ["pageNo": page]
            as [String: Any]
        var url = String()
        //device
        if Defaults.hasKey("SESSIONID") {
            up["mobileCode"] = Defaults["mobileCode"].stringValue
            up["SESSIONID"] = Defaults["SESSIONID"].stringValue
        }
        if isSurgery {
            //不是手术 使用65号接口  -》 日记列表
            url = getProjectClassifyArticles_65_joggle
            //类别
            if classess.count == 0 {
                //是最新项目分类传1
                up["sortType"] = "1"
            }else {
                up["id"] = classess
                //不是最新项目分类传3
                up["sortType"] = "3"
            }
        }else {
            //是手术 使用64号接口   -》 商品列表
            url = productReconmentList_64_joggle
            //类别
            if classess.count != 0 {
                up["classifyId"] = classess
            }
        }
        
        SVPWillShow("载入中...")
        delog(up)
        
        Net.share.getRequest(urlString: url, params: up, success: { (datas) in
            
            let json = JSON(datas)
            delog(json)
            SVPHide()
            if json["code"].int == 1 {
                if self.isSurgery {
                    
                    self.pageMax = json["data"]["totalPage"].int!
                    if self.page == 1 {
                        self.leftDateSource.removeAllObjects()
                    }
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
                            model.images = article["images"].stringValue
                            model.createDate = article["createDate"].string!
                            model.comments = article["comments"].string!
                            model.thumbs = article["thumbs"].string!
                            model.hits = article["hits"].string!
                        self.leftDateSource.add(model)
                    }
                    
                    if self.mianTableList.count > 0 && self.leftDateSource.count > 0{
                        for admodel in self.mianTableList {
                            let model = admodel as! FYHSowMainADModel
                            var index = Int()
                            if self.leftDateSource.count == 1 {
                                index = 0
                            }else{
                                index = Int(arc4random() % UInt32(self.leftDateSource.count-1))
                            }
                            self.leftDateSource.insert(model, at: index)
                        }
                    }

                    self.isLoad = true
                    self.tableView.reloadData()
                    self.tableView.layoutIfNeeded()
                    if self.leftDateSource.count != 0 && !self.isFirstLunch {
                        self.tableView.scrollToRow(at: IndexPath.init(row: 0, section: 3), at: .top, animated: true)
                    }
                    self.isFirstLunch = false
                }else {
                    self.pageMax = json["data"]["totalPage"].int!
                    if self.page == 1 {
                        self.rightDateSource.removeAllObjects()
                    }
                    for (_, subJson):(String, JSON) in json["data"]["products"] {
                        let model = NewStoreGoodsModel()
                        model.disPrice = subJson["disPrice"].float!
                        model.goodItemChildName = subJson["productChildName"].string!
                        model.goodItemDescrible = subJson["productDescrible"].string!
                        model.goodItemName = subJson["productName"].string!
                        model.id = subJson["id"].string!
                        model.reservationPrice = subJson["reservationPrice"].float!
                        model.reservationCount = subJson["reservationCount"].int!
                        model.salaPrice = subJson["salaPrice"].float!
                        model.thumbnail = subJson["thumbnail"].string!
                        model.isFree = subJson["isFree"].string!
                        self.rightDateSource.add(model)
                    }
//                    Int(arc4random() % UInt32(self.rightDateSource.count-1))
                    
                    if self.mianTableList.count > 0 && self.rightDateSource.count > 0{
                        for admodel in self.mianTableList {
                            let model = admodel as! FYHSowMainADModel
                            var index = Int()
                            if self.rightDateSource.count == 1 {
                                index = 0
                            }else{
                                index = Int(arc4random() % UInt32(self.rightDateSource.count-1))
                            }
                            self.rightDateSource.insert(model, at: index)
                        }
                    }

                    self.isLoad = true
                    self.tableView.reloadData()
                    self.tableView.layoutIfNeeded()
                    if self.rightDateSource.count != 0 && !self.isFirstLunch {
                        self.tableView.scrollToRow(at: IndexPath.init(row: 0, section: 3), at: .top, animated: true)
                    }
                    self.isFirstLunch = false
                }
            }
        }) { (error) in
            delog(error)
            SVPwillShowAndHide("请检查您的网路")
        }
        
        //首页图标接数据:
        NetWorkForMainADGroup(params: params) { (datas, flag) in
            if flag {
                self.icons.addObjects(from: datas)
                self.tableView.reloadSections([1], with: .none)
            }
        }
        
        
    }
    
    private func buildSeg() {
        
        let titleArray = ["手术案例","特色项目"]
        let segmentController = UISegmentedControl(items: titleArray)
        segmentController.tintColor = tabbarColor
        segmentController.selectedSegmentIndex = 0
        segmentController.addTarget(self, action: #selector(segmentDidChangeValue(controller:)), for: .valueChanged)
        segment.addSubview(segmentController)
        _ = segmentController.sd_layout()?
            .topSpaceToView(segment,(HEIGHT == 812 ? 40 : 20))?
            .leftSpaceToView(segment,(WIDTH-160)/2)?
            .widthIs(160)?
            .heightIs(32)
        viewRadius(segmentController, 15, 1, tabbarColor)
        segmentController.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: TEXT28)],
                                                 for: .normal)
        headSegment = segmentController
        
        var type = [String]()
        type.append("最新")
        for index in classDataSource {
            type.append(index.name)
        }
        
        autoWidthControl.delegates = self
        autoWidthControl.items = type
        autoWidthControl.selectedIndex = 0
        autoWidthControl.autoAdjustWidth = true
        autoWidthControl.bounces = true
        autoWidthControl.itemSelectedBackgroundColor = backGroundColor
        autoWidthControl.itemBackgroundColor = backGroundColor
        autoWidthControl.sliderViewColor = tabbarColor
        autoWidthControl.font = UIFont.systemFont(ofSize: TEXT32)
        autoWidthControl.itemTextColor = darkText
        autoWidthControl.itemSelectedTextColor = tabbarColor
        
        segment.addSubview(autoWidthControl)
        _ = autoWidthControl.sd_layout()?
            .bottomSpaceToView(segment,0)?
            .leftSpaceToView(segment,0)?
            .widthIs(WIDTH)?
            .heightIs(44)
        
        let line = UIView()
        line.backgroundColor = lineColor
        segment.addSubview(line)
        _ = line.sd_layout()?
            .bottomSpaceToView(segment,0)?
            .leftSpaceToView(segment,0)?
            .widthIs(WIDTH)?
            .heightIs(0.5)
    }
    
    private func buildUI() {
        
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        view.addSubview(tableView)
        tableView.frame = CGRect.init(x: 0, y: 0, width: WIDTH, height: HEIGHT-49)
    }
    
    //导航栏
    let tmpNaviView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: WIDTH, height: (HEIGHT == 812 ? 88 : 64)))
    let searchView = UIView()
    let searchIMG = UIImageView()
    let searchLab = UILabel()
    let backView = UIView()
    let line = UIView()
    let search = UIButton()

    private func buildNavi() {
        
        tmpNaviView.image = UIImage(named:"01_shadow_375_73")
        tmpNaviView.isUserInteractionEnabled = true
        view.addSubview(tmpNaviView)
        
        backView.backgroundColor = backGroundColor
        backView.frame = CGRect(x: 0, y: 0, width: WIDTH, height: (HEIGHT == 812 ? 88 : 64))
        backView.alpha = 0
        tmpNaviView.addSubview(backView)
        
        searchView.backgroundColor = UIColor.white
        searchView.frame = CGRect(x: 24, y: (HEIGHT == 812 ? 47 : 26), width: WIDTH-48, height: 32)
        searchView.alpha = 0.7
        tmpNaviView.addSubview(searchView)
        viewRadius(searchView, 16, 1.0, UIColor.clear)
        
        searchIMG.image = UIImage(named:"16_search")
        searchIMG.frame = CGRect(x: 24, y: (searchView.height-14)/2, width: 14, height: 14)
        searchView.addSubview(searchIMG)
        
        searchLab.text = "点击搜索产品/项目/医院/医生"
        searchLab.textColor = getColorWithNotAlphe(0x656565)
        searchLab.font = UIFont.systemFont(ofSize: TEXT24)
        searchLab.textAlignment = .left
        searchLab.frame = CGRect(x: 44, y: (searchView.height-16)/2, width: searchView.width-64, height: 16)
        searchLab.isUserInteractionEnabled = true
        let tapGes1 = UITapGestureRecognizer.init(target: self, action: #selector(moveToSearch(tap:)))
        tapGes1.numberOfTouchesRequired = 1
        searchLab.addGestureRecognizer(tapGes1)
        searchView.addSubview(searchLab)

        search.setImage(UIImage(named:"16_search"), for: .normal)
        search.addTarget(self, action: #selector(click(_:)), for: .touchUpInside)
        search.tag = 101
        search.frame = CGRect(x: tmpNaviView.width - 44, y: (HEIGHT == 812 ? 44 : 20), width: 44, height: 44)
        tmpNaviView.addSubview(search)
        search.alpha = 0
        
        let titleArray = ["手术案例","特色项目"]
        let segmentController = UISegmentedControl(items: titleArray)
        segmentController.frame = CGRect.init(x: (WIDTH-160)/2, y: (HEIGHT == 812 ? 47 : 26), width: 160, height: 32)
        segmentController.tintColor = tabbarColor
        segmentController.selectedSegmentIndex = 0
        segmentController.addTarget(self, action: #selector(segmentDidChangeValue(controller:)), for: .valueChanged)
        tmpNaviView.addSubview(segmentController)
        viewRadius(segmentController, 16, 1, tabbarColor)
        segmentController.alpha = 0
        naviSegment = segmentController

        line.backgroundColor = lineColor
        line.alpha = 0
        line.frame = CGRect(x: 0, y: (HEIGHT == 812 ? 88 : 64)-0.5, width: WIDTH, height: 0.5)
        tmpNaviView.addSubview(line)
    }
    
    
    @objc func moveToSearch(tap:UITapGestureRecognizer) {
        
        let destinationStoryboard = UIStoryboard(name:"CXShearchStoryboard",bundle:nil)
        let search = destinationStoryboard.instantiateViewController(withIdentifier: "CXSearchController") as! CXSearchController
        search.hidesBottomBarWhenPushed = true
        let root = Wx_baseNaviViewController.init(rootViewController: search)
        self.present(root, animated: true, completion: nil)
    }
    
    @objc private func click(_ click: UIButton) {
        
        switch click.tag {
        case 101:
            let destinationStoryboard = UIStoryboard(name:"CXShearchStoryboard",bundle:nil)
            let search = destinationStoryboard.instantiateViewController(withIdentifier: "CXSearchController") as! CXSearchController
            search.hidesBottomBarWhenPushed = true
            let root = Wx_baseNaviViewController.init(rootViewController: search)
            self.present(root, animated: true, completion: nil)
            break
        default:
            break
        }
    }
    
    func segmentDidChangeValue(controller:UISegmentedControl) {

        if controller.selectedSegmentIndex == 0 {
            isSurgery = true
        }else {
            isSurgery = false
        }
        headSegment.selectedSegmentIndex = isSurgery ? 0 : 1
        naviSegment.selectedSegmentIndex = isSurgery ? 0 : 1
        page = 1
        isLoad = false
        autoWidthControl.move(to: 0)
    }
    
    func didSelected(segement: JTSegmentControl, index: Int) {
        
        print("current index \(index)")
        if index == 0 {
            
            classess = String()
        }else {
            
            classess = classDataSource[index - 1].id
        }
        page = 1
        buildData()
    }
}

// MARK: - UITableViewDelegate
extension NewMainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if isSurgery {
            if ((leftDateSource[indexPath.row] as? NewMain_NoteListModel) != nil) {
                let model = leftDateSource[indexPath.row]as! NewMain_NoteListModel
                let detail = NewNote_DetailVC()
                detail.id = model.id
                navigationController?.pushViewController(detail, animated: true)
            }else{
                let model = leftDateSource[indexPath.row]as! FYHSowMainADModel
                let webView = FYHShowInfoWithWebViewController()
                webView.webTitle = model.infoBanner.name
                webView.webUrl = model.infoBanner.linkUrl
                self.navigationController?.pushViewController(webView, animated: true)

//                if #available(iOS 10.0, *) {
//                    UIApplication.shared.open(StringToUTF_8InUrl(str:model.infoBanner.linkUrl), options: [:],
//                                              completionHandler: {
//                                                (success) in
//                                                if !success {
//                                                    setToast(str: "网址格式错误！")
//                                                }
//
//                    })
//                } else {
//                    // Fallback on earlier versions
//                }
            }
        }else{
            if ((rightDateSource[indexPath.row] as? NewStoreGoodsModel) != nil) {
                let model = rightDateSource[indexPath.row] as! NewStoreGoodsModel
                let detail = NewStoresDetailViewController.init(nibName: "NewStoresDetailViewController", bundle: nil)
                detail.isProject = true
                detail.id = model.id
                navigationController?.pushViewController(detail, animated: true)
            }else{
                let model = rightDateSource[indexPath.row]as! FYHSowMainADModel
                
                let webView = FYHShowInfoWithWebViewController()
                webView.webTitle = model.infoBanner.name
                webView.webUrl = model.infoBanner.linkUrl
                self.navigationController?.pushViewController(webView, animated: true)
                
//                if #available(iOS 10.0, *) {
//                    UIApplication.shared.open(StringToUTF_8InUrl(str:model.infoBanner.linkUrl), options: [:],
//                                              completionHandler: {
//                                                (success) in
//                                                if !success {
//                                                    setToast(str: "网址格式错误！")
//                                                }
//
//                    })
//                } else {
//                    // Fallback on earlier versions
//                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return GET_SIZE * 528
        case 1:
            return GET_SIZE * 350
        case 2:
            return 210
        case 3:
            if isSurgery {
                if ((leftDateSource[indexPath.row] as? NewMain_NoteListModel) != nil) {
                    return GET_SIZE * 640
                }else{
                    return 152
                }
//                return GET_SIZE * 550+kGetSizeOnString(leftDateSource[indexPath.row].content, Int(GET_SIZE * 26),width: WIDTH-60).height
            }else {
                if ((rightDateSource[indexPath.row] as? NewStoreGoodsModel) != nil) {
                    return GET_SIZE * 248
                }else{
                    return 152
                }
            }
        default :
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            var cell:NewMainBannerCell? = tableView.dequeueReusableCell(withIdentifier: "NewMainBannerCell") as? NewMainBannerCell
            if nil == cell {
                cell! = NewMainBannerCell.init(style: .default, reuseIdentifier: "NewMainBannerCell")
            }
            cell?.chooseAction = {
                print($0)
                
                let webView = FYHShowInfoWithWebViewController()
                webView.webTitle = $1
                webView.webUrl = $0
                self.navigationController?.pushViewController(webView, animated: true)

                
//                if #available(iOS 10.0, *) {
//                    UIApplication.shared.open(StringToUTF_8InUrl(str:$0), options: [:],
//                                              completionHandler: {
//                                                (success) in
//                                                if !success {
//                                                    setToast(str: "网址格式错误！")
//                                                }
//                                                
//                    })
//                } else {
//                    // Fallback on earlier versions
//                }
            }

            cell?.selectionStyle = .none
            cell?.tag = 777
            if self.mainCircleList.count > 0 {
                cell?.buildDataWithImages(images:self.mainCircleList as! [FYHSowMainADModel])
            }else{
                cell?.buildData()
            }
            return cell!
        case 1:
            var cell:NewMainIconGroupCell? = tableView.dequeueReusableCell(withIdentifier: "NewMainIconGroupCell") as? NewMainIconGroupCell
            if nil == cell {
                cell! = NewMainIconGroupCell.init(style: .default, reuseIdentifier: "NewMainIconGroupCell")
            }
            cell?.gotoFreeBlock = {
                if $0 == "1" {
                    let tmp = NewMain_freeViewController()
                    tmp.mainModel = self.freeModel
                    self.navigationController?.pushViewController(tmp, animated: true)
                }else {
                    if Defaults.hasKey("SESSIONID") {
                        let tmp = FYHIntegralStoreViewController1()
                        self.navigationController?.pushViewController(tmp, animated: true)
                    }else{
                        SVPwillShowAndHide("请先登录")
                    }
                }
            }
            cell?.selectionStyle = .none
//            cell?.buildData()
            cell?.setValuesForNewMainIconGroupCell(icons: icons as! [iconModel])
            return cell!
        case 2:
            let cell:NewMainADTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "NewMainADTableViewCell") as? NewMainADTableViewCell
            if self.mianCenterList.count > 0 {
                cell?.setValuesForNewMainADTableViewCell(images: self.mianCenterList as! [FYHSowMainADModel])
            }

            cell?.selectionStyle = .none
            return cell!
        case 3:
            if isSurgery {
                
                if ((leftDateSource[indexPath.row] as? NewMain_NoteListModel) != nil) {
                    
                    let model = leftDateSource[indexPath.row]as! NewMain_NoteListModel
                    var cell:NewMineNoteListTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "NewMineNoteListTableViewCell") as? NewMineNoteListTableViewCell
                    if nil == cell {
                        cell! = NewMineNoteListTableViewCell.init(style: .default, reuseIdentifier: "NewMineNoteListTableViewCell")
                    }
                    cell?.selectionStyle = .none
                    cell?.model = model
                    return cell!
                }else{
                    
                    let model = leftDateSource[indexPath.row] as! FYHSowMainADModel
                    let cell:FYHMainShowADCell? = tableView.dequeueReusableCell(withIdentifier: "FYHMainShowADCell") as? FYHMainShowADCell
                    cell?.selectionStyle = .none
                    cell?.setValuesForFYHMainShowADCell(model: model)
                    return cell!
                }
                
            }else {
                
                if ((rightDateSource[indexPath.row] as? NewStoreGoodsModel) != nil) {
                    let model = rightDateSource[indexPath.row] as! NewStoreGoodsModel
                    var cell:NewStoreListTabCell? = tableView.dequeueReusableCell(withIdentifier: "NewStoreListTabCell") as? NewStoreListTabCell
                    if nil == cell {
                        cell! = NewStoreListTabCell.init(style: .default, reuseIdentifier: "NewStoreListTabCell")
                    }
                    cell?.selectionStyle = .none
                    cell?.goodsModel = model
                    return cell!

                }else{
                    let model = rightDateSource[indexPath.row] as! FYHSowMainADModel
                    let cell:FYHMainShowADCell? = tableView.dequeueReusableCell(withIdentifier: "FYHMainShowADCell") as? FYHMainShowADCell
                    cell?.selectionStyle = .none
                    cell?.setValuesForFYHMainShowADCell(model: model)
                    return cell!

                }
            }
        default :
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 3 {
            return segment
        }
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 3 {
            return (HEIGHT == 812 ? 88 : 64) + 44
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 1{
            let view = UIView.init()
            view.backgroundColor = lineColor
            return view
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 1 {
            return 10
        }
        return 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        if scrollView.contentOffset.y <= 0 {
            backView.alpha = 0
        }else if scrollView.contentOffset.y <= 200 {
            let tmp = Int(scrollView.contentOffset.y) % 200
            backView.alpha = CGFloat(tmp) / 200
        }else {
            backView.alpha = 1
        }

        if scrollView.contentOffset.y <= GET_SIZE * 264 {

            searchView.backgroundColor = UIColor.white
            searchLab.textColor = getColorWithNotAlphe(0x656565)
            line.alpha = 0
        }else if scrollView.contentOffset.y <= (GET_SIZE * 878 + 205) {

            searchView.backgroundColor = getColorWithNotAlphe(0xEBEBEB)
            searchLab.textColor = getColorWithNotAlphe(0x656565)

            UIView.animate(withDuration: 0.25, animations: {
                self.line.alpha = 1
                self.searchView.alpha = 1
                self.naviSegment.alpha = 0
                self.search.alpha = 0
            })
        }else {

            UIView.animate(withDuration: 0.25, animations: {
                self.line.alpha = 1
                self.searchView.alpha = 0
                self.naviSegment.alpha = 1
                self.search.alpha = 1
            })
        }
    }
}

// MARK: - UITableViewDataSource
extension NewMainViewController: UITableViewDataSource {
    
    //MARK : -  代理方法
    func numberOfSections(in tableView: UITableView) -> Int {
        if !isLoad {
            return 3
        }
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 3 {
            if isSurgery {
                return leftDateSource.count
            }else {
                return rightDateSource.count
            }
        }else {
            return 1
        }
    }
}

