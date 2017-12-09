

//
//  ConsumptionModel.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/13.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyJSON

class ConsumptionModel: NSObject {
    ///
    var collectionCount : String!
    ///
    var shareCount : String!
    ///
    var playCount : String!
    ///
    var replyCount : String!
    
    
    
    
    class func getTheModels(json: JSON) -> ConsumptionModel {
        
        let model = ConsumptionModel()
        model.collectionCount = json["collectionCount"].stringValue
        model.shareCount = json["shareCount"].stringValue
        model.playCount = json["playCount"].stringValue
        model.replyCount = json["replyCount"].stringValue

        return model
    }
    
    
    
}
