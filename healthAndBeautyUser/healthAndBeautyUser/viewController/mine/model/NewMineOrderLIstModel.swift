//
//  NewMineOrderLIstModel.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/18.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewMineOrderLIstModel: Wx_baseModel {
    
    // 0 待付款  1 44号接口的待确认   3 4 44号接口的已支付和已完成  5 退款接口
    var type = Int()
    
    var id = String()
    var orderNo = String()
    var productName = String()
    var productChildName = String()
    var reservationPrice = Float()
    var prepaidPrice = Float()
    var residualPrice = Float()
    var num = Int()
    var discountReservation = Float()
    var discountRetainage = Float()
    var payStatus = String()
    var orderStatus = String()
    var thumbnail = String()
    //待付款款专用
    var productTotal = Float()

    //44.用户项目订单列表:（待确认  已支付   已完成）--》医生
    var doctors = [NewMineOrderLIstModelDoctor]()
    //  已支付   已完成
    var operationDate = String()
    var projectName = String()
    
    //退款专用
    var createDate = String()
    var refundStatus = String()
    var refundCost = Float()
    var productId = String()
}

class NewMineOrderLIstModelDoctor: Wx_baseModel {
    
    var bespoke = Int()
    var cases = Int()
    var currentPosition = String()
    var doctorName = String()
    var doctorPrensent = String()
    var doctorTime = String()
    var education = String()
    var headImage = String()
    var id = String()
    var remarks = String()
    var sex = String()
    var updateDate = String()
}
