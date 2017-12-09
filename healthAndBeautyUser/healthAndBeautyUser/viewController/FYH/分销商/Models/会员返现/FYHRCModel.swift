//
//  FYHRCModel.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/9.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON

class FYHRCModel: NSObject {
    ///返现编号
    var id : String!
    ///返现启用时间
    var enableDate : String!
    ///返现总金额
    var cashback : String!
    ///返现剩余金额
    var surplus : String!
    ///每期返现金额
    var eachAmount : String!
    ///已返期数
    var periods : String!
    ///返现状态  1：进行中  2：已结束
    var cashbackStatus : String!
    /// 返现日类型  1.周 2.月
    var cashbackType : String!
    ///返现日数值
    var cashbackDay : String!
    ///总页码
    var totalPage : String!
    

    class func setValueForFYHRCModel(json: JSON) -> FYHRCModel {
        
        let model = FYHRCModel()
        model.id = json["id"].stringValue
        model.enableDate = json["enableDate"].stringValue
        model.cashback = json["cashback"].stringValue
        model.surplus = json["surplus"].stringValue
        model.eachAmount = json["eachAmount"].stringValue
        model.periods = json["periods"].stringValue
        model.cashbackStatus = json["cashbackStatus"].stringValue
        model.cashbackType = json["cashbackType"].stringValue
        model.cashbackDay = json["cashbackDay"].stringValue
        model.totalPage = json["totalPage"].stringValue
        return model
    }

}
