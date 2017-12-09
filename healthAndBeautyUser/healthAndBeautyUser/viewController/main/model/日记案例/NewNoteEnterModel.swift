//
//  NewNoteEnterModel.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/9/26.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewNoteEnterModel: NSObject {

    var tmp : NSInteger! = 0
    
    var dothumb = String()
    var enshrine = String()
    var article_id = String()
    var doctor_name = String()
    var thumbs = Int()
    var thumbnail = String()
    var product_child_name = String()
    var dis_price = Float()
    var hits = Int()
    var images = [String]()
    var product_name = String()
    var countDay = Int()
    var doctor_id = String()
    var product_describle = String()
    var diary_id = String()
    var semeiography = String()
    var reservation_count = Int()
    var gender = String()
    var sala_price = Float()
    var age = Int()
    var nick_name = String()
    var photo = String()
    var content = String()

    //区分是不是我点开的日记详情的判断 影响 是否显示出回复按钮
    var isMe = Bool()
}
