//
//  DistributorModel.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/6.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON

class DistributorModel: NSObject {
    ///头像
    var photo : String!
    ///昵称
    var nickName : String!
    /// 性别
    var sex : String!
    /// 会员等级名称
    var memberName : String!
    /// 余额
    var balance : String!
    /// 可提现余额
    var cashBalance : String!
    /// 未消耗的会费
    var surplus : String!
    /// 是否允许提现  0 否  1 是
    var isCash : String!
    /// 账单日类型 1.周 2.月
    var billType : String!
    /// 账单日值
    var billDay : String!
    /// 个人累计消费
    var personalConsumption : String!
    /// 团队累计消费
    var teamConsumption : String!

    class func setValueForDistributorModel(json: JSON) -> DistributorModel {
        
        let model = DistributorModel()
        model.photo = json["photo"].stringValue
        model.nickName = json["nickName"].stringValue
        model.sex = json["sex"].stringValue
        model.memberName = json["memberName"].stringValue
        model.balance = json["balance"].stringValue
        model.cashBalance = json["cashBalance"].stringValue
        model.isCash = json["isCash"].stringValue
        model.surplus = json["surplus"].stringValue
        model.billType = json["billType"].stringValue
        model.billDay = json["billDay"].stringValue
        model.personalConsumption = json["personalConsumption"].stringValue
        model.teamConsumption = json["billType"].stringValue
        return model
    }

}
