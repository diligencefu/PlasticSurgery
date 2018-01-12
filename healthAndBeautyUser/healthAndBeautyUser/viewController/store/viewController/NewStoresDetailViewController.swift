//
//  NewStoresDetailViewController.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/10/13.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON
import MJRefresh

class NewStoresDetailViewController: Wx_baseViewController {

    //是否是项目
    var isProject = Bool()
    
    //页码
    var pageIndex : NSInteger = 1
    var pageMax : NSInteger = 1

    var id = String()
    //是否加载完数据
    var isLoad = Bool()
    var isEnshrine = Bool()
    
    //商品介绍
    var goodsDetail = NewStoreDetailModel()
    //医生列表
    var doctor = [doctorPage]()
    //状态判断
    ///商品详情与相关日记或评论的判断
    var isDetail : Bool! = true
    
    //相关项目
    var ProjectDateSource : [NewMain_NoteListModel] = []
    var GoodsDateSource : [NewStoreCommentModel] = []
    
    @IBOutlet weak var appointment: UILabel!
    @IBOutlet weak var willPay: UILabel!
    @IBOutlet weak var needPay: UILabel!
    @IBOutlet weak var collectionView: UIImageView!
    @IBOutlet weak var collectionLab: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //导航栏
    fileprivate var navigationView = UIView()
    fileprivate var navigationTitles = UILabel()
    fileprivate var navigationBack = UIButton()
    fileprivate var navigationShopCar = UIButton()
    
    //MARK: -
    override func viewDidLoad() {
        
        super.viewDidLoad()
        buildUI()
        buildNavi()
        buildData()
    }
    
