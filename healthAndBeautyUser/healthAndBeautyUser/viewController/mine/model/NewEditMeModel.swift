//
//  NewEditMeModel.swift
//  healthAndBeautyUser
//
//  Created by 丿番茄 on 2017/11/6.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewEditMeModel: NSObject {
    
    var isDoProject = Int()

    //所有项目信息
    var projectClassify = [projectClassifys]()
    //已经做过的所有项目
    var projectClassified = [projectClassifys]()

    var id = String()
    var nickName = String()
    var photo = String()
    var gender = String()
    var age = Int()
    var birthday = String()
    var area = String()
    var integral = Int()
}

class projectClassifys: NSObject {
    var name = String()
    var id = String()
    var isSelect = Bool()
}
