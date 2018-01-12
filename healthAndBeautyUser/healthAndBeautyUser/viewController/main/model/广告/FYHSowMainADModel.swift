//
//  FYHSowMainADModel.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/21.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON

class FYHSowMainADModel: NSObject {
    ///用户余额
    var id : String!
    ///用户余额
    var infoBanner : ADModelDetailInfoBanner!
    ///用户余额
    var remarks : String!
    ///用户余额
    var bannerSpecific :ADModelDetailBannerSpecific!
    
    class func setValueForFYHSowMainADModel(json: JSON) -> FYHSowMainADModel {
        
        let model = FYHSowMainADModel()
        model.id = json["id"].stringValue
        model.infoBanner = ADModelDetailInfoBanner.setValueForADModelDetailInfoBanner(json: json["infoBanner"])
        model.remarks = json["remarks"].stringValue
        model.bannerSpecific = ADModelDetailBannerSpecific.setValueForADModelDetailBannerSpecific(json:json["bannerSpecific"])
        return model
    }
}



class ADModelDetailInfoBanner: NSObject {
    ///广告编号
    var id : String!
    /// 广告名称
    var name : String!
    ///广告图片路径
    var imgUrl : String!
    ///广告链接地址
    var linkUrl : String!
    ///广告类容
    var describes : String!
    ///是否为默认广告 1 是默认广告  2 不是默认广告
    var isDefault : String!
    ///广告的点击量（浏览次数）
    var hits : String!

    class func setValueForADModelDetailInfoBanner(json: JSON) -> ADModelDetailInfoBanner{
        
        let model = ADModelDetailInfoBanner()
        model.id = json["id"].stringValue
        model.name = json["name"].stringValue
        model.imgUrl = json["imgUrl"].stringValue
        model.linkUrl = json["linkUrl"].stringValue
        model.describes = json["describes"].stringValue
        model.isDefault = json["isDefault"].stringValue
        model.hits = json["hits"].stringValue
        return model
    }
}



class ADModelDetailBannerSpecific: NSObject {
    ///广告位置名称
    var locationName : String!
    ///广告位置标记 1 轮播图位置 2 主页列表位置 3 其他位置 4 导航位置
    var locationFlag : String!
    
    class func setValueForADModelDetailBannerSpecific(json: JSON) -> ADModelDetailBannerSpecific {
        
        let model = ADModelDetailBannerSpecific()
        model.locationName = json["locationName"].stringValue
        model.locationFlag = json["locationFlag"].stringValue
        return model
    }

}
