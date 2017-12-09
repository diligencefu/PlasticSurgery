//
//  FYHRCDetailModel.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/9.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON

class FYHRCDetailModel: NSObject {
    ///  返现编号
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
    ///
//    var vipDetaileds : Array<FYHRCDetailModel2>!

    
    class func setValueForFYHRCDetailModel(json: JSON) -> FYHRCDetailModel {
        
        let model = FYHRCDetailModel()
        model.id = json["id"].stringValue
        model.enableDate = json["enableDate"].stringValue
        model.cashback = json["cashback"].stringValue
        model.surplus = json["surplus"].stringValue
        model.eachAmount = json["eachAmount"].stringValue
        model.periods = json["periods"].stringValue
        model.cashbackStatus = json["cashbackStatus"].stringValue
        model.cashbackType = json["cashbackType"].stringValue
        model.cashbackDay = json["cashbackDay"].stringValue
//        model.vipDetaileds = FYHRCDetailModel2.setValueForFYHRCDetailModel2(data: json["vipDetaileds"])
        return model
    }
}


class FYHRCDetailModel2: NSObject {
    ///  返现编号
    var id : String!
    ///
    var cashbackId : String!
    ///返现金额
    var amount : String!
    ///返现状态  0：待返现  1：已返现
    var cashbackStatus : String!
    ///预计返现日期
    var cashbackDate : String!
    ///实际返现日期
    var actualDate : String!
    
    class func setValueForFYHRCDetailModel2(data: JSON) -> Array<FYHRCDetailModel2> {
        
        var dataArr = [FYHRCDetailModel2]()
        
        for index in 0..<data.arrayValue.count {
            
            let json = data[index]
            let model = FYHRCDetailModel2()
            model.id = json["id"].stringValue
            model.cashbackId = json["cashbackId"].stringValue
            model.amount = json["amount"].stringValue
            model.cashbackStatus = json["cashbackStatus"].stringValue
            model.cashbackDate = json["cashbackDate"].stringValue
            model.actualDate = json["actualDate"].stringValue
            dataArr.append(model)
        }
        return dataArr
    }

}

