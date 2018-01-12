//
//  FYHIntegralModel.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/20.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON

class FYHIntegralModel: NSObject {
    ///用户余额
    var id : String!
    ///支付价格
    var createDate : String!
    ///奖项名称
    var name : String!
    ///图标
    var icon : String!
    ///类型 1.积分  2.实物  3.佣金  4.无
    var type : String!
    ///数值 只针对积分和佣金有用
    var integralCounts : String!

    
    class func setValueForFYHIntegralModel(json: JSON) -> FYHIntegralModel {
        
        let model = FYHIntegralModel()
        model.id = json["id"].stringValue
        model.createDate = json["createDate"].stringValue
        model.name = json["name"].stringValue
        model.icon = json["icon"].stringValue
        model.type = json["type"].stringValue
        model.integralCounts = json["integralCounts"].stringValue
        return model
    }

}
