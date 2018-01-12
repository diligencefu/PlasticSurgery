//
//  FYHShowNotiModel.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/26.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON

class FYHShowNotiModel: NSObject {
    ///消息编号
    var id : String!
    ///通知类型 true 特殊活动通知 false 普通通知
    var special : String!
    ///普通通知类型  1.日记审核失败通知  2.项目确认开始通知  3.项目退款失败通知  4.商品退货失败通知  5.提现失败通知
    var type : String!
    ///通知内容
    var content : String!
    ///通知标题
    var title : String!
    ///通知图标
    var icon : String!
    ///时间
    var sendTime : String!
    ///是否已读 0未读 1已读
    var isRead : String!
    /// 特殊通知点击详情跳转地址
    var url : String!
    ///普通通知关联编号
    var argId : String!
    
    class func setValueForFYHShowNotiModel(json: JSON) -> FYHShowNotiModel {
        
        let model = FYHShowNotiModel()
        model.id = json["id"].stringValue
        model.special = json["special"].stringValue
        model.type = json["type"].stringValue
        model.content = json["content"].stringValue
        model.title = json["title"].stringValue
        model.icon = json["icon"].stringValue
        model.sendTime = json["sendTime"].stringValue
        model.isRead = json["isRead"].stringValue
        model.url = json["url"].stringValue
        model.argId = json["argId"].stringValue
        return model
    }

}
