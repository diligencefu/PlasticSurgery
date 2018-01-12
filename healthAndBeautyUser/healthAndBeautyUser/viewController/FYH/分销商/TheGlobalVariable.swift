//
//  TheGlobalVariable.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/10.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import SwiftyUserDefaults


let SuccessRefreshNotificationCenter_Login = "SuccessRefreshNotificationCenter_Login"
let SuccessRefreshNotificationCenter_LoginOut = "SuccessRefreshNotificationCenter_LoginOut"



let kSCREEN_WIDTH = UIScreen.main.bounds.size.width
let kSCREEN_HEIGHT = UIScreen.main.bounds.size.height
let kSCREEN_SIZE = UIScreen.main.bounds.size
let kSCREEN_SCALE = kSCREEN_WIDTH/720



let kFont20 = UIFont.systemFont(ofSize: kSCREEN_SCALE * 20)
let kFont22 = UIFont.systemFont(ofSize: kSCREEN_SCALE * 22)
let kFont24 = UIFont.systemFont(ofSize: kSCREEN_SCALE * 24)
let kFont26 = UIFont.systemFont(ofSize: kSCREEN_SCALE * 26)
let kFont28 = UIFont.systemFont(ofSize: kSCREEN_SCALE * 28)
let kFont30 = UIFont.systemFont(ofSize: kSCREEN_SCALE * 30)
let kFont32 = UIFont.systemFont(ofSize: kSCREEN_SCALE * 32)
let kFont34 = UIFont.systemFont(ofSize: kSCREEN_SCALE * 34)
let kFont36 = UIFont.systemFont(ofSize: kSCREEN_SCALE * 36)
let kFont38 = UIFont.systemFont(ofSize: kSCREEN_SCALE * 38)
let kFont40 = UIFont.systemFont(ofSize: kSCREEN_SCALE * 40)
let kFont42 = UIFont.systemFont(ofSize: kSCREEN_SCALE * 42)
let kFont44 = UIFont.systemFont(ofSize: kSCREEN_SCALE * 44)
let kFont46 = UIFont.systemFont(ofSize: kSCREEN_SCALE * 46)


func kSetRGBColor (r:CGFloat, g:CGFloat, b:CGFloat) -> UIColor {
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
    
}

func kSetRGBAColor (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    
}

func kMainColor() -> UIColor {
    return kSetRGBColor(r: 255, g: 93, b: 94)
}


func kTextColor() -> UIColor {
    return kSetRGBColor(r: 69, g: 69, b: 69)
}

func kBGColor() -> UIColor {
    return kSetRGBColor(r: 239, g: 239, b: 244)
}

func kGaryColor(num : NSInteger) -> UIColor {
    return kSetRGBColor(r: CGFloat(num), g: CGFloat(num), b: CGFloat(num))
}

//MARK: 获得渐变背景颜色
func getNavigationIMG(_ height: NSInteger,fromColor:UIColor,toColor:UIColor) -> UIImage {
    
    let view = UIView(frame: CGRect(x:0, y:0, width:Int(kSCREEN_WIDTH), height:height))
    view.layer.insertSublayer(getNavigationView(height, fromColor: fromColor, toColor: toColor), at: 0)
    UIGraphicsBeginImageContext(view.bounds.size)
    view.layer.render(in: UIGraphicsGetCurrentContext()!)
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return image!
}

//MARK: 获得渐变背景颜色
func getNavigationView(_ height: NSInteger,fromColor:UIColor,toColor:UIColor) -> CAGradientLayer {
    let gradient = CAGradientLayer()
    gradient.frame = CGRect(x:0, y:0, width:Int(kSCREEN_WIDTH), height:height)
    gradient.colors = [fromColor.cgColor,toColor.cgColor]
    gradient.startPoint = CGPoint.init(x: 0, y: 0.5)
    gradient.endPoint = CGPoint.init(x: 1, y: 0.5)
    return gradient
    
}


//MARK: 设置一个提醒
func setToast(str:String) {
    
    let window = UIApplication.shared.keyWindow
    let width = getSizeOnString(str, 15).width
    let label = UILabel.init(frame: CGRect (x: 0, y: 0, width: width + 12, height: 30))
    label.backgroundColor = kMainColor()
    label.layer.cornerRadius = 6
    label.clipsToBounds = true
    label.center = CGPoint(x: kSCREEN_WIDTH/2, y: kSCREEN_HEIGHT/2)
    label.textColor = UIColor.white
    label.text = str
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 15)
    label.alpha = 0
    window?.addSubview(label)
    
    UIView.animate(withDuration: 0.15) {
        label.alpha = 1
    }
    
    let time: TimeInterval = 1.7
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
        
        UIView.animate(withDuration: 0.18, delay: 0, options: .layoutSubviews, animations: {
            label.alpha = 0
        }, completion: { (s) in
            label.removeFromSuperview()
            deBugPrint(item: "移除提醒")
        })
    }
}


//获取首页icon的名字
func kGetIconName(str:String) -> String {
    if str == "zxbk" {
        return "整形百科"
    }
    if str == "rjal" {
        return "日记案例"
    }
    if str == "mfzx" {
        return "免费整形"
    }
    if str == "ssxc" {
        return "手术现场"
    }
    if str == "jfsc" {
        return "积分商城"
    }
    if str == "rwzx" {
        return "任务中心"
    }
    if str == "zjtd" {
        return "专家团队"
    }
    if str == "jhtj" {
        return "精华推荐"
    }
    return "出错了吧这是"
}





//调试模式输出
func deBugPrint( item: @autoclosure () -> Any) {
    #if DEBUG
        print(item())
    #endif
}


class TheGlobalVariable: NSObject {

}
