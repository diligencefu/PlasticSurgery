//
//  NewStoreShopCarModel.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/9/2.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewStoreShopCarModel: NSObject {
    
    var isSelect = false
    
    var thumbnail = String()
    var doctorName = String()
    var id = String()
    var goodType = String()
    var payPrice = Float()
    var retainage = Float()
    var addTime = String()
    var goodChildName = String()
    var num = Int()
    var goodName = String()
    var isDiscount = String()
    var other = String()
    var otherPrice = Float()
    
    //预约金优惠券
    var book1 = String()
    //尾款优惠券
    var book2 = String()
    
    var currentGoodsCount = NSInteger()
}
