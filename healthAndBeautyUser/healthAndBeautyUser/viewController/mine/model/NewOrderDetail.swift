//
//  NewOrderDetail.swift
//  healthAndBeautyUser
//
//  Created by 丿番茄 on 2017/11/8.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewOrderDetail: NSObject {
    
    var id = String()
    var orderNo = String()
    var createDate = String()
    var productTotal = Float()
    var phone = String()
    var thumbnail = String()
    var productName = String()
    var productChildName = String()
    var reservationPrice = Float()
    var prepaidPrice = Float()
    var retainage = Float()
    var num = Int()
    var discountReservation = Float()
    var discountRetainage = Float()
    
    //45接口
    var payStatus = String()
    var orderStatus = String()
    var projectName = String()
    var operationDate = String()
    var placeOrderTime = String()
    var residualPrice = Float()

    var doctors = [NewOrderDetailDoctorModel]()
    
    //52接口
    var refundStatus = String()
    var productId = String()
    var refundCost = Float()
//    handleDate 处理时间  （只有退款状态成功或失败时才有该字段）
//    remarks 退款失败原因（只有退款状态失败时才有该字段）
    var handleDate = String()
    var remarks = String()
}

class NewOrderDetailDoctorModel: NSObject {
    
    var doctorsId = String()
    var doctorsName = String()
}
