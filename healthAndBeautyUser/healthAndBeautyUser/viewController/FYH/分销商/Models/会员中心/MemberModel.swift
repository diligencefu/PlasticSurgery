//
//  MemberModel.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/6.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON

class MemberModel: NSObject {
    ///会员产品编号
    var id : String!
    ///会员产品名称
    var memberName : String!
    ///价钱
    var memberAmount : String!
    ///产品图片
    var memberImage : String!
    ///奖励积分
    var integral : String!
    ///项目折扣        例：0.9 (即享受9折优惠)
    var discount : String!
    /// 用户是否购买过该会员产品
    var buy : String!

    
    class func setValueForMemberModel(json: JSON) -> MemberModel {
        
        let model = MemberModel()
        model.id = json["id"].stringValue
        model.memberName = json["memberName"].stringValue
        model.memberAmount = json["memberAmount"].stringValue
        model.memberImage = json["memberImage"].stringValue
        model.integral = json["integral"].stringValue
        model.discount = json["discount"].stringValue
        model.buy = json["buy"].stringValue
        return model
    }

}