    private func buildUI() {
        
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.register(UINib.init(nibName: "NewStoreDetailMainDetailTabCell", bundle: nil), forCellReuseIdentifier: "NewStoreDetailMainDetailTabCell")
        tableView.register(UINib.init(nibName: "NewStoreDetailDoctorMessageTabCell", bundle: nil), forCellReuseIdentifier: "NewStoreDetailDoctorMessageTabCell")
        tableView.register(UINib.init(nibName: "NewStoreDetailGoodsDetailTabCell", bundle: nil), forCellReuseIdentifier: "NewStoreDetailGoodsDetailTabCell")
        tableView.register(NewMineNoteListTableViewCell.self, forCellReuseIdentifier: "NewMineNoteListTableViewCell")
        tableView.register(NewStoreCommentTabCell.self, forCellReuseIdentifier: "NewStoreCommentTabCell")
        
        weak var weakSelf = self
        tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            weakSelf?.pageIndex = 1
            if weakSelf!.isProject {
                weakSelf?.getProjectNoteData()
            }else {
                weakSelf?.getGoodsCommentData()
            }
        })
    }
    
    private func buildData() {
        
        var up = ["id":id]
            as [String: Any]
        
        if Defaults.hasKey("SESSIONID") {
            up["mobileCode"] = Defaults["mobileCode"].stringValue
            up["SESSIONID"] = Defaults["SESSIONID"].stringValue
        }
        
        SVPWillShow("载入中...")
        delog(up)
        
        let url = (isProject ? getProduct_13_joggle : getGoodItem_10_joggle)
        
        Net.share.getRequest(urlString: url, params: up, success: { (datas) in
            
            let json = JSON(datas)
            delog(json)
            SVPHide()
            if json["code"].int == 1 {
                
                let data = json["data"]
                if self.isProject {
                    let product = data["product"]
                    self.goodsDetail.id = product["id"].string!
                    self.goodsDetail.productName = product["productName"].string!
                    self.goodsDetail.productChildName = product["productChildName"].string!
                    self.goodsDetail.productDescrible = product["productDescrible"].string!
                    self.goodsDetail.images = product["images"].arrayObject as! [String]
                    self.goodsDetail.reservationPrice = product["reservationPrice"].float!
                    self.goodsDetail.salaPrice = product["salaPrice"].float!
                    self.goodsDetail.disPrice = product["disPrice"].float!
                    self.goodsDetail.reservationCount = product["reservationCount"].int!
                    
                    self.goodsDetail.isFree = product["isFree"].string!

                    self.goodsDetail.productType = data["productType"].string!
                    self.goodsDetail.isEnshrine = data["isEnshrine"].bool!
                    self.isEnshrine = data["isEnshrine"].bool!

                    //刷新项目数据
                    for (_, subJson):(String, JSON) in data["doctors"] {
                        let model = doctorPage()
                        model.id = subJson["id"].string!
                        model.doctorName = subJson["doctorName"].string!
                        model.headImage = subJson["headImage"].string!
                        model.projectNames = subJson["projectNames"].string!
                        self.doctor.append(model)
                    }
                    self.needPay.isHidden = true
                    self.appointment.text = "预约金：￥\(self.goodsDetail.reservationPrice)"
                    self.willPay.text = "到院再付：￥\(self.goodsDetail.disPrice - self.goodsDetail.reservationPrice )"
                    self.getProjectNoteData()
                }else {
                    
                    let goodItem = data["goodItem"]
                    self.goodsDetail.id = goodItem["id"].string!
                    self.goodsDetail.productName = goodItem["goodItemName"].string!
                    self.goodsDetail.productChildName = goodItem["goodItemChildName"].string!
                    self.goodsDetail.productDescrible = goodItem["goodItemDescrible"].string!
                    self.goodsDetail.images = goodItem["images"].arrayObject as! [String]
//                    self.goodsDetail.reservationPrice = goodItem["reservationPrice"].float!
                    self.goodsDetail.salaPrice = goodItem["salaPrice"].float!
                    self.goodsDetail.disPrice = goodItem["disPrice"].float!
                    self.goodsDetail.reservationCount = goodItem["reservationCount"].int!
                    
//                    self.goodsDetail.isFree = goodItem["isFree"].string!

//                    if goodItem["isFreeShipping"].string != nil {
                        self.goodsDetail.isFreeShipping = goodItem["isFreeShipping"].string!
//                    }
                    
//                    if goodItem["postage"].float != nil {
                        self.goodsDetail.postage = goodItem["postage"].float!
//                    }
                    
                    self.goodsDetail.productType = data["productType"].string!
                    self.goodsDetail.isEnshrine = data["isEnshrine"].bool!
                    self.isEnshrine = data["isEnshrine"].bool!
                    
                    self.needPay.isHidden = false
                    self.needPay.text = "需支付:￥\(self.goodsDetail.disPrice)"
                    self.appointment.isHidden = true
                    self.willPay.isHidden = true
                    self.getGoodsCommentData()
                }
                self.changeState()
            }else {
                SVPwillShowAndHide("数据错误")
                self.navigationController?.popViewController(animated: true)
            }
        }) { (error) in
            delog(error)
        }
    }
    
    //项目日记列表接口
    fileprivate func getProjectNoteData() {
        
        var up = ["id":id,
                  "pageNo":pageIndex]
            as [String: Any]
        
        if Defaults.hasKey("SESSIONID") {
            up["mobileCode"] = Defaults["mobileCode"].stringValue
            up["SESSIONID"] = Defaults["SESSIONID"].stringValue
        }
        
        SVPWillShow("载入中...")
        delog(up)
        
        Net.share.getRequest(urlString: getProductArticles_14_joggle, params: up, success: { (datas) in
            
            let json = JSON(datas)
            delog(json)
            SVPHide()
            if json["code"].int == 1 {
                
                self.pageMax = json["data"]["totalPage"].int!
                if self.pageIndex == 1 {
                    self.ProjectDateSource.removeAll()
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
                    model.images = article["images"].string!
                    model.createDate = article["createDate"].string!
                    model.comments = article["comments"].string!
                    model.thumbs = article["thumbs"].string!
                    model.hits = article["hits"].string!
                    self.ProjectDateSource.append(model)
                }
                self.isLoad = true
                self.tableView.reloadData()
            }
            self.endRefresh()
        }) { (error) in
            delog(error)
        }
    }
    
    //商品评价列表
    fileprivate func getGoodsCommentData() {
        
        var up = ["id":id,
                  "pageNo":pageIndex]
            as [String: Any]
        
        if Defaults.hasKey("SESSIONID") {
            up["mobileCode"] = Defaults["mobileCode"].stringValue
            up["SESSIONID"] = Defaults["SESSIONID"].stringValue
        }
        
        SVPWillShow("载入中...")
        delog(up)
        
        Net.share.getRequest(urlString: goodCommentList_11_joggle, params: up, success: { (datas) in
            
            let json = JSON(datas)
            delog(json)
            SVPHide()
            if json["code"].int == 1 {
                
                self.pageMax = json["data"]["totalPage"].int!
                if self.pageIndex == 1 {
                    self.GoodsDateSource.removeAll()
                }
                let data = json["data"]
                for (_ , subJson) : (String , JSON) in data["goodComments"] {
                    
                    let model = NewStoreCommentModel()
                    
                    model.content = subJson["content"].string!
                    model.createDate = subJson["createDate"].string!
                        let personal = subJson["personal"]
                        model.id = personal["id"].string!
                        model.nickName = personal["nickName"].string!
                        model.photo = personal["photo"].string!
                        model.gender = personal["gender"].string!
                    self.GoodsDateSource.append(model)
                }
                self.isLoad = true
                self.tableView.reloadData()
            }
            self.endRefresh()
        }) { (error) in
            delog(error)
        }
    }
    
    //停止刷新
    private func endRefresh() {
        
        tableView.mj_header.endRefreshing()
    }
    
    //MARK: 底部操作栏
    @IBAction func controller(_ sender: UIButton) {
        switch sender.tag {
        case 100:
            delog("收藏")
            collectionController()
            break
        case 101:
            delog("加入购物车")
            addShoppingCarController()
            break
        case 102:
            delog("立即购买")
            shopNowController()
            break
        case 200:
            delog("返回")
            navigationController?.popViewController(animated: true)
            break
        case 201:
            delog("购物车")
            gotoShoppingCar()
            break
        default:
            break
        }
    }
    
    //修改底部状态
    private func changeState() {
        
        DispatchQueue.main.async {
            delog(self.isEnshrine)
            if self.isEnshrine {
                self.collectionView.image = UIImage(named:"collection_icon")
            }else {
                self.collectionView.image = UIImage(named:"collection")
            }
        }
    }
    
    //立即购买接口
    private func shopNowController() {

        var up = ["type" : (isProject ? "1" : "2"),
                  "id": id]
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
        
        Net.share.postRequest(urlString: buy_15_joggle, params: up, success: { (datas) in
            
            let json = JSON(datas)
            delog(json)
            SVPHide()
            if json["code"].int == 1 {
                
                let require = NewNowPayViewController.init(nibName: "NewNowPayViewController", bundle: nil)
                require.isProject = self.isProject
                require.id = [self.id]
                require.flag = "2"
                self.navigationController?.pushViewController(require, animated: true)
            }else {
                if json["message"].string! == "尚未登录,请登录!" || json["message"].string! == "尚未登录,请登录!" {
                    let login = NewLoginLocationViewController.init(nibName: "NewLoginLocationViewController", bundle: nil)
                    let loginVC = Wx_baseNaviViewController.init(rootViewController: login)
                    self.present(loginVC, animated: true, completion: nil)
                    SVPwillShowAndHide(json["message"].string!)
                }
            }
        }) { (error) in
            delog(error)
            SVPwillShowAndHide("请检查您的网路")
        }
    }
    
    //加入购物车操作
    private func addShoppingCarController() {

        var up = ["type" : (isProject ? "1" : "2"),
                  "id": id,
                  "num": "+1"]
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
        
        Net.share.postRequest(urlString: addShopCar_16_joggle, params: up, success: { (datas) in
            
            let json = JSON(datas)
            delog(json)
            SVPHide()
            if json["code"].int == 1 {
                SVPwillSuccessShowAndHide("加入购物车成功")
            }else {
                SVPwillShowAndHide(json["message"].string!)
            }
        }) { (error) in
            delog(error)
            SVPwillShowAndHide("请检查您的网路")
        }
    }
    
    //收藏操作
    private func collectionController() {
        
        var up = ["collectionType" : (isProject ? "2" : "3"),
                  "collection":id]
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
        
        if isEnshrine {
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
                if self.isEnshrine {
                    self.collectionView.image = UIImage(named:"collection")
                    self.isEnshrine = false
                }else {
                    self.collectionView.image = UIImage(named:"collection_icon")
                    self.isEnshrine = true
                }
            }else {
                SVPwillShowAndHide(json["message"].string!)
            }
        }) { (error) in
            delog(error)
            SVPwillShowAndHide("请检查您的网路")
        }
    }
}

