//
//  FYHPayModel.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/6.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON

class FYHPayModel: NSObject {
    ///用户余额
    var balance : String!
    ///支付价格
    var price : String!
    ///会员产品图片
    var memberImage : String!
    ///会员产品名称
    var memberName : String!
    ///失效时间（分钟）
    var overTime : String!
    
    
    class func setValueForFYHPayModel(json: JSON) -> FYHPayModel {
        
        let model = FYHPayModel()
        model.balance = json["balance"].stringValue
        model.price = json["price"].stringValue
        model.memberImage = json["memberImage"].stringValue
        model.memberName = json["memberName"].stringValue
        model.overTime = json["overTime"].stringValue
        return model
    }
    

}
