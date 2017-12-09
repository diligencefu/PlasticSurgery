//
//  NewNowPayViewController.swift
//  healthAndBeautyUser
//
//  Created by 丿番茄 on 2017/11/24.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewNowPayViewController: Wx_baseViewController {
    
    //页面第一次加载的时候
    var isFirstShow : Bool = true
    
    var isProject = Bool()
    var id = [String]()
    var flag = String()
    
    var isLoad = Bool()
    var isHaveAddress = Bool()
    var phone = String()
    var location = NewStoreLocationModel()
    //是否自取
    var isMineGet = Bool()
    
    //VIP会员用的字段
    var vipLv = String()
    var discount = Float()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var price1: UILabel!
    @IBOutlet weak var price2: UILabel!
    @IBOutlet weak var price3: UILabel!
    
    @IBOutlet weak var mineGet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RequireOrderDataSource.removeAll()
        createNaviController(title: "立即购买", leftBtn: buildLeftBtn(), rightBtn: nil)
        NewPostLocationViewControllerLocationModel = NewStoreLocationModel()
        loadMineSelectModel = false
        buildUI()
        buildData()
        
        //初始化数据
        selectAppointmentDataSource = [NewSelectBookListModel]()
        selectFinalDataSource = [NewSelectBookListModel]()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isFirstShow {
            isFirstShow = false
        }else {
            tableView.reloadData()
            reBUildUI()
        }
    }
    
    private func buildUI() {
        
        tableView.tableFooterView = UIView.init()
        tableView.separatorStyle = .none
        
        tableView.register(UINib.init(nibName: "NewRequireListTabCell", bundle: nil), forCellReuseIdentifier: "NewRequireListTabCell")
        tableView.register(UINib.init(nibName: "NewRequireGoodsTabCell", bundle: nil), forCellReuseIdentifier: "NewRequireGoodsTabCell")
        tableView.register(UINib.init(nibName: "NewRequireOtherTableViewCell", bundle: nil), forCellReuseIdentifier: "NewRequireOtherTableViewCell")
        tableView.register(UINib.init(nibName: "NewRequireLocationTableViewCell", bundle: nil), forCellReuseIdentifier: "NewRequireLocationTableViewCell")
        tableView.register(UINib.init(nibName: "NewLocationNillTabCell", bundle: nil), forCellReuseIdentifier: "NewLocationNillTabCell")
    }
    
    private func buildData() {
        
        var ids = String()
        for index in id {
            ids += index
            if index == id.last {
                continue
            }
            ids += ","
        }
        
        let up = ["SESSIONID":Defaults["SESSIONID"].stringValue,
                  "mobileCode":Defaults["mobileCode"].stringValue,
                  "ids":ids,
                  "type": (isProject) ? "1" : "2",
                  "flag": flag]
            as [String:Any]
        
        SVPWillShow("载入中...")
        delog(up)
        
        Net.share.getRequest(urlString: confirmOrder_20_joggle, params: up,success: { (data) in
            
            let json = JSON(data)
            SVPHide()
            delog(json)
            
            if json["code"].int == 1 {
                
                //确认订单列表
                RequireOrderDataSource.removeAll()
                for (_, subJson):(String, JSON) in json["data"]["carList"] {
                    
                    let model = NewStoreShopCarModel()
                    model.thumbnail = subJson["thumbnail"].string!
                    model.doctorName = subJson["doctorName"].string!
                    model.id = subJson["id"].string!
                    model.goodType = subJson["goodType"].string!
                    model.payPrice = subJson["payPrice"].float!
                    model.goodChildName = subJson["goodChildName"].string!
                    model.num = subJson["num"].int!
                    model.goodName = subJson["goodName"].string!
                    model.isDiscount = subJson["isDiscount"].string!
                    if subJson["goodType"].string! == "1" {
                        model.retainage = subJson["retainage"].float!
                    }else {
                        if subJson["other"].string != nil {
                            model.other = subJson["other"].string!
                            model.otherPrice = subJson["otherPrice"].float!
                        }
                    }
                    model.currentGoodsCount = 1
                    RequireOrderDataSource.append(model)
                }
                
                if json["data"]["memberLevel"].dictionary != nil {
                    
                    self.vipLv = json["data"]["memberLevel"]["memberName"].string!
                    self.discount = json["data"]["memberLevel"]["discount"].float!
                }
                
                //地址
                if json["data"]["isAddress"].bool != nil {
                    
                    self.isHaveAddress = json["data"]["isAddress"].bool!
                    if json["data"]["isAddress"].bool! {
                        self.location.id = json["data"]["address"]["id"].string!
                        self.location.area = json["data"]["address"]["area"].string!
                        self.location.realName = json["data"]["address"]["realName"].string!
                        self.location.street = json["data"]["address"]["street"].string!
                        self.location.tel = json["data"]["address"]["tel"].string!
                    }
                }
                //预约金优惠券
                if selectAppointmentDataSource.count == 0 {
                    
                    for (_, subJson):(String, JSON) in json["data"]["bespokeCoupons"] {
                        
                        let model = NewSelectBookListModel()
                        model.counponId = subJson["counponId"].string!
                        model.receiveNum = subJson["receiveNum"].int!
                        model.userNum = subJson["userNum"].int!
                        model.couponName = subJson["coupon"]["couponName"].string!
                        model.counponAmount = subJson["coupon"]["counponAmount"].float!
                        model.counponStartDate = subJson["coupon"]["counponStartDate"].string!
                        model.couponEndDate = subJson["coupon"]["couponEndDate"].string!
                        model.counponKind = subJson["coupon"]["counponKind"].string!
                        model.counponUsingRange = subJson["coupon"]["counponUsingRange"].string!
                        if model.counponUsingRange == "2" {
                            model.productIds = subJson["coupon"]["productIds"].string!
                            model.projectNames = subJson["coupon"]["projectNames"].string!
                        }
                        model.counponExplain = subJson["coupon"]["counponExplain"].string!
                        model.meetPrice = subJson["coupon"]["meetPrice"].float!
                        selectAppointmentDataSource.append(model)
                    }
                }
                //尾款优惠券
                if selectFinalDataSource.count == 0 {
                    
                    for (_, subJson):(String, JSON) in json["data"]["retainageCoupons"] {
                        
                        let model = NewSelectBookListModel()
                        model.counponId = subJson["counponId"].string!
                        model.receiveNum = subJson["receiveNum"].int!
                        model.userNum = subJson["userNum"].int!
                        model.couponName = subJson["coupon"]["couponName"].string!
                        model.counponAmount = subJson["coupon"]["counponAmount"].float!
                        model.counponStartDate = subJson["coupon"]["counponStartDate"].string!
                        model.couponEndDate = subJson["coupon"]["couponEndDate"].string!
                        model.counponKind = subJson["coupon"]["counponKind"].string!
                        model.counponUsingRange = subJson["coupon"]["counponUsingRange"].string!
                        if model.counponUsingRange == "2" {
                            model.productIds = subJson["coupon"]["productIds"].string!
                            model.projectNames = subJson["coupon"]["projectNames"].string!
                        }
                        model.counponExplain = subJson["coupon"]["counponExplain"].string!
                        model.meetPrice = subJson["coupon"]["meetPrice"].float!
                        selectFinalDataSource.append(model)
                    }
                }
                self.phone = json["data"]["phone"].string!
                self.isLoad = true
                self.tableView.reloadData()
                self.reBUildUI()
            }else {
                SVPwillShowAndHide("数据请求失败!")
            }
        }) { (error) in
            SVPwillShowAndHide("网络连接错误!")
        }
    }
    
    fileprivate func reBUildUI() {
        
        //底部价格计算 UI刷新
        if isProject {
            var tmpPrice1 = Float()
            var tmpPrice2 = Float()
            for index in RequireOrderDataSource {
                
                tmpPrice1 += index.payPrice * Float(index.currentGoodsCount)
                if index.book1.count != 0 {
                    for book in selectAppointmentDataSource {
                        if index.book1 == book.counponId {
                            tmpPrice1 -= book.counponAmount
                        }
                    }
                }
                
                tmpPrice2 += index.retainage * Float(index.currentGoodsCount)
                if index.book2.count != 0 {
                    for book in selectFinalDataSource {
                        if index.book2 == book.counponId {
                            tmpPrice2 -= book.counponAmount
                        }
                    }
                }
            }
            price1.text = "预约金合计：￥\(tmpPrice1)"
            price2.text = "尾款合计：￥\(tmpPrice2)"
            mineGet.isHidden = true
            price3.isHidden = true
            price1.isHidden = false
            price2.isHidden = false
        }else {
            var tmpPrice1 = Float()
            for index in RequireOrderDataSource {
                tmpPrice1 += index.payPrice * Float(index.currentGoodsCount)
                if !isMineGet && index.other == "0" {
                    tmpPrice1 += index.otherPrice
                }
            }
            price3.text = "金额合计：￥\(tmpPrice1)"
            price1.isHidden = true
            price2.isHidden = true
            mineGet.isHidden = false
            price3.isHidden = false
        }
    }
    
    @IBAction func click(_ sender: UIButton) {
        switch sender.tag {
            
        case 700:
            //自取按钮
            sender.isSelected = !sender.isSelected
            isMineGet = sender.isSelected
            tableView.reloadData()
            reBUildUI()
            break
            
        case 701:
            //确认订单
            requireOrder()
            break
        default:
            break
        }
    }
    
    // MARK: 确认订单
    private func requireOrder() {
        
        var up = ["mobileCode":Defaults["mobileCode"].stringValue,
                  "SESSIONID":Defaults["SESSIONID"].stringValue,
                  "goodType":(isProject ? "1" : "2")]
            as [String: Any]
        
        if isProject {
            //价格
            var tmpPrice1 = Float()
            for index in RequireOrderDataSource {
                tmpPrice1 += index.payPrice * Float(index.currentGoodsCount)
                if index.book1.count != 0 {
                    for book in selectAppointmentDataSource {
                        if index.book1 == book.counponId {
                            tmpPrice1 -= book.counponAmount
                        }
                    }
                }
            }
            up["total"] = tmpPrice1
        }else {
            //价格
            var tmpPrice1 = Float()
            for index in RequireOrderDataSource {
                tmpPrice1 += index.payPrice * Float(index.currentGoodsCount)
                if !isMineGet && index.other == "0" {
                    tmpPrice1 += index.otherPrice
                }
            }
            up["total"] = tmpPrice1
            
            //是否自提
            if isMineGet {
                up["pickType"] = "1"
            }else {
                up["pickType"] = "2"
                //地址ID
                if loadMineSelectModel {
                    up["addressId"] = NewPostLocationViewControllerLocationModel.id
                }else{
                    up["addressId"] = location.id
                }
            }
        }
        //手机号码
        up["phone"] = phone
        
        var arr = [NSDictionary]()
        for num in 0..<RequireOrderDataSource.count {
            if isProject {
                let dic : NSDictionary = ["goodId":RequireOrderDataSource[num].id,
                                          "num":"\(RequireOrderDataSource[num].currentGoodsCount)",
                    "couponId1":RequireOrderDataSource[num].book1,
                    "couponId2":RequireOrderDataSource[num].book2]
                arr.append(dic)
            }else {
                let dic : NSDictionary = ["goodId":RequireOrderDataSource[num].id,
                                          "num":"\(RequireOrderDataSource[num].currentGoodsCount)"]
                arr.append(dic)
            }
        }
        let tmpJson : JSON = ["data":arr]
        delog(tmpJson)
        up["json"] = tmpJson.rawString()
        
        delog(up)
        SVPWillShow("载入中...")
        
        Net.share.postRequest(urlString: createOrder_25_joggle, params: up, success: { (datas) in
            let json = JSON(datas)
            delog(json)
            SVPHide()
            if json["code"].int == 1 {
                let pay = NewStorePayDetailViewController.init(nibName: "NewStorePayDetailViewController", bundle: nil)
                pay.orderId = json["data"]["orderId"].string!
                self.navigationController?.pushViewController(pay, animated: true)
            }
        }) { (error) in
            delog(error)
        }
    }
}

