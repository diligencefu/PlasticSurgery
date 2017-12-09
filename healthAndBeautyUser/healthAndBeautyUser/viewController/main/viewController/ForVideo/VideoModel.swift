//
//  VideoModel.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/11.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyJSON


class VideoModel: NSObject {

    ///
    var title : String!
    ///
    var video_description : String!
    ///
    var playUrl : String!
    ///
    var coverForFeed : String!
    ///
    var playInfo : Array<Any> = []
    
    var consumption : ConsumptionModel!
    
    class func getTheModels(json: JSON) -> VideoModel {
        
        let model = VideoModel()
        model.title = json["title"].stringValue
        model.video_description = json["description"].stringValue
        model.playUrl = json["playUrl"].stringValue
        model.coverForFeed = json["coverForFeed"].stringValue
        model.playInfo = json["playInfo"].arrayValue
        model.consumption = ConsumptionModel.getTheModels(json: json["consumption"])
        return model
    }
    
    
}
