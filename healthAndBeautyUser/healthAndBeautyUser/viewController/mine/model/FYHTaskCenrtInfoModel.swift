//
//  FYHTaskCenrtInfoModel.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/22.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON

class FYHTaskCenrtInfoModel: NSObject {
    ///编号
    var id : String!
    /// 昵称
    var nickName : String!
    ///头像
    var photo : String!
    ///性别
    var gender : String!
    ///
    var age : String!
    ///
    var codeUrl : String!
    ///
    var birthday : String!
    ///
    var area : String!
    ///
    var doneProject : String!
    ///积分
    var integral : String!
    ///关注
    var follow : String!
    ///
    var fans : String!
    ///
    var article : String!
    ///
    var userType : String!

    class func setValueForFYHTaskCenrtInfoModel(json: JSON) -> FYHTaskCenrtInfoModel{
        
        let model = FYHTaskCenrtInfoModel()
        model.id = json["id"].stringValue
        model.nickName = json["nickName"].stringValue
        model.photo = json["photo"].stringValue
        model.gender = json["gender"].stringValue
        model.age = json["age"].stringValue
        model.codeUrl = json["codeUrl"].stringValue
        model.birthday = json["birthday"].stringValue
        model.area = json["area"].stringValue
        model.doneProject = json["doneProject"].stringValue
        model.integral = json["integral"].stringValue
        model.follow = json["follow"].stringValue
        model.fans = json["fans"].stringValue
        model.article = json["article"].stringValue
        model.userType = json["userType"].stringValue
        return model
    }

}