// MARK: - UITableViewDelegate
extension NewNowPayViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        if !isProject && indexPath.section == 1 {
            let view = NewPostLocationViewController.init(nibName: "NewPostLocationViewController", bundle: nil)
            navigationController?.pushViewController(view, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            if isProject {
                return 225
            }else {
                return 135
            }
        }else {
            if isProject {
                return 40
            }else {
                if isProject {
                    return 40
                }
                return 90
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            if isProject {
                let cell:NewRequireListTabCell? = tableView.dequeueReusableCell(withIdentifier: "NewRequireListTabCell") as? NewRequireListTabCell
                cell?.selectionStyle = .none
                cell?.isPayNow = true
                cell?.vipLv = vipLv
                cell?.discount = discount
                cell?.model = RequireOrderDataSource[indexPath.row]
                cell?.index = indexPath
                weak var weakSelf = self
                cell?.callBackBlock(block: { (numk) in
                    weakSelf?.tableView.reloadData()
                    weakSelf?.reBUildUI()
                })
                return cell!
            }else {
                let cell:NewRequireGoodsTabCell? = tableView.dequeueReusableCell(withIdentifier: "NewRequireGoodsTabCell") as? NewRequireGoodsTabCell
                cell?.selectionStyle = .none
                cell?.isPayNow = true
                cell?.index = indexPath
                cell?.model = RequireOrderDataSource[indexPath.row]
                weak var weakSelf = self
                cell?.callBackBlock(block: { (numk) in
                    weakSelf?.tableView.reloadData()
                    weakSelf?.reBUildUI()
                })
                return cell!
            }
        }else {
            if isProject {
                let cell:NewRequireOtherTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "NewRequireOtherTableViewCell") as? NewRequireOtherTableViewCell
                cell?.selectionStyle = .none
                cell?.phoneNum = phone
                return cell!
            }else {
                if isHaveAddress {
                    let cell:NewRequireLocationTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "NewRequireLocationTableViewCell") as? NewRequireLocationTableViewCell
                    cell?.selectionStyle = .none
                    if loadMineSelectModel {
                        cell?.model = NewPostLocationViewControllerLocationModel
                    }else{
                        cell?.model = location
                    }
                    return cell!
                }else {
                    let cell:NewLocationNillTabCell? = tableView.dequeueReusableCell(withIdentifier: "NewLocationNillTabCell") as? NewLocationNillTabCell
                    cell?.selectionStyle = .none
                    return cell!
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let tmp = UIView()
        tmp.backgroundColor = lineColor
        return tmp
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 10
        } else {
            return 0
        }
    }
}

// MARK: - UITableViewDataSource
extension NewNowPayViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if !isLoad {
            return 0
        }
        if isMineGet {
            return 1
        }
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return RequireOrderDataSource.count
        }else {
            return 1
        }
    }
}
