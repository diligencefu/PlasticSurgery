//
//  NewStoreRequireOrderModel.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/9/4.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewStoreRequireOrderModel: NSObject {

//    phone 联系电话
//    id 商品编号
//    num 数量
//    productName 商品名称
//    productChildName 商品副名称
//    thumbnail 商品缩略图
//    productType 商品类型  1:项目产品  2:普通商品
//    productSource 产品来源(平台名称或医院名称)
//    doctorName 关联医生
//    payPrice   商品单价
//    isDiscount 该商品是否支持使用优惠券  0:否 1:是
    
    var doctorName = String()
    var id = String()
    var isDiscount = String()
    var num = Float()
    var payPrice = Float()
    var productChildName = String()
    var productName = String()
    var productSource = String()
    //    productType 商品类型  1:项目产品  2:普通商品
    var productType = String()
    var thumbnail = String()
}