// MARK: - 导航栏效果
extension NewStoresDetailViewController {

    fileprivate func buildNavi() {
        
        navigationView.backgroundColor = backGroundColor
        navigationView.alpha = 0
        navigationView.frame = CGRect.init(x: 0, y: 0, width: WIDTH, height: (HEIGHT == 812 ? 88 : 64))
        view.addSubview(navigationView)
        
        navigationTitles.text = "商品详情"
        navigationTitles.textAlignment = .center
        navigationTitles.textColor = UIColor.darkText
        navigationTitles.font = UIFont.systemFont(ofSize: 18)
        let sizes = getSizeOnLabel(navigationTitles)
        navigationTitles.frame = CGRect.init(x: (WIDTH - sizes.width)/2, y: (HEIGHT == 812 ? 44 : 20), width: sizes.width, height: 44)
        navigationView.addSubview(navigationTitles)
        
        navigationBack.setImage(UIImage(named:"fanhui"), for: .normal)
        navigationBack.addTarget(self, action: #selector(pop), for: .touchUpInside)
        navigationBack.frame = CGRect.init(x: 0, y: (HEIGHT == 812 ? 44 : 20), width: 44, height: 44)
        navigationView.addSubview(navigationBack)
        
        navigationShopCar.setImage(UIImage(named:"shopping-trolley"), for: .normal)
        navigationShopCar.addTarget(self, action: #selector(gotoShoppingCar), for: .touchUpInside)
        navigationShopCar.frame = CGRect.init(x: WIDTH - 44, y: (HEIGHT == 812 ? 44 : 20), width: 44, height: 44)
        navigationView.addSubview(navigationShopCar)
        
        let line = UIView()
        line.backgroundColor = lineColor
        line.frame = CGRect.init(x: 0, y: (HEIGHT == 812 ? 87.5 : 63.5), width: WIDTH, height: 0.5)
        navigationView.addSubview(line)
    }
    
    //购物车
    @objc fileprivate func gotoShoppingCar() {
        let tmp = NewShoppingCarViewController.init(nibName: "NewShoppingCarViewController", bundle: nil)
        navigationController?.pushViewController(tmp, animated: true)
    }
}

extension NewStoresDetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y <= 100 {
            navigationView.alpha = scrollView.contentOffset.y / 100
        }else {
            navigationView.alpha = 1
        }
    }
}

