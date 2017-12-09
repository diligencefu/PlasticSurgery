//
//  NewGoodsDetailModel.swift
//  healthAndBeautyUser
//
//  Created by 丿番茄 on 2017/11/11.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewGoodsDetailModel: NSObject {
    
    var type = 0

    var id = String()
    var orderNo = String()
    var createDate = String()
    var productTotal = Float()
    var pickType = String()
    var phone = String()
    var realName = String()
    var area = String()
    var street = String()
    var goodId = String()
    var goodID = String()
    var goodName = String()
    var goodChildName = String()
    var thumbnail = String()
    var num = Int()
    var goodPrice = Float()
    var postage = Float()
    
//57接口
    var payChannel = String()
    var payDate = String()
    var isComment = Bool()
    var paidPrice = Float()
    var orderSettlementDate = String()

//62接口
    var returnsNo = String()
    var handingSchedule = String()
    var returnsStatus = String()
    var returnsAmount = Float()
    var remarks = String()
    var address = String()
}
