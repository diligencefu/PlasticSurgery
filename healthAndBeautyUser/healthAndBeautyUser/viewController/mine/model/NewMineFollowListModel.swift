

//
//  newMineFollowListModel.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/16.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewMineFollowListModel: Wx_baseModel {
    
    //默认为医生
    var isUser = true
    var isFollow = true

    var id = String()
    var followType = String()
    var concernedBy = String()
    
    var userId = String()
    var nickName = String()
    var photo = String()
    var gender = String()
    var age = String()
    var name = String()
    
    
    var cases = String()
    var bespoke = String()

    
    var doctorId = String()
    var doctorName = String()
    var headImage = String()
    var sex = String()
    var currentPosition = String()
    var doctorPrensent = String()
    var education = String()
}
