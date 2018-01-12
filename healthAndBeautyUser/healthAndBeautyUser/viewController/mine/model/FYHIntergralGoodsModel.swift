//
//  FYHIntergralGoodsModel.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/27.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON
class FYHIntergralGoodsModel: NSObject {
    
    /// 订单编号
    var id : String!
    ///订单号
    var orderNo : String!
    ///商品名称
    var name : String!
    ///商品信息
//    var commodity : String!
    ///商品缩略图
    var thumbnail : String!
    ///消耗积分
    var integral : String!
    ///是否包邮  1 是  0 否
    var isPostage : String!
    ///邮费
    var postage : String!
    ///下单时间
    var createDate : String!

    class func setValueForFYHIntergralGoodsModel(json: JSON) -> FYHIntergralGoodsModel{
        
        let model = FYHIntergralGoodsModel()
        model.id = json["id"].stringValue
        model.orderNo = json["orderNo"].stringValue
        model.name = json["name"].stringValue
//        model.commodity = json["commodity"].stringValue
        model.thumbnail = json["commodity"]["thumbnail"].stringValue
        model.integral = json["integral"].stringValue
        model.isPostage = json["isPostage"].stringValue
        model.postage = json["postage"].stringValue
        model.createDate = json["createDate"].stringValue
        return model
    }

}
