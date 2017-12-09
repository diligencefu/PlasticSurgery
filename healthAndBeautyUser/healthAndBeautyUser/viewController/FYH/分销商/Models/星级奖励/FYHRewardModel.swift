//
//  FYHRewardModel.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/9.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON

class FYHRewardModel: NSObject {
    /// 用户编号
    var id : String!
    ///昵称
    var createDate : String!
    ///头像
    var starName : String!
    ///性别
    var starType : String!
    ///团队销售额
    var consumption : String!
    ///总页数
    var reward : String!
    ///团队销售额
    var integral : String!
    ///总页数
    var receive : String!

    
    class func setValueForFYHRewardModel(json: JSON) -> FYHRewardModel {
        
        let model = FYHRewardModel()
        model.id = json["id"].stringValue
        model.createDate = json["createDate"].stringValue
        model.starName = json["starName"].stringValue
        model.starType = json["starType"].stringValue
        model.consumption = json["consumption"].stringValue
        model.reward = json["reward"].stringValue
        model.integral = json["integral"].stringValue
        model.receive = json["receive"].stringValue
        return model
    }

}