// MARK: - UITableViewDelegate
extension NewStoresDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            
            let str = goodsDetail.productName + goodsDetail.productChildName
            let sizes = getSizeOnString( str, 18)
            return 310 + sizes.height+20
        case 1:
            
            if isProject {
                return 75
            }else {
                let sizes = getSizeOnString(goodsDetail.productDescrible, 16)
                return sizes.height + 35
            }
        case 2:
            
            if isProject {
                
                let sizes = getSizeOnString(goodsDetail.productDescrible, 16)
                return sizes.height + 35
                
            }else {
                
                var height = CGFloat()
                let sizes = getSizeOnString(GoodsDateSource[indexPath.row].content, 14)
                height += sizes.height + 25
                height += GET_SIZE * 120
                return height
            }
        case 3:
            return GET_SIZE * 640
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell:NewStoreDetailMainDetailTabCell? = tableView.dequeueReusableCell(withIdentifier: "NewStoreDetailMainDetailTabCell") as? NewStoreDetailMainDetailTabCell
            cell?.selectionStyle = .none
            cell?.model = goodsDetail
            return cell!
        case 1:
            //项目这里显示的医生
            if isProject {
                
                let cell:NewStoreDetailDoctorMessageTabCell? = tableView.dequeueReusableCell(withIdentifier: "NewStoreDetailDoctorMessageTabCell") as? NewStoreDetailDoctorMessageTabCell
                cell?.selectionStyle = .none
                cell?.model = doctor[indexPath.row]
                return cell!
            }else {
                
                let cell:NewStoreDetailGoodsDetailTabCell? = tableView.dequeueReusableCell(withIdentifier: "NewStoreDetailGoodsDetailTabCell") as? NewStoreDetailGoodsDetailTabCell
                cell?.selectionStyle = .none
                cell?.model = goodsDetail
                return cell!
            }
        case 2:
            //项目这里显示的是日记 商品则是评论
            if isProject {
                //项目这里不刷新数据
                let cell:NewStoreDetailGoodsDetailTabCell? = tableView.dequeueReusableCell(withIdentifier: "NewStoreDetailGoodsDetailTabCell") as? NewStoreDetailGoodsDetailTabCell
                cell?.selectionStyle = .none
                cell?.model = goodsDetail
                return cell!
            }else {
                //这里刷新商品数据
                if pageIndex < pageMax && indexPath.row >= GoodsDateSource.count - 2 {
                    pageIndex += 1
                    getGoodsCommentData()
                }
                var cell:NewStoreCommentTabCell? = tableView.dequeueReusableCell(withIdentifier: "NewStoreCommentTabCell") as? NewStoreCommentTabCell
                if nil == cell {
                    cell! = NewStoreCommentTabCell.init(style: .default, reuseIdentifier: "NewStoreCommentTabCell")
                }
                cell?.selectionStyle = .none
                cell?.goodsModel = GoodsDateSource[indexPath.row]
                return cell!
            }
        case 3:
            //这里刷新项目数据
            if pageIndex < pageMax && indexPath.row >= ProjectDateSource.count - 2 {
                pageIndex += 1
                getGoodsCommentData()
            }
            var cell:NewMineNoteListTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "NewMineNoteListTableViewCell") as? NewMineNoteListTableViewCell
            if nil == cell {
                cell! = NewMineNoteListTableViewCell.init(style: .default, reuseIdentifier: "NewMineNoteListTableViewCell")
            }
            cell?.selectionStyle = .none
            cell?.model = ProjectDateSource[indexPath.row]
            return cell!
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = lineColor
        return view
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section < 1 {
            return 10
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if isProject {
            
            if section == 2 || section == 3 {
                
                let view = UIView()
                view.backgroundColor = backGroundColor
                
                let colorView = UIView()
                colorView.backgroundColor = tabbarColor
                colorView.frame = CGRect.init(x: 12, y: 19, width: 3, height: 15)
                view.addSubview(colorView)
                
                let title = UILabel()
                title.text = ((section == 2) ? "商品详情" : "相关日记")

                title.font = UIFont.systemFont(ofSize: 16)
                title.textColor = darkText
                title.frame = CGRect.init(x: 27, y: 19, width: WIDTH/3, height: 15)
                view.addSubview(title)
                
                let line = UIView()
                line.backgroundColor = lineColor
                line.frame = CGRect.init(x: 17, y: 48.5, width: WIDTH, height: 0.5)
                view.addSubview(line)
                
                return view
            }
        }else {
            
            if section == 1 || section == 2 {

                let view = UIView()
                view.backgroundColor = backGroundColor
                
                let colorView = UIView()
                colorView.backgroundColor = tabbarColor
                colorView.frame = CGRect.init(x: 12, y: 19, width: 3, height: 15)
                view.addSubview(colorView)
                
                let title = UILabel()
                title.text = ((section == 1) ? "商品详情" : "商品评论")
                title.font = UIFont.systemFont(ofSize: 16)
                title.textColor = darkText
                title.frame = CGRect.init(x: 27, y: 19, width: WIDTH/3, height: 15)
                view.addSubview(title)
                
                let line = UIView()
                line.backgroundColor = lineColor
                line.frame = CGRect.init(x: 17, y: 48.5, width: WIDTH, height: 0.5)
                view.addSubview(line)
                
                return view
            }
        }
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if isProject {
            if section == 2 || section == 3 {
                return 49
            }
        }else {
            if section == 1 || section == 2 {
                return 49
            }
        }
        return 0
    }
}

// MARK: - UITableViewDataSource
extension NewStoresDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if !isLoad {
            return 0
        }
        
        //商品没有医生相关
        if isProject {
            //如果没有日记
            if ProjectDateSource.count  == 0 {
                return 3
            }
            return 4
        }
        //如果没有评价
        if GoodsDateSource.count  == 0 {
            return 2
        }
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        }
        if isProject {
            
            if section == 1 {
                return doctor.count
            }
            if section == 2 {
                return 1
            }
            if section == 3 {
                return ProjectDateSource.count
            }
        }else {
            
            if section == 1 {
                return 1
            }
            if section == 2 {
                return GoodsDateSource.count
            }
        }
        return 0
    }
}
