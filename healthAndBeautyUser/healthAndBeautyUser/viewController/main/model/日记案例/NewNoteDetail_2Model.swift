//
//  NewNoteDetail_2Model.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/10/20.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewNoteDetail_2Model: NSObject {

    var personal = NewNoteDetail_2Model_Personal()
    var product = NewNoteDetail_2Model_Product()
    var preopImages = [String]()
    var articles = [NewNoteDetail_2Model_Articles]()
    var docotrs = [NewNoteDetail_2Model_docotrs]()
}

class NewNoteDetail_2Model_Personal: NSObject {
    
    var id = String()
    var doneProject = String()
    var follow = Int()
    var age = Int()
    var userType = String()
    var area = String()
    var article = Int()
    var birthday = String()
    var nickName = String()
    var integral = Int()
    var fans = Int()
    var photo = String()
    var gender = String()
}
class NewNoteDetail_2Model_Product: NSObject {
    
    var id = String()
    var doctorNames = String()
    var createDate = String()
    var productName = String()
    var salaPrice = Float()
    var isDiscount = String()
    var disPrice = Float()
    var reservationCount = Int()
    var productDescrible = String()
    var updateDate = String()
    var thumbnail = String()
    var productChildName = String()
    var reservationPrice = Float()
}

class NewNoteDetail_2Model_Articles: NSObject {
    
    var id = String()
    var comments = String()
    var rewards = String()
    var auditState = String()
    var thumbs = String()
    var createDate = String()
    var imageList = [String]()
    var title = String()
    var updateDate = String()
    var diaryId = String()
    var images = String()
    var hits = String()
    var content = String()
}

class NewNoteDetail_2Model_docotrs: NSObject {
    
    var doctorName = String()
    var id = String()
    var sex = String()
    var bespoke = Int()
    var cases = Int()
}
