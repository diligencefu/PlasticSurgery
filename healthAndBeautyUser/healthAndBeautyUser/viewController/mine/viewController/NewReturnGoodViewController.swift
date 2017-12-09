//
//  NewReturnGoodViewController.swift
//  healthAndBeautyUser
//
//  Created by 丿番茄 on 2017/11/23.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewReturnGoodViewController: Wx_baseViewController {
    
    var id = String()
    var isLoad = Bool()
    
    lazy var tableView : UITableView = {
        let table = UITableView()
        table.backgroundColor = backGroundColor
        table.delegate = self
        table.dataSource = self
        table.tableFooterView = UIView.init()
        table.separatorStyle = .none
        
        table.register(UINib.init(nibName: "NewReturnPicTableViewCell", bundle: nil), forCellReuseIdentifier: "NewReturnPicTableViewCell")
        table.register(UINib.init(nibName: "NewReturnListTableViewCell", bundle: nil), forCellReuseIdentifier: "NewReturnListTableViewCell")
        table.register(UINib.init(nibName: "NewMeOrderListTabCell", bundle: nil), forCellReuseIdentifier: "NewMeOrderListTabCell")
        table.register(UINib.init(nibName: "NewOrderDetailOtherTabCell", bundle: nil), forCellReuseIdentifier: "NewOrderDetailOtherTabCell")

        return table
    }()
    var dataSource = [NewGoodsDetailModel]()
    var detailSource = [NewOrderDetailOtherTabCellModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NewReturnListTableViewCell_tf = String()
        NewReturnListTableViewCell_tv = String()
        NewReturnPicTableViewCell_Image = [UIImage]()
        
        createNaviController(title: "申请退货", leftBtn: buildLeftBtn(), rightBtn: buildRightBtnWithName("提交"))
        buildUI()
        buildData()
    }
    
    override func rightClick() {
        
        view.endEditing(true)
        if NewReturnPicTableViewCell_Image.count == 0 {
            SVPwillShowAndHide("请至少上传一张图片")
            return
        }
        
        if NewReturnListTableViewCell_tf.count == 0 {
            SVPwillShowAndHide("请输入联系方式")
            return
        }
        
        if NewReturnListTableViewCell_tv.count == 0 || NewReturnListTableViewCell_tv == "退货原因..." {
            SVPwillShowAndHide("请输入退货原因")
            return
        }
        
        let up = ["mobileCode":Defaults["mobileCode"].stringValue,
                  "SESSIONID":Defaults["SESSIONID"].stringValue,
                  "id":id,
                  "applyReason":NewReturnListTableViewCell_tv,
                  "phone":NewReturnListTableViewCell_tf]
            as [String: String]
        
        var nameArr = [String]()
        
        for _ in NewReturnPicTableViewCell_Image {
            nameArr.append("pic")
        }
        
        delog(up)
        SVPWillShow("载入中...")
        
        Net.share.reReturnGoodsUpLoadImageRequest(urlString: CreateOrderReturns_60_joggle,
                                               params: up,
                                               data: NewReturnPicTableViewCell_Image,
                                               name: nameArr,
                                               success: { (datas) in
                                                let json = JSON(datas)
                                                delog(json)
                                                SVPHide()
                                                if json["code"].int == 1 {
                                                    SVPwillSuccessShowAndHide("退货申请提交成功")
                                                    self.navigationController?.popToRootViewController(animated: true)
                                                }else {
                                                    SVPwillShowAndHide(json["message"].string!)
                                                }
        }) { (error) in
            delog(error)
            SVPwillShowAndHide("网络连接失败!")
        }
    }
    
    private func buildUI() {
        
        view.addSubview(tableView)
        _ = tableView.sd_layout()?
            .topSpaceToView(naviView,0)?
            .leftSpaceToView(view,0)?
            .rightSpaceToView(view,0)?
            .bottomSpaceToView(view,0)
    }
    
    //45.项目订单详情信息接口:
    private func buildData() {
        
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
                
                let model2 = NewOrderDetailOtherTabCellModel()
                model2.type = "订单编号:"
                model2.detail = self.dataSource[0].orderNo
                self.detailSource.append(model2)
                let model1 = NewOrderDetailOtherTabCellModel()
                model1.type = "订单总额:"
                model1.detail = "￥ \(self.dataSource[0].productTotal)"
                self.detailSource.append(model1)
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
}

// MARK: - UITableViewDelegate
extension NewReturnGoodViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            return 44
        case 1:
            return 110
        case 2:
            return 155
        case 3:
            return 175
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell:NewOrderDetailOtherTabCell? = tableView.dequeueReusableCell(withIdentifier: "NewOrderDetailOtherTabCell") as? NewOrderDetailOtherTabCell
            cell?.selectionStyle = .none
            cell?.model = detailSource[indexPath.row]
            return cell!
        }else if indexPath.section == 1 {
            
            //一般cell
            let cell:NewMeOrderListTabCell? = tableView.dequeueReusableCell(withIdentifier: "NewMeOrderListTabCell") as? NewMeOrderListTabCell
            cell?.selectionStyle = .none
            cell?.goodsDetailModel = dataSource[indexPath.row]
            return cell!
        }else if indexPath.section == 2 {
            
            //一般cell
            let cell:NewReturnPicTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "NewReturnPicTableViewCell") as? NewReturnPicTableViewCell
            cell?.selectionStyle = .none
            return cell!
        }else if indexPath.section == 3 {
            
            //一般cell
            let cell:NewReturnListTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "NewReturnListTableViewCell") as? NewReturnListTableViewCell
            cell?.selectionStyle = .none
            cell?.phone.text = dataSource[0].phone
            NewReturnListTableViewCell_tf = dataSource[0].phone
            return cell!
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let foot = UIView()
        foot.backgroundColor = lineColor
        return foot
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section < 2 {
            return 10
        }else {
            return 0
        }
    }
}

// MARK: - UITableViewDataSource
extension NewReturnGoodViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if !isLoad {
            return 0
        }
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 3
        }else if section == 2 || section == 3 {
            return 1
        }
        return dataSource.count
    }
}
