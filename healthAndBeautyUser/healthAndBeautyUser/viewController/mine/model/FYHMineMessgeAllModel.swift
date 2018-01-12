//
//  FYHMineMessgeAllModel.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/26.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON

class FYHMineMessgeAllModel: NSObject {
    /// 是否已读 (进入列表后全部已读)
    var isRead : String!
    ///消息
    var infoNotify : FYHMIneMessageUserModel!
    ///昵称
    var nickName : String!
    ///头像
    var photo : String!
    ///
    var pId : String!
    ///只有评论时才有为评论内容
    var content : String!
    ///关联编号  点赞评论时为日记编号
    var aId : String!

    class func setValueForFYHMineMessgeAllModel(json: JSON) -> FYHMineMessgeAllModel {
        
        let model = FYHMineMessgeAllModel()
        model.isRead = json["isRead"].stringValue
        model.nickName = json["nickName"].stringValue
        model.photo = json["photo"].stringValue
        model.pId = json["pId"].stringValue
        model.content = json["content"].stringValue
        model.aId = json["aId"].stringValue
        model.infoNotify = FYHMIneMessageUserModel.setValueForFYHMIneMessageUserModel(json:json["infoNotify"])
        return model
    }

}

class FYHMIneMessageUserModel: NSObject {
    ///消息标题
    var createDate : String!
    ///消息发送时间
    var title : String!
    class func setValueForFYHMIneMessageUserModel(json: JSON) -> FYHMIneMessageUserModel {
        
        let model = FYHMIneMessageUserModel()
        model.createDate = json["createDate"].stringValue
        model.title = json["title"].stringValue
        return model
    }

}


