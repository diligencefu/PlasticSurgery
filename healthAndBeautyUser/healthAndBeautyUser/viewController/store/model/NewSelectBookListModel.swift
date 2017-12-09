//
//  NewSelectBookListModel.swift
//  healthAndBeautyUser
//
//  Created by 丿番茄 on 2017/11/2.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewSelectBookListModel: NSObject {

    var counponId = String()
    var receiveNum = Int()
    var userNum = Int()
    
    var couponName = String()
    var counponStartDate = String()
    var counponAmount = Float()
    var couponEndDate = String()
    var counponKind = String()
    var counponUsingRange = String()
    var productIds = String()
    var projectNames = String()
    var counponExplain = String()
    var meetPrice = Float()
    
    //是否可以使用
    var canUse = Bool()
    //无法使用元婴
    var state = String()
}
