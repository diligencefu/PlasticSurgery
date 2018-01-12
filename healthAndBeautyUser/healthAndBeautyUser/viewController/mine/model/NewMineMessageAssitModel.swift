//
//  newMineMessageAssitModel.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/17.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewMineMessageAssitModel: NSObject {
    ///点赞时间
    var createDate : String!
    ///点赞类型 1 日记文章  2.手术  3.评论
    var thumbType : Int!
    ///点赞人信息
    var personal : FYHMineMessagePersonalModel!

    class func setValueForNewMineMessageAssitModel(json: JSON) -> NewMineMessageAssitModel {
        
        let model = NewMineMessageAssitModel()
        model.createDate = json["createDate"].stringValue
        model.thumbType = json["thumbType"].intValue
        model.personal = FYHMineMessagePersonalModel.setValueForFYHMineMessagePersonalModel(json: json["personal"])
        return model
    }
}

class FYHMineMessagePersonalModel: NSObject {
    ///id
    var id : String!
    ///昵称
    var nickName : String!
    ///关注
    var follow : String!
    ///头像
    var photo : String!
    ///日记
    var article : String!
    ///年龄
    var age : String!
    ///性别
    var gender : String!
    ///
    var integral : String!
    ///生日
    var birthday : String!
    ///地区
    var area : String!
    ///粉丝
    var fans : String!

    class func setValueForFYHMineMessagePersonalModel(json: JSON) -> FYHMineMessagePersonalModel {
        
        let model = FYHMineMessagePersonalModel()
        model.id = json["id"].stringValue
        model.nickName = json["nickName"].stringValue
        model.follow = json["follow"].stringValue
        model.photo = json["photo"].stringValue
        model.article = json["article"].stringValue
        model.gender = json["gender"].stringValue
        model.age = json["age"].stringValue
        model.integral = json["integral"].stringValue
        model.birthday = json["birthday"].stringValue
        model.area = json["area"].stringValue
        model.fans = json["fans"].stringValue
        return model
    }
    
}


