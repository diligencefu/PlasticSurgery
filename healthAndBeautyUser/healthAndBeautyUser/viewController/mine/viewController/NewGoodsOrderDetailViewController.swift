//
//  NewGoodsOrderDetailViewController.swift
//  healthAndBeautyUser
//
//  Created by 丿番茄 on 2017/11/11.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewGoodsOrderDetailViewController: Wx_baseViewController {

    var type = Int()
    var id = String()
    var isLoad = Bool()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var controller: UIButton!
    
    var dataSource = [NewGoodsDetailModel]()
    var detailSource = [NewOrderDetailOtherTabCellModel]()
    var location : NewStoreLocationModel? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        delog(type)
        switch type {
        case 0:
            build55Data()
            break
        case 1,2,3:
            build57Data()
            break
        case 4:
            build62Data()
            break
        default:
            break
        }
        buildUI()
    }
    
    override func rightClick() {
        
        delog("取消订单")
        if type == 0 {
            buildAlter("提示", "是否取消订单", "确定")
        }else if type == 3 {
            buildAlter("提示", "是否申请退货", "确定")
        }else if type == 4 {
            buildAlter("提示", "是否删除该订单", "确定")
        }
    }
    
    override func alertController() {
        
        if type == 0 {
            let up = ["mobileCode":Defaults["mobileCode"].stringValue,
                      "SESSIONID":Defaults["SESSIONID"].stringValue,
                      "id":dataSource[0].id]
                as [String: Any]
            
            delog(up)
            SVPWillShow("载入中...")
            
            Net.share.getRequest(urlString: cancleOrder_27_joggle, params: up, success: { (datas) in
                let json = JSON(datas)
                delog(json)
                SVPHide()
                if json["code"].int == 1 {
                    self.navigationController?.popViewController(animated: true)
                }
            }) { (error) in
                delog(error)
            }
        }else if type == 3 {
            delog("前往退货")
            let returnGoods = NewReturnGoodViewController()
            returnGoods.id = id
            navigationController?.pushViewController(returnGoods, animated: true)
        }else {
            delog("前往退货")
            deleteGoods()
        }
    }
    private func deleteGoods() {
        
        let up = ["mobileCode":Defaults["mobileCode"].stringValue,
                  "SESSIONID":Defaults["SESSIONID"].stringValue,
                  "id":dataSource[0].orderNo]
            as [String: Any]
        
        SVPWillShow("加载中...")
        delog(up)
        
        Net.share.getRequest(urlString: delOrderReturns_63_joggle, params: up, success: { (datas) in
            
            let json = JSON(datas)
            SVPHide()
            delog(json)
            
            if json["code"].int == 1 {
                
                SVPwillShowAndHide("订单删除成功")
                self.navigationController?.popViewController(animated: true)
            }
        }) { (error) in
            delog(error)
        }
    }
    
    private func buildUI() {
        
        tableView.tableFooterView = UIView.init()
        tableView.separatorStyle = .none
        
        tableView.register(UINib.init(nibName: "NewMeOrderListTabCell", bundle: nil), forCellReuseIdentifier: "NewMeOrderListTabCell")
        tableView.register(UINib.init(nibName: "NewOrderDetailDoctorTableViewCell", bundle: nil), forCellReuseIdentifier: "NewOrderDetailDoctorTableViewCell")
        tableView.register(UINib.init(nibName: "NewOrderDetailOtherTabCell", bundle: nil), forCellReuseIdentifier: "NewOrderDetailOtherTabCell")
        controller.layer.cornerRadius = 5.0
    }
    
    //
    private func build55Data() {
        
        createNaviController(title: "订单详情", leftBtn: buildLeftBtn(), rightBtn: buildRightBtnWithName("取消订单"))
        controller.setTitle("立即支付", for: .normal)
        
        let up = ["mobileCode":Defaults["mobileCode"].stringValue,
                  "SESSIONID":Defaults["SESSIONID"].stringValue,
                  "id":id]
            as [String: Any]
        
        SVPWillShow("加载中...")
        delog(up)
        
        Net.share.getRequest(urlString: stayGoodOrder_55_joggle, params: up, success: { (datas) in
            
            let json = JSON(datas)
            SVPHide()
            delog(json)
            
            if json["code"].int == 1 {
                
                self.dataSource.removeAll()
                let subJson = json["data"]["stayGoodOrder"]
                
                for (_, subJson2):(String, JSON) in subJson["orderGoodChilds"] {
                    
                    //防止串值
                    let model = NewGoodsDetailModel()
                    model.id = subJson["id"].string!
                    model.createDate = subJson["createDate"].string!
                    model.productTotal = subJson["productTotal"].float!
                    model.phone = subJson["phone"].string!
                    model.pickType = subJson["pickType"].string!
                    model.orderNo = subJson["orderNo"].string!

                    model.thumbnail = subJson2["thumbnail"].string!
                    model.goodId = subJson2["goodId"].string!
                    model.goodName = subJson2["goodName"].string!
                    model.goodChildName = subJson2["goodChildName"].string!
                    model.num = subJson2["num"].int!
                    model.goodPrice = subJson2["goodPrice"].float!
                    model.postage = subJson2["postage"].float!
                    self.dataSource.append(model)
                }
                if self.dataSource[0].pickType == "2" {
                    
                    self.location = NewStoreLocationModel()
                    self.location?.id = json["data"]["deliveryAddress"]["id"].string!
                    self.location?.realName = json["data"]["deliveryAddress"]["realName"].string!
                    self.location?.tel = json["data"]["deliveryAddress"]["tel"].string!
                    self.location?.area = json["data"]["deliveryAddress"]["area"].string!
                    self.location?.street = json["data"]["deliveryAddress"]["street"].string!
                }
                let model1 = NewOrderDetailOtherTabCellModel()
                model1.type = "订单总价"
                model1.detail = "￥ \(self.dataSource[0].productTotal)"
                self.detailSource.append(model1)
                let model2 = NewOrderDetailOtherTabCellModel()
                model2.type = "订单编号:"
                model2.detail = self.dataSource[0].orderNo
                self.detailSource.append(model2)
                let model3 = NewOrderDetailOtherTabCellModel()
                model3.type = "订单状态:"
                model3.detail = "待付款"
                self.detailSource.append(model3)
                let model4 = NewOrderDetailOtherTabCellModel()
                model4.type = "订单时间:"
                model4.detail = self.dataSource[0].createDate
                self.detailSource.append(model4)
                self.isLoad = true
                self.tableView.reloadData()
            }
        }) { (error) in
            delog(error)
        }
    }
    
    //45.项目订单详情信息接口:
    private func build57Data() {
        
        if self.type == 1 {
            createNaviController(title: "订单详情", leftBtn: buildLeftBtn(), rightBtn: nil)
            controller.setTitle("等待发货", for: .normal)
            controller.backgroundColor = lightText
            controller.isUserInteractionEnabled = false
        }else if self.type == 2 {
            createNaviController(title: "订单详情", leftBtn: buildLeftBtn(), rightBtn: nil)
            controller.setTitle("确认收货", for: .normal)
        }else {
            createNaviController(title: "订单详情", leftBtn: buildLeftBtn(), rightBtn: buildRightBtnWithName("申请退货"))
            controller.setTitle("撰写评论", for: .normal)
        }
        let up = ["mobileCode":Defaults["mobileCode"].stringValue,
                  "SESSIONID":Defaults["SESSIONID"].stringValue,
                  "id":id]
            as [String: Any]

        SVPWillShow("加载中...")
        delog(up)

        Net.share.getRequest(urlString: goodOrder_57_joggle, params: up, success: { (datas) in
            let json = JSON(datas)
            SVPHide()
            delog(json)
            if json["code"].int == 1 {

                self.dataSource.removeAll()
                let subJson = json["data"]["goodOrder"]
                
                for (_, subJson2):(String, JSON) in subJson["orderGoodChilds"] {
                    
                    //防止串值
                    let model = NewGoodsDetailModel()
                    model.id = subJson["id"].string!
                    model.orderNo = subJson["orderNo"].string!
                    model.productTotal = subJson["productTotal"].float!
                    model.payChannel = subJson["payChannel"].string!
                    model.payDate = subJson["payDate"].string!
                    model.phone = subJson["phone"].string!
                    model.createDate = subJson["createDate"].string!
                    model.pickType = subJson["pickType"].string!
                    model.isComment = subJson["isComment"].bool!
                    
                    model.thumbnail = subJson2["thumbnail"].string!
                    model.goodId = subJson2["goodId"].string!
                    model.goodID = subJson2["id"].string!
                    model.goodName = subJson2["goodName"].string!
                    model.goodChildName = subJson2["goodChildName"].string!
                    model.num = subJson2["num"].int!
                    model.goodPrice = subJson2["goodPrice"].float!
                    model.paidPrice = subJson2["paidPrice"].float!
                    model.postage = subJson2["postage"].float!
                    self.dataSource.append(model)
                }
                
                if self.dataSource[0].pickType == "2" {
                    
                    self.location = NewStoreLocationModel()
                    self.location?.id = json["data"]["goodOrder"]["id"].string!
                    self.location?.realName = json["data"]["goodOrder"]["realName"].string!
                    self.location?.area = json["data"]["goodOrder"]["address"].string!
                }
                let model1 = NewOrderDetailOtherTabCellModel()
                model1.type = "订单总额:"
                model1.detail = "￥ \(self.dataSource[0].productTotal)"
                self.detailSource.append(model1)
                let model2 = NewOrderDetailOtherTabCellModel()
                model2.type = "订单编号:"
                model2.detail = self.dataSource[0].orderNo
                self.detailSource.append(model2)
                let model3 = NewOrderDetailOtherTabCellModel()
                model3.type = "订单状态:"
                if self.type == 1 {
                    model3.detail = "待发货"
                }else if self.type == 2 {
                    model3.detail = "待收货"
                }else {
                    model3.detail = "已完成"
                }
                self.detailSource.append(model3)
                let model4 = NewOrderDetailOtherTabCellModel()
                model4.type = "订单下单时间:"
                model4.detail = self.dataSource[0].createDate
                self.detailSource.append(model4)

                let model5 = NewOrderDetailOtherTabCellModel()
                model5.type = "订单支付时间:"
                model5.detail = self.dataSource[0].payDate
                self.detailSource.append(model5)

                let model6 = NewOrderDetailOtherTabCellModel()
                model6.type = "支付方式:"
                model6.detail = self.dataSource[0].payChannel
                self.detailSource.append(model6)
                
                self.isLoad = true
                self.tableView.reloadData()
            }
        }) { (error) in
            delog(error)
        }
    }
    
    //52.项目退款订单详情:
    private func build62Data() {
        
        controller.removeFromSuperview()

        let up = ["mobileCode":Defaults["mobileCode"].stringValue,
                  "SESSIONID":Defaults["SESSIONID"].stringValue,
                  "id":id]
            as [String: Any]

        SVPWillShow("加载中...")
        delog(up)

        Net.share.getRequest(urlString: orderReturns_62_joggle, params: up, success: { (datas) in
            let json = JSON(datas)
            SVPHide()
            delog(json)
            if json["code"].int == 1 {
                
                self.dataSource.removeAll()
                let subJson = json["data"]["orderReturns"]
                
                for (_, subJson2):(String, JSON) in subJson["orderMain"]["orderGoodChilds"] {
                    
                    //防止串值
                    let model = NewGoodsDetailModel()
                    model.id = subJson["id"].string!
                    model.returnsNo = subJson["returnsNo"].string!
                    model.createDate = subJson["createDate"].string!
                    model.handingSchedule = subJson["handingSchedule"].string!
                    model.returnsStatus = subJson["returnsStatus"].string!
                    model.productTotal = subJson["orderMain"]["productTotal"].float!

                    if subJson["handingSchedule"].string! == "0" {
                        //待审批
                    }else if subJson["handingSchedule"].string! == "1" {
                        
                        //待确认
                        model.address = subJson["address"].string!
                    }else if subJson["handingSchedule"].string! == "2" {
                        
                        //已确认
                        if subJson["returnsStatus"].string! == "1" {
                            //退款成功
                            model.address = subJson["address"].string!
                            model.returnsAmount = subJson["returnsAmount"].float!
                        }else {
                            //退款失败
                            model.address = subJson["address"].string!
                            model.remarks = subJson["remarks"].string!
                        }
                    }

                    model.thumbnail = subJson2["thumbnail"].string!
                    model.goodName = subJson2["goodName"].string!
                    model.goodChildName = subJson2["goodChildName"].string!
                    model.num = subJson2["num"].int!
                    model.goodPrice = subJson2["goodPrice"].float!
                    self.dataSource.append(model)
                }
                
                if self.dataSource[0].handingSchedule == "0" {
                    
                    self.createNaviController(title: "订单详情", leftBtn: self.buildLeftBtn(), rightBtn: nil)
                    //待审核
                    let model1 = NewOrderDetailOtherTabCellModel()
                    model1.type = "退货单号:"
                    model1.detail = self.dataSource[0].returnsNo
                    self.detailSource.append(model1)
                    let model2 = NewOrderDetailOtherTabCellModel()
                    model2.type = "退货状态:"
                    model2.detail = "待审批"
                    self.detailSource.append(model2)
                    let model3 = NewOrderDetailOtherTabCellModel()
                    model3.type = "申请时间:"
                    model3.detail = self.dataSource[0].createDate
                    self.detailSource.append(model3)
                }else if self.dataSource[0].handingSchedule == "1" {
                    
                    self.createNaviController(title: "订单详情", leftBtn: self.buildLeftBtn(), rightBtn: nil)
                    //待确认
                    let model0 = NewOrderDetailOtherTabCellModel()
                    model0.type = "  "
                    model0.detail = self.dataSource[0].address
                    self.detailSource.append(model0)
                    let model1 = NewOrderDetailOtherTabCellModel()
                    model1.type = "退货单号:"
                    model1.detail = self.dataSource[0].returnsNo
                    self.detailSource.append(model1)
                    let model2 = NewOrderDetailOtherTabCellModel()
                    model2.type = "退货状态:"
                    model2.detail = "待审批"
                    self.detailSource.append(model2)
                    let model3 = NewOrderDetailOtherTabCellModel()
                    model3.type = "申请时间:"
                    model3.detail = self.dataSource[0].createDate
                    self.detailSource.append(model3)
                }else if self.dataSource[0].handingSchedule == "2" {
                    
                    if self.dataSource[0].handingSchedule == "1"  {

                        self.createNaviController(title: "订单详情", leftBtn: self.buildLeftBtn(), rightBtn: self.buildRightBtnWithName("删除"))
                        //退款成功
                        let model0 = NewOrderDetailOtherTabCellModel()
                        model0.type = "  "
                        model0.detail = self.dataSource[0].address
                        self.detailSource.append(model0)
                        let model1 = NewOrderDetailOtherTabCellModel()
                        model1.type = "退货单号:"
                        model1.detail = self.dataSource[0].returnsNo
                        self.detailSource.append(model1)
                        let model2 = NewOrderDetailOtherTabCellModel()
                        model2.type = "退货状态:"
                        model2.detail = "退货成功"
                        self.detailSource.append(model2)
                        let model3 = NewOrderDetailOtherTabCellModel()
                        model3.type = "申请时间:"
                        model3.detail = self.dataSource[0].createDate
                        self.detailSource.append(model3)
                        let model4 = NewOrderDetailOtherTabCellModel()
                        model4.type = "退还金额:"
                        model4.detail = "￥ \(self.dataSource[0].returnsAmount)"
                        self.detailSource.append(model4)
                    }else {
                        //退款失败
                        self.createNaviController(title: "订单详情", leftBtn: self.buildLeftBtn(), rightBtn: self.buildRightBtnWithName("删除"))
                        let model0 = NewOrderDetailOtherTabCellModel()
                        model0.type = "  "
                        model0.detail = self.dataSource[0].address
                        self.detailSource.append(model0)
                        let model1 = NewOrderDetailOtherTabCellModel()
                        model1.type = "退货单号:"
                        model1.detail = self.dataSource[0].returnsNo
                        self.detailSource.append(model1)
                        let model2 = NewOrderDetailOtherTabCellModel()
                        model2.type = "退货状态:"
                        model2.detail = "退货失败"
                        self.detailSource.append(model2)
                        let model3 = NewOrderDetailOtherTabCellModel()
                        model3.type = "申请时间:"
                        model3.detail = self.dataSource[0].createDate
                        self.detailSource.append(model3)
                        let model4 = NewOrderDetailOtherTabCellModel()
                        model4.type = "失败原因:"
                        model4.detail = self.dataSource[0].remarks
                        self.detailSource.append(model4)
                    }
                }
                
                self.isLoad = true
                self.tableView.reloadData()
            }
        }) { (error) in
            delog(error)
        }
    }
    
    @IBAction func click(_ sender: UIButton) {
        
        if sender.titleLabel?.text! == "立即支付" {
            
            let pay = NewStorePayDetailViewController.init(nibName: "NewStorePayDetailViewController", bundle: nil)
            pay.orderId = id
            self.navigationController?.pushViewController(pay, animated: true)
        }else if sender.titleLabel?.text! == "确认收货" {
            
            let up = ["mobileCode":Defaults["mobileCode"].stringValue,
                      "SESSIONID":Defaults["SESSIONID"].stringValue,
                      "id":id]
                as [String: Any]
            
            SVPWillShow("加载中...")
            delog(up)
    
            Net.share.getRequest(urlString: confirmGoodOrder_58_joggle, params: up, success: { (datas) in
                let json = JSON(datas)
                SVPHide()
                delog(json)
                if json["code"].int == 1 {
                    SVPwillSuccessShowAndHide("确认收货成功")
                    self.type = 3
                    self.detailSource.removeAll()
                    self.build57Data()
                }
            }) { (error) in
                delog(error)
            }
        }else if sender.titleLabel?.text! == "撰写评论" {
            if dataSource[0].isComment {
                SVPwillShowAndHide("该订单您已经发表过评论")
                return
            }
            let evaluate = NewAddEvaluateViewController.init(nibName: "NewAddEvaluateViewController", bundle: nil)
            evaluate.dataSource = dataSource
            self.navigationController?.pushViewController(evaluate, animated: true)
        }
    }
}

