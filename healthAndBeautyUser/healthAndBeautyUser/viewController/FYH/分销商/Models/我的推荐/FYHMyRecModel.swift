//
//  FYHMyRecModel.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/9.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON

class FYHMyRecModel: NSObject {
    /// 用户编号
    var id : String!
    ///昵称
    var nickName : String!
    ///头像
    var photo : String!
    ///性别
    var gender : String!
    ///团队销售额
    var teamConsumption : String!
    ///总页数
    var totalPage : String!
    
    
    class func setValueForFYHMyRecModel(json: JSON) -> FYHMyRecModel {
        
        let model = FYHMyRecModel()
        model.id = json["id"].stringValue
        model.nickName = json["nickName"].stringValue
        model.photo = json["photo"].stringValue
        model.gender = json["gender"].stringValue
        model.teamConsumption = json["teamConsumption"].stringValue
        model.totalPage = json["totalPage"].stringValue
        return model
    }

}
