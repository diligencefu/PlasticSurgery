//
//  NewStoreGoodsModel.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/10/16.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewStoreGoodsModel: NSObject {

    var disPrice = Float()
    var goodItemChildName = String()
    var goodItemDescrible = String()
    var goodItemName = String()
    var id = String()
    var isDiscount = String()
    var isNew = String()
    var isReconment = String()
    var isSale = String()
    var isSell = String()
    var postage = Int()
    var reservationCount = Int()
    var reservationPrice = Float()
    var salaPrice = Float()
    var thumbnail = String()
}

class NewStoreGoodsClassifies: NSObject {
    
    var createDate = String()
    var goodClsName = String()
    var id = String()
    var sort = Int()
    var updateDate = String()
}