// MARK: - UITableViewDelegate
extension NewGoodsOrderDetailViewController: UITableViewDelegate {
    
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
            cell?.goodsDetailModel = dataSource[indexPath.row]
            return cell!
        }else if indexPath.section == 1 {
            
            if type == 4 {
                
                //如果是退货状态
                let cell:NewOrderDetailOtherTabCell? = tableView.dequeueReusableCell(withIdentifier: "NewOrderDetailOtherTabCell") as? NewOrderDetailOtherTabCell
                cell?.selectionStyle = .none
                cell?.model = detailSource[indexPath.row]
                return cell!
            }else {
                if  location != nil {
                    let cell:NewOrderDetailOtherTabCell? = tableView.dequeueReusableCell(withIdentifier: "NewOrderDetailOtherTabCell") as? NewOrderDetailOtherTabCell
                    cell?.selectionStyle = .none
                    let model = NewOrderDetailOtherTabCellModel()
                    if indexPath.row == 0 {
                        model.type = "收货人姓名:"
                        model.detail = location!.realName
                    }else if indexPath.row == 1 {
                        model.type = "收货手机号码:"
                        model.detail = self.dataSource[0].phone
                    }else {
                        model.type = "收货地址:"
                        model.detail = location!.area + location!.street
                    }
                    cell?.model = model
                    return cell!
                }else {
                    
                    let cell:NewOrderDetailOtherTabCell? = tableView.dequeueReusableCell(withIdentifier: "NewOrderDetailOtherTabCell") as? NewOrderDetailOtherTabCell
                    cell?.selectionStyle = .none
                    let model = NewOrderDetailOtherTabCellModel()
                    model.type = "收货方式:"
                    model.detail = "上门自取"
                    cell?.model = model
                    return cell!
                }
            }
        }else {
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
        if section <= 1 {
            return 10
        }else {
            return 0
        }
    }
}

// MARK: - UITableViewDataSource
extension NewGoodsOrderDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if !isLoad {
            return 0
        }
        if type == 4 {
            return 2
        }
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return dataSource.count
        }else if section == 1{
            if type == 4 {
                return detailSource.count
            }else {
                if location != nil {
                    return 3
                }else {
                    return 1
                }
            }
        }else {
            return detailSource.count
        }
    }
}
