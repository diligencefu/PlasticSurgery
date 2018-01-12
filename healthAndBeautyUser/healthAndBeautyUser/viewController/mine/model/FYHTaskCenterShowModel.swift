//
//  FYHTaskCenterShowModel.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/22.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON

class FYHTaskCenterShowModel: NSObject {

    ///编号
    var id : String!
    /// 任务名称
    var name : String!
    ///图标
    var icon : String!
//    ///广告链接地址
//    var cycleType : String!
    ///总数量
    var rewardNum : String!
    ///奖励积分
    var credit : String!
    /// 完成数量
    var count : String!

    class func setValueForFYHTaskCenterShowModel(json: JSON) -> FYHTaskCenterShowModel{
        
        let model = FYHTaskCenterShowModel()
        model.id = json["id"].stringValue
        model.name = json["name"].stringValue
        model.icon = json["icon"].stringValue
//        model.cycleType = json["cycleType"].stringValue
        model.rewardNum = json["rewardNum"].stringValue
        model.credit = json["credit"].stringValue
        model.count = json["count"].stringValue
        return model
    }

}

