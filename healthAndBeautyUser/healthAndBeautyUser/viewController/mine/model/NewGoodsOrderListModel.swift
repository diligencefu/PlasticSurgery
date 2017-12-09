//
//  NewGoodsOrderListModel.swift
//  healthAndBeautyUser
//
//  Created by 丿番茄 on 2017/11/9.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewGoodsOrderListModel: NSObject {

    var type = 0
    
    var id = String()
    var productTotal = Float()
    var pickType = String()
    
    var list = orderGoodChildsModel()
    
//    是否评价过 true评价过 false未评价(只针对已完成的订单)
    var isComment = Bool()
    var payChannel = String()
    var postage = Float()
    
    //退货字段
    var createDate = String()
    var handingSchedule = String()
    var returnsStatus = String()
}

class orderGoodChildsModel: NSObject {
    
    var goodName = String()
    var goodId = String()
    var goodChildName = String()
    var thumbnail = String()
    var num = Int()
    var goodPrice = Float()
}
