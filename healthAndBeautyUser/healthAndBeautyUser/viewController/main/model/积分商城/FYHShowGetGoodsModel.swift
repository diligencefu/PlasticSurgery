//
//  FYHShowGetGoodsModel.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/21.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON

class FYHShowGetGoodsModel: NSObject {
    /// 领取记录编号
    var id : String!
    ///奖项名称
    var prizeName : String!
    ///抽奖时间
    var createDate : String!
    /// 奖项图标
    var prizeIcon : String!
    ///类型 1.积分  2.实物  3.佣金
    var prizeType : String!
    ///数值 只针对积分和佣金有用
    var integralCounts : String!
    ///状态  0：待领取   1：待发放  2：已发放
    var status : String!
    
    
    class func setValueForFYHShowGetGoodsModel(json: JSON) -> FYHShowGetGoodsModel {
        let model = FYHShowGetGoodsModel()
        model.id = json["id"].stringValue
        model.prizeName = json["prizeName"].stringValue
        model.createDate = json["createDate"].stringValue
        model.prizeIcon = json["prizeIcon"].stringValue
        model.prizeType = json["prizeType"].stringValue
        model.integralCounts = json["integralCounts"].stringValue
        model.status = json["status"].stringValue
        return model
    }

}
