//
//  FYHConvertGoodsModel.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/20.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON

class FYHConvertGoodsModel: NSObject {
    ///商品编号
    var id : String!
    ///商品名称
    var name : String!
    ///标签
    var title : String!
    /// 缩略图
    var thumbnail : String!
    ///库存  -1代表无库存限制，不显示
    var stock : String!
    ///原价
    var originalPrice : String!
    ///所须积分
    var integral : String!

    
    class func setValueForFYHConvertGoodsModel(json: JSON) -> FYHConvertGoodsModel {
        let model = FYHConvertGoodsModel()
        model.id = json["id"].stringValue
        model.name = json["name"].stringValue
        model.title = json["title"].stringValue
        model.thumbnail = json["thumbnail"].stringValue
        model.stock = json["stock"].stringValue
        model.originalPrice = json["originalPrice"].stringValue
        model.integral = json["integral"].stringValue
        return model
    }

}
