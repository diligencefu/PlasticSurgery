//
//  AppDelegate.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/10.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON
import DeviceKit
import CoreData

class aliPayModel: NSObject {
    
    var trade_no = String()
    var out_trade_no = String()
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        } else {
            
        }
        
        if Defaults.hasKey("firstLunch") {
            
            //不是第一次启动
            delog("不是第一次启动")
        }else {
            
            //第一次启动
            Defaults["firstLunch"] = false
            
            //创建设备识别码
            creatMobileCode()
            delog("第一次启动")
        }
        
        //加载第三方库
        _ = wx_ThirdService.shared
        //viewController
        buildAD()
        
        return true
    }
    
    private func buildAD() {
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        let ad = NewLaunchADViewController()
        self.window?.rootViewController = ad
    }
    
    func creatMobileCode() {
        
        var mobileCode = String()
        for _ in 0...9 {
            mobileCode += "\(arc4random() % 9)"
        }
        Defaults["mobileCode"] = mobileCode
        delog(mobileCode)
    }
    
    // MARK: - 支付宝
    private func application(app: UIApplication,
                             openURL url: URL,
                             options: [String : AnyObject]) -> Bool {
        
        if url.host == "safepay"{
            AlipaySDK.defaultService().processOrder(withPaymentResult: url, standbyCallback: { (resultDic) in
                if resultDic?["resultStatus"]! as! String == "9000" || resultDic?["resultStatus"]! as! String == "8000" {
                    let result = (resultDic?[AnyHashable("result")]! as! String)
                    let json = JSON.init(parseJSON: result)
                    let model = aliPayModel()
                    model.out_trade_no = json["alipay_trade_app_pay_response"]["out_trade_no"].string!
                    model.trade_no = json["alipay_trade_app_pay_response"]["trade_no"].string!
                    self.postNotifiction(model)
                }else {
                    self.payFailed()
                }
            })
            AlipaySDK.defaultService().processAuth_V2Result(url, standbyCallback: { (resultDic) in
                if resultDic?["resultStatus"]! as! String == "9000" || resultDic?["resultStatus"]! as! String == "8000" {
                    let result = (resultDic?[AnyHashable("result")]! as! String)
                    let json = JSON.init(parseJSON: result)
                    let model = aliPayModel()
                    model.out_trade_no = json["alipay_trade_app_pay_response"]["out_trade_no"].string!
                    model.trade_no = json["alipay_trade_app_pay_response"]["trade_no"].string!
                    self.postNotifiction(model)
                }else {
                    self.payFailed()
                }
            })
        }
        SVPHide()
        return true
    }
    
    internal func application(_ application: UIApplication,
                              open url: URL,
                              sourceApplication: String?,
                              annotation: Any) -> Bool {
        
        if url.host == "safepay"{
            AlipaySDK.defaultService().processOrder(withPaymentResult: url, standbyCallback: { (resultDic) in
                if resultDic?["resultStatus"]! as! String == "9000" || resultDic?["resultStatus"]! as! String == "8000" {
                    let result = (resultDic?[AnyHashable("result")]! as! String)
                    let json = JSON.init(parseJSON: result)
                    let model = aliPayModel()
                    model.out_trade_no = json["alipay_trade_app_pay_response"]["out_trade_no"].string!
                    model.trade_no = json["alipay_trade_app_pay_response"]["trade_no"].string!
                    self.postNotifiction(model)
                }else {
                    self.payFailed()
                }
            })
            AlipaySDK.defaultService().processAuth_V2Result(url, standbyCallback: { (resultDic) in
                if (resultDic?["resultStatus"]! as! NSString).integerValue == 9000 || (resultDic?["resultStatus"]! as! NSString).integerValue == 8000 {
                    let result = (resultDic?[AnyHashable("result")]! as! String)
                    let json = JSON.init(parseJSON: result)
                    let model = aliPayModel()
                    model.out_trade_no = json["alipay_trade_app_pay_response"]["out_trade_no"].string!
                    model.trade_no = json["alipay_trade_app_pay_response"]["trade_no"].string!
                    self.postNotifiction(model)
                }else {
                    self.payFailed()
                }
            })
        }
        SVPHide()
        return true
    }
    
    func postNotifiction(_ model: aliPayModel) {
        
        let center = NotificationCenter.default
        center.post(name: NSNotification.Name(rawValue: "paySuccess"), object: model, userInfo: nil)
    }
    
    func payFailed() {
        
        let alert = UIAlertView.init(title: "提示",
                                     message: "支付出现错误",
                                     delegate: self,
                                     cancelButtonTitle: "确定")
        alert.tag = 1000
        alert.show()
    }
}
