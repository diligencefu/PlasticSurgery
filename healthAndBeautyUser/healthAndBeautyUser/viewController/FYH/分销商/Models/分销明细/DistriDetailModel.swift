//
//  DistriDetailModel.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/9.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON

class DistriDetailModel: NSObject {
    ///分销明细编号
    var id : String!
    /// 总页数
    var totalPage : String!
    ///消费项目名称
    var cunsumeName : String!
    ///是否增加佣金  1 是  0否
    var isAdd : String!
    ///消费金额
    var cost : String!
    ///分销佣金
    var commissionMoney : String!
    ///分销名称
    var consumeMold : String!
    ///消费者
    var consumer : FYHUserModel!
    ///消费者名称
    var name : String!
    ///时间
    var createDate : String!
    ///佣金减少原因 只有isAdd=0时才有该字段
    var remarks : String!

    class func setValueForDistriDetailModel(json: JSON) -> DistriDetailModel {
        
        let model = DistriDetailModel()
        model.id = json["id"].stringValue
        model.totalPage = json["totalPage"].stringValue
        model.cunsumeName = json["cunsumeName"].stringValue
        model.isAdd = json["isAdd"].stringValue
        model.cost = json["cost"].stringValue
        model.commissionMoney = json["commissionMoney"].stringValue
        model.consumeMold = json["consumeMold"].stringValue
        model.consumer = FYHUserModel.setValueForFYHUserModel(json: json["consumer"])
        model.createDate = json["createDate"].stringValue
        model.remarks = json["remarks"].stringValue
        return model
    }

}

class FYHUserModel: NSObject {
    ///分销明细编号
    var id : String!
    /// 总页数
    var name : String!
    
    class func setValueForFYHUserModel(json: JSON) -> FYHUserModel {
        let model = FYHUserModel()
        model.id = json["id"].stringValue
        model.name = json["name"].stringValue
        return model
    }
}

