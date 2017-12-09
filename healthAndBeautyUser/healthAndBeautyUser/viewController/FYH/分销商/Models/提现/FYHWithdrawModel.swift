//
//  FYHWithdrawModel.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/9.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON

class FYHWithdrawModel: NSObject {
    ///  可提现金额
    var cashBalance : String!
    ///单笔提现最低金额
    var minAmount : String!
    ///单笔提现最高金额
    var maxAmount : String!
    ///单笔提现扣除手续费比例
    var withdrawDiscount : String!
    ///单笔提现最小手续费
    var minWithdraw : String!
    ///单笔提现最大手续费
    var maxWithdraw : String!
    ///每日提现次数上限
    var count : String!
    ///今日已申请提现次数
    var withdrawCount : String!

    class func setValueForFYHWithdrawModel(json: JSON) -> FYHWithdrawModel {

        let model = FYHWithdrawModel()
        model.cashBalance = json["cashBalance"].stringValue
        model.minAmount = json["minAmount"].stringValue
        model.maxAmount = json["maxAmount"].stringValue
        model.withdrawDiscount = json["withdrawDiscount"].stringValue
        model.minWithdraw = json["minWithdraw"].stringValue
        model.maxWithdraw = json["maxWithdraw"].stringValue
        model.count = json["count"].stringValue
        model.withdrawCount = json["withdrawCount"].stringValue
        return model
    }

}
