//
//  wx_ThirdService.swift
//  hanFengSupermarket
//
//  Created by 吴玄 on 2017/4/12.
//  Copyright © 2017年 iOSMonkey. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
//import CoreLocation

final class wx_ThirdService: NSObject {
    
    static let shared = wx_ThirdService()
    
//    let manager = CLLocationManager()
    
    private override init() {
        
        super.init()
        setKeyBoard()
//        setCity()
    }
    
    private func setKeyBoard() {
        
        let manager = IQKeyboardManager.sharedManager()
        manager.enable = true
        manager.shouldResignOnTouchOutside = true
        manager.shouldToolbarUsesTextFieldTintColor = true
        manager.enableAutoToolbar = true
    }
    
//    private func setCity() {
//
//        if !Defaults.hasKey("location") {
//            delog("开始定位")
//            manager.delegate = self
//            manager.requestWhenInUseAuthorization()
//        }else {
//            delog("已经获得过定位地址    \(Defaults.value(forKey: "location")!)")
//        }
//    }
    
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//
//        if status == .authorizedWhenInUse {
//
//            manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
//            manager.distanceFilter = 1000
//            manager.startUpdatingLocation()
//        }else {
//            Defaults["location"] = "定位失败"
//        }
//    }
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//
//        let location = manager.location
//
//        let gecoder = CLGeocoder()
////        weak var weakSelf = self
//        gecoder.reverseGeocodeLocation(location!) { (placemarks, error) in
////            let placemark = placemarks?.first
////            Defaults["location"] = placemark?.locality!
////            delog(Defaults.value(forKey: "location")!)
////            weakSelf!.postLocation()
//        }
//        manager.stopUpdatingHeading()
//    }
//    //更新地址发送通知
//    func postLocation() {
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "location"), object: nil)
//    }
}

//extension String {
//
//    func  lineStyleAttributeString(rangeString: String, isStrike:Bool ,isUnderline:Bool ,color:UIColor) -> NSMutableAttributedString
//    {
//        let attributeString:NSMutableAttributedString = NSMutableAttributedString(string:self)
//        let str = NSString(string: self)
//        let theRange = str.range(of: rangeString)
//        if isStrike {
//            attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 1, range: theRange)
//            attributeString.addAttribute(NSBaselineOffsetAttributeName, value: 1, range: theRange)
//            attributeString.addAttribute(NSStrikethroughColorAttributeName, value: color , range: theRange)
//        }
//        if isUnderline {
//            attributeString.addAttribute(NSUnderlineStyleAttributeName, value: 1 , range: theRange)
//            attributeString.addAttribute(NSUnderlineColorAttributeName, value: color , range: theRange)
//        }
//        return attributeString
//    }
//}

