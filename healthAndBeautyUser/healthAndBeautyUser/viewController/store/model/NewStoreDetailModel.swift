//
//  NewStoreDetailModel.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/18.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewStoreDetailModel: NSObject {

    // 项目和商品使用同一个model 注释掉的是商品详情
    var id = String()
    
    //  goodItemName  商品名称
    var productName = String()
    
    //  goodItemChildName  商品副名称
    var productChildName = String()
    
    //  goodItemDescrible  商品简介
    var productDescrible = String()
    
    var reservationPrice = Float()
    var salaPrice = Float()
    var disPrice = Float()
    
    //  reservationCount  销售量
    var reservationCount = Int()
    
    var images = [String]()

    var productType = String()
    var isEnshrine = Bool()
    
//    是否是免费项目
    var isFree = String()
    
    //是否包邮以及邮费
    var isFreeShipping = String()
    var postage = Float()
}
