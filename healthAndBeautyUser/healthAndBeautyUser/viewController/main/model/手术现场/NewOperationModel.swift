//
//  NewOperationModel.swift
//  healthAndBeautyUser
//
//  Created by 丿番茄 on 2017/11/24.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewOperationModel: NSObject {
    
    var content = String()
    var hits = Int()
    var id = String()
    var rewards = Int()
    var video = String()
    var thumbs = Int()
    var comments = Int()
    var title = String()
    var createDate = String()
    
    //网络路径
    var path = String()
    
    //医生
    var bespoke = Int()
    var currentPosition = String()
    var cases = Int()
    var doctorName = String()
    var sex = String()
    var headImage = String()
    
    var image : UIImage? = nil
}
