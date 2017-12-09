//
//  NewMeDetailOrderViewController.swift
//  healthAndBeautyUser
//
//  Created by 丿番茄 on 2017/11/8.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewMeDetailOrderViewController: Wx_baseViewController {

    var type = Int()
    var id = String()
    var isLoad = Bool()
    
    var canDelete = Bool()
    
    @IBOutlet weak var controllerBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var dataSource = [NewOrderDetail]()
    var detailSource = [NewOrderDetailOtherTabCellModel]()
    
    var reasonSource = [NewOrderDetailOtherTabCellModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delog(type)
        switch type {
        case 0:
            build43Data()
            break
        case 1,3,4:
            build45Data()
            break
        case 5:
            build52Data()
            break
        default:
            break
        }
        buildUI()
    }
    
    override func rightClick() {
        
        //只有当右上角按钮为删除时候  这里才是true
        if canDelete {
            buildAlter("提示", "是否删除订单", "确定")
        }else {
            delog("退预约金")
            let drewback = NewDrawbackViewController.init(nibName: "NewDrawbackViewController", bundle: nil)
            drewback.dataSource = dataSource
            self.navigationController?.pushViewController(drewback, animated: true)
        }
    }
    override func alertController() {
        let up = ["mobileCode":Defaults["mobileCode"].stringValue,
                  "SESSIONID":Defaults["SESSIONID"].stringValue,
                  "id":id]
            as [String : Any]
        
        SVPWillShow("载入中...")
        delog(up)
        
        Net.share.postRequest(urlString: delProductOrder_53_joggle, params: up, success: { (datas) in
            let json = JSON(datas)
            delog(json)
            SVPHide()
            if json["code"].int == 1 {
                self.navigationController?.popToRootViewController(animated: true)
            }else {
                SVPwillShowAndHide(json["message"].string!)
            }
        }) { (error) in
            delog(error)
            SVPwillShowAndHide("请检查您的网路")
        }
    }
    
    private func buildUI() {
        
        tableView.tableFooterView = UIView.init()
        tableView.separatorStyle = .none
        
        tableView.register(UINib.init(nibName: "NewMeOrderListTabCell", bundle: nil), forCellReuseIdentifier: "NewMeOrderListTabCell")
        tableView.register(UINib.init(nibName: "NewOrderDetailDoctorTableViewCell", bundle: nil), forCellReuseIdentifier: "NewOrderDetailDoctorTableViewCell")
        tableView.register(UINib.init(nibName: "NewOrderDetailOtherTabCell", bundle: nil), forCellReuseIdentifier: "NewOrderDetailOtherTabCell")
        controllerBtn.layer.cornerRadius = 5.0
    }
    
    //43.待付款的项目订单详情:
    private func build43Data() {
        createNaviController(title: "订单详情", leftBtn: buildLeftBtn(), rightBtn: nil)
        controllerBtn.setTitle("支付预约金", for: .normal)
        
        let up = ["mobileCode":Defaults["mobileCode"].stringValue,
                  "SESSIONID":Defaults["SESSIONID"].stringValue,
                  "id":id]
            as [String: Any]
        
        SVPWillShow("加载中...")
        delog(up)
        
        Net.share.getRequest(urlString: stayOrder_43_joggle, params: up, success: { (datas) in
            let json = JSON(datas)
            SVPHide()
            delog(json)
            if json["code"].int == 1 {
                
                self.dataSource.removeAll()
                let subJson = json["data"]["stayOrder"]
                
                for (_, subJson2):(String, JSON) in subJson["orderProductChilds"] {
                    
                    //防止串值
                    let model = NewOrderDetail()
                    model.id = subJson["id"].string!
                    model.createDate = subJson["createDate"].string!
                    model.productTotal = subJson["productTotal"].float!
                    model.phone = subJson["phone"].string!
                    model.orderNo = subJson["orderNo"].string!
                    
                    model.thumbnail = subJson2["thumbnail"].string!
                    model.productName = subJson2["productName"].string!
                    model.productChildName = subJson2["productChildName"].string!
                    model.reservationPrice = subJson2["reservationPrice"].float!
                    model.prepaidPrice = subJson2["prepaidPrice"].float!
                    model.retainage = subJson2["retainage"].float!
                    model.num = subJson2["num"].int!
                    model.discountReservation = subJson2["discountReservation"].float!
                    model.discountRetainage = subJson2["discountRetainage"].float!
                    self.dataSource.append(model)
                }
                let model1 = NewOrderDetailOtherTabCellModel()
                model1.type = "订单状态:"
                model1.detail = "待付预约款"
                self.detailSource.append(model1)
                let model2 = NewOrderDetailOtherTabCellModel()
                model2.type = "订单预约金:"
                model2.detail = "￥ \(self.dataSource[0].productTotal)"
                self.detailSource.append(model2)
                let model3 = NewOrderDetailOtherTabCellModel()
                model3.type = "订单编号:"
                model3.detail = self.dataSource[0].orderNo
                self.detailSource.append(model3)
                let model4 = NewOrderDetailOtherTabCellModel()
                model4.type = "订单时间:"
                model4.detail = self.dataSource[0].createDate
                self.detailSource.append(model4)
                let model5 = NewOrderDetailOtherTabCellModel()
                model5.type = "手机号码:"
                model5.detail = self.dataSource[0].phone
                self.detailSource.append(model5)
                self.isLoad = true
                self.tableView.reloadData()
            }
        }) { (error) in
            delog(error)
        }
    }
    
    //45.项目订单详情信息接口:
    private func build45Data() {
        
        let up = ["mobileCode":Defaults["mobileCode"].stringValue,
                  "SESSIONID":Defaults["SESSIONID"].stringValue,
                  "id":id]
            as [String: Any]
        
        SVPWillShow("加载中...")
        delog(up)
        
        Net.share.getRequest(urlString: productOrder_45_joggle, params: up, success: { (datas) in
            let json = JSON(datas)
            SVPHide()
            delog(json)
            if json["code"].int == 1 {
                
                self.dataSource.removeAll()
                let subJson = json["data"]
                
                let model = NewOrderDetail()
                model.phone = subJson["phone"].string!
                model.placeOrderTime = subJson["placeOrderTime"].string!
                
                let subJson2 = subJson["productOrder"]
                model.id = subJson2["id"].string!
                model.orderNo = subJson2["orderNo"].string!
                model.thumbnail = subJson2["thumbnail"].string!
                model.productName = subJson2["productName"].string!
                model.productChildName = subJson2["productChildName"].string!
                model.reservationPrice = subJson2["reservationPrice"].float!
                model.prepaidPrice = subJson2["prepaidPrice"].float!
                model.residualPrice = subJson2["residualPrice"].float!
                model.retainage = subJson2["retainage"].float!
                model.num = subJson2["num"].int!
                model.discountReservation = subJson2["discountReservation"].float!
                model.discountRetainage = subJson2["discountRetainage"].float!

                model.payStatus = subJson2["payStatus"].string!
                
                model.orderStatus = subJson2["orderStatus"].string!
                if subJson2["orderStatus"].string! == "1" || subJson2["orderStatus"].string! == "2" {
                    model.projectName = subJson2["projectName"].string!
                    model.operationDate = subJson2["operationDate"].string!
                    for (_, doctors):(String,JSON) in subJson2["doctors"] {
                        let doctor = NewOrderDetailDoctorModel()
                        doctor.doctorsId = doctors["id"].string!
                        doctor.doctorsName = doctors["doctorName"].string!
                        model.doctors.append(doctor)
                    }
                }
                self.dataSource.append(model)
                let model1 = NewOrderDetailOtherTabCellModel()
                model1.type = "订单状态:"
                if subJson2["payStatus"].string! == "0" {
                    if subJson2["orderStatus"].string! == "0" {
                        model1.detail = "待确认"
                    }else if subJson2["orderStatus"].string! == "1" {
                        model1.detail = "待付尾款"
                    }
                }else {
                    model1.detail = "已完成"
                }
                self.detailSource.append(model1)
                let model1_1 = NewOrderDetailOtherTabCellModel()
                model1_1.type = "订单尾款:"
                model1_1.detail = "￥ \(self.dataSource[0].residualPrice)"
                self.detailSource.append(model1_1)
                let model2 = NewOrderDetailOtherTabCellModel()
                model2.type = "订单编号:"
                model2.detail = self.dataSource[0].orderNo
                self.detailSource.append(model2)
                let model3 = NewOrderDetailOtherTabCellModel()
                model3.type = "订单时间:"
                model3.detail = self.dataSource[0].placeOrderTime
                self.detailSource.append(model3)
                let model5 = NewOrderDetailOtherTabCellModel()
                model5.type = "手机号码:"
                model5.detail = self.dataSource[0].phone
                self.detailSource.append(model5)
                self.isLoad = true
                self.tableView.reloadData()
                if subJson2["payStatus"].string! == "0" {
                    if subJson2["orderStatus"].string! == "0" {
                        self.createNaviController(title: "订单详情", leftBtn: self.buildLeftBtn(), rightBtn: self.buildRightBtnWithName("申请退款"))
                        self.controllerBtn.setTitle("咨询", for: .normal)
                    }else if subJson2["orderStatus"].string! == "1" {
                        self.createNaviController(title: "订单详情", leftBtn: self.buildLeftBtn(), rightBtn: nil)
                        self.controllerBtn.setTitle("支付尾款", for: .normal)
                    }
                }else {
                    if subJson2["orderStatus"].string! == "2" {
                        self.createNaviController(title: "订单详情", leftBtn: self.buildLeftBtn(), rightBtn: self.buildRightBtnWithName("删除"))
                        self.canDelete = true
                        self.controllerBtn.setTitle("写日记", for: .normal)
                    }else {
                        self.createNaviController(title: "订单详情", leftBtn: self.buildLeftBtn(), rightBtn: nil)
                        self.controllerBtn.isHidden = true
                    }
                }
            }
        }) { (error) in
            delog(error)
        }
    }
    
    //52.项目退款订单详情:
    private func build52Data() {
        
        controllerBtn.removeFromSuperview()
        
        let up = ["mobileCode":Defaults["mobileCode"].stringValue,
                  "SESSIONID":Defaults["SESSIONID"].stringValue,
                  "id":id]
            as [String: Any]
        
        SVPWillShow("加载中...")
        delog(up)
        
        Net.share.getRequest(urlString: getRefundOrder_52_joggle, params: up, success: { (datas) in
            let json = JSON(datas)
            SVPHide()
            delog(json)
            if json["code"].int == 1 {
                
                self.dataSource.removeAll()
                
                //防止串值
                let model = NewOrderDetail()
                model.phone = json["data"]["orderRefund"]["phone"].string!
                model.placeOrderTime = json["data"]["orderRefund"]["placeOrderTime"].string!
                
                model.id = json["data"]["orderRefund"]["id"].string!
                model.createDate = json["data"]["orderRefund"]["createDate"].string!
                model.refundStatus = json["data"]["orderRefund"]["refundStatus"].string!
                model.refundCost = json["data"]["orderRefund"]["refundCost"].float!
                model.thumbnail = json["data"]["orderRefund"]["thumbnail"].string!
                model.productChildName = json["data"]["orderRefund"]["productChildName"].string!
                model.productName = json["data"]["orderRefund"]["productName"].string!
                model.productId = json["data"]["orderRefund"]["productId"].string!
                model.num = json["data"]["orderRefund"]["num"].int!
                model.orderNo = json["data"]["orderRefund"]["orderNo"].string!
                model.placeOrderTime = json["data"]["orderRefund"]["placeOrderTime"].string!
                if model.refundStatus != "0" {
                    model.handleDate = json["data"]["orderRefund"]["handleDate"].string!
                }
                if model.refundStatus == "2" {
                    model.remarks = json["data"]["orderRefund"]["remarks"].string!
                }
                self.dataSource.append(model)
                let model1 = NewOrderDetailOtherTabCellModel()
                model1.type = "退款状态:"
                //判断状态  创建导航栏
                if self.dataSource[0].refundStatus == "0" {
                    self.createNaviController(title: "订单详情", leftBtn: self.buildLeftBtn(), rightBtn: nil)
                    model1.detail = "进行中"
                }else if self.dataSource[0].refundStatus == "1" {
                    self.createNaviController(title: "订单详情", leftBtn: self.buildLeftBtn(), rightBtn: self.buildRightBtnWithName("删除"))
                    self.canDelete = true
                    model1.detail = "退款成功"
                }else {
                    self.createNaviController(title: "订单详情", leftBtn: self.buildLeftBtn(), rightBtn: self.buildRightBtnWithName("删除"))
                    self.canDelete = true
                    model1.detail = "退款失败"
                }
                self.detailSource.append(model1)
                let model2 = NewOrderDetailOtherTabCellModel()
                model2.type = "退款金额:"
                model2.detail = "￥ \(self.dataSource[0].refundCost)"
                self.detailSource.append(model2)
                let model3 = NewOrderDetailOtherTabCellModel()
                model3.type = "订单编号:"
                model3.detail = self.dataSource[0].orderNo
                self.detailSource.append(model3)
                let model4 = NewOrderDetailOtherTabCellModel()
                model4.type = "订单时间:"
                model4.detail = self.dataSource[0].placeOrderTime
                self.detailSource.append(model4)
                let model5 = NewOrderDetailOtherTabCellModel()
                model5.type = "手机号码:"
                model5.detail = self.dataSource[0].phone
                self.detailSource.append(model5)
                
                if self.dataSource[0].refundStatus == "1" {
                    let model6 = NewOrderDetailOtherTabCellModel()
                    model6.type = "处理时间:"
                    model6.detail = self.dataSource[0].handleDate
                    self.reasonSource.append(model6)
                    let model7 = NewOrderDetailOtherTabCellModel()
                    model7.type = "处理类型:"
                    if json["data"]["orderRefund"]["refundType"].string! == "1" {
                        model7.detail = "退预约款"
                    }else {
                        model7.detail = "退全款"
                    }
                    self.reasonSource.append(model7)
                    let model8 = NewOrderDetailOtherTabCellModel()
                    model8.type = "是否线下付款:"
                    if json["data"]["orderRefund"]["isLine"].string! == "0" {
                        model8.detail = "否"
                    }else {
                        model8.detail = "是"
                    }
                    self.reasonSource.append(model8)
                }else if self.dataSource[0].refundStatus == "2" {
                    let model6 = NewOrderDetailOtherTabCellModel()
                    model6.type = "处理时间:"
                    model6.detail = self.dataSource[0].handleDate
                    self.reasonSource.append(model6)
                    let model7 = NewOrderDetailOtherTabCellModel()
                    model7.type = "处理类型:"
                    if json["data"]["orderRefund"]["refundType"].string! == "1" {
                        model7.detail = "退预约款"
                    }else {
                        model7.detail = "退全款"
                    }
                    self.reasonSource.append(model7)
                    let model8 = NewOrderDetailOtherTabCellModel()
                    model8.type = "退款失败原因:"
                    model8.detail = json["data"]["orderRefund"]["remarks"].string!
                    self.reasonSource.append(model8)
                }
                
                self.isLoad = true
                self.tableView.reloadData()
            }
        }) { (error) in
            delog(error)
        }
    }
    
    @IBAction func click(_ sender: UIButton) {
        
        if sender.titleLabel!.text == "支付预约金" {
            let pay = NewStorePayDetailViewController.init(nibName: "NewStorePayDetailViewController", bundle: nil)
            pay.orderId = id
            self.navigationController?.pushViewController(pay, animated: true)
        }else if sender.titleLabel!.text == "支付尾款" {
            let pay = NewStorePayDetailViewController.init(nibName: "NewStorePayDetailViewController", bundle: nil)
            pay.orderId = id
            pay.isPayFinalMoney = true
            self.navigationController?.pushViewController(pay, animated: true)
        }else if sender.titleLabel!.text == "写日记" {
            
            self.tabBarController?.selectedIndex = 2
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}

// MARK: - UITableViewDelegate
extension NewMeDetailOrderViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 120
        }else {
            return 44
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {

            //一般cell
            let cell:NewMeOrderListTabCell? = tableView.dequeueReusableCell(withIdentifier: "NewMeOrderListTabCell") as? NewMeOrderListTabCell
            cell?.selectionStyle = .none
            cell?.type = type
            cell?.detailModel = dataSource[indexPath.row]
            return cell!
        }else if indexPath.section == 1 && dataSource[0].doctors.count != 0 {
            //如果是医生选择框
            if indexPath.row < dataSource[0].doctors.count {
                let cell:NewOrderDetailDoctorTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "NewOrderDetailDoctorTableViewCell") as? NewOrderDetailDoctorTableViewCell
                cell?.selectionStyle = .none
                cell?.model = dataSource[0].doctors[indexPath.row]
                return cell!
            }else {
                let cell:NewOrderDetailOtherTabCell? = tableView.dequeueReusableCell(withIdentifier: "NewOrderDetailOtherTabCell") as? NewOrderDetailOtherTabCell
                cell?.selectionStyle = .none
                let model = NewOrderDetailOtherTabCellModel()
                model.type = "项目开始时间:"
                model.detail = dataSource[0].operationDate
                cell?.model = model
                return cell!
            }
        }else {
            
            //如果是退款页面 那么这里多一个退款申请时间
            if type == 5 && indexPath.section == 1 {
                
                let cell:NewOrderDetailOtherTabCell? = tableView.dequeueReusableCell(withIdentifier: "NewOrderDetailOtherTabCell") as? NewOrderDetailOtherTabCell
                cell?.selectionStyle = .none
                let model = NewOrderDetailOtherTabCellModel()
                model.type = "申请时间:"
                model.detail = dataSource[0].createDate
                cell?.model = model
                return cell!
            }else if type == 5 && indexPath.section == 3 && reasonSource.count != 0 {
                //其他
                let cell:NewOrderDetailOtherTabCell? = tableView.dequeueReusableCell(withIdentifier: "NewOrderDetailOtherTabCell") as? NewOrderDetailOtherTabCell
                cell?.selectionStyle = .none
                cell?.model = reasonSource[indexPath.row]
                return cell!
            }
            //其他
            let cell:NewOrderDetailOtherTabCell? = tableView.dequeueReusableCell(withIdentifier: "NewOrderDetailOtherTabCell") as? NewOrderDetailOtherTabCell
            cell?.selectionStyle = .none
            cell?.model = detailSource[indexPath.row]
            return cell!
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let foot = UIView()
        foot.backgroundColor = lineColor
        return foot
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if type == 5 {
            return 10
        }
        if section == 0 {
            return 10
        }else if section == 1 && dataSource[0].doctors.count != 0 {
            return 10
        }else {
            return 0
        }
    }
}

// MARK: - UITableViewDataSource
extension NewMeDetailOrderViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if !isLoad {
            return 0
        }
        if dataSource[0].doctors.count != 0 {
            return 3
        }
        //需要退货的订单
        if type == 5 {
            if reasonSource.count == 0 {
                return 3
            }else {
                return 4
            }
        }
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if type == 5 {
            
            if section == 0 {
                return dataSource.count
            }else if section == 1 {
                return 1
            }else if section == 2 {
                return detailSource.count
            }else {
                return reasonSource.count
            }
        }
        if section == 0 {
            return dataSource.count
        }else if section == 1 && dataSource[0].doctors.count != 0 {
            return dataSource[0].doctors.count + 1
        }else {
            return detailSource.count
        }
    }
}
