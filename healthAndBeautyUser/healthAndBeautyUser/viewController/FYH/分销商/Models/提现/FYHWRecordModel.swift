//
//  FYHWRecordModel.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/11.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON

class FYHWRecordModel: NSObject {
    ///  提现编号
    var id : String!
    ///提现金额
    var amount : String!
    ///提现扣除的手续费
    var poundage : String!
    ///提现方式 1.支付宝 2.微信
    var withdrawalType : String!
    ///提现申请时间
    var createDate : String!
    ///提现状态  0：待处理 1：成功  2：失败
    var withdrawalStatus : String!
    ///充值类型 1.支付宝 2.微信
    var rechargeType : String!

    class func setValueForFYHWRecordModel(json: JSON) -> FYHWRecordModel {
        
        let model = FYHWRecordModel()
        model.id = json["id"].stringValue
        model.amount = json["amount"].stringValue
        model.poundage = json["poundage"].stringValue
        model.withdrawalType = json["withdrawalType"].stringValue
        model.createDate = json["createDate"].stringValue
        model.withdrawalStatus = json["withdrawalStatus"].stringValue
        model.rechargeType = json["rechargeType"].stringValue
        return model
    }

}
