//
//  DetailModel.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/12.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyJSON

class DetailModel: NSObject {

    
    ///关键字
    var height : String!
    ///景区地址
    var name : String!
    ///
    var type : String!
    ///
    var url : String!
    ///
    var width : String!
    
    
    class func getTheModels(json: JSON) -> DetailModel {
        
        let model = DetailModel()
        model.name = json["name"].stringValue
        model.height = json["height"].stringValue
        model.type = json["type"].stringValue
        model.url = json["url"].stringValue
        model.width = json["width"].stringValue
        return model
    }
    
}
