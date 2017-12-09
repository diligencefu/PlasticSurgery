//
//  wx_GlobalFunctionSwiftFile.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/11.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

/*
 * 获得限制宽度的尺寸
 */
func getSizeOnLabel(_ labelStr: UILabel, _ width:CGFloat) -> CGSize {
    
    let content = labelStr.text! as NSString
    let attributes = [NSFontAttributeName: labelStr.font] as [String: Any]
    
    var size = CGRect()
    size = content.boundingRect(with: CGSize(width: width ,
                                             height: CGFloat(MAXFLOAT)),
                                options: .usesLineFragmentOrigin,
                                attributes: attributes,
                                context: nil)
    return size.size
}

/*
 * 获得不限制宽度的尺寸
 */
func getSizeOnLabel(_ labelStr: UILabel) -> CGSize {
    
    let content = labelStr.text! as NSString
    let attributes = [NSFontAttributeName: labelStr.font] as [String: Any]
    // 返回结果的rect
    var size = CGRect()
    //得到结果
    size = content.boundingRect(with: CGSize(width: WIDTH,
                                             height: CGFloat(MAXFLOAT)),
                                options: .usesLineFragmentOrigin,
                                attributes: attributes,
                                context: nil )
    return size.size
}

func getSizeOnString(_ str: String, _ size:Int) -> CGSize {
    
    let content = str as NSString
    let attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: CGFloat(size))] as [String: Any]
    
    var size = CGRect()
    size = content.boundingRect(with: CGSize(width: WIDTH ,
                                             height: CGFloat(MAXFLOAT)),
                                options: .usesLineFragmentOrigin,
                                attributes: attributes,
                                context: nil)
    return size.size
}

/*
 * 圆角及边框
 */
func viewRadius(_ view:UIView, _ radio:Float, _ width:Float, _ color:UIColor) {
    view.layer.cornerRadius = CGFloat(radio)
    view.layer.masksToBounds = true
    view.layer.borderWidth = CGFloat(width)
    view.layer.borderColor = color.cgColor
}

/*
 * 传入颜色 例如0xF1931A
 */
func getColorWithNotAlphe(_ seting : CLongLong) -> UIColor {
    
    let red = CGFloat(((seting & 0xFF0000) >> 16)) / 255.0;
    let green = CGFloat(((seting & 0x00FF00) >> 8)) / 255.0;
    let blue = CGFloat(seting & 0x0000FF) / 255.0;
    
    return UIColor.init(red: red, green: green, blue: blue, alpha: 1.0)
}

/*
 * 字符串转Float
 */
func StringToFloat(_ str:String) ->(Float){
    
    let string = str
    var float: Float = 0
    
    if let doubleValue = Float(string)
    {
        float = Float(doubleValue)
    }
    return float
}

/*
 * 字符串转Double
 */
func StringToDouble(_ str:String) ->(Double) {
    
    let string = str
    var double: Double = 0
    
    if let doubleValue = Double(string)
    {
        double = Double(doubleValue)
    }
    return double
}

/*
 * 字符串转UTF_8
 */
func StringToUTF_8InUrl(str:String) -> (URL){
    
    let OCString = str as NSString
    
    let urlString = OCString.addingPercentEscapes(using: String.Encoding.utf8.rawValue)
    
    return URL(string: urlString!)!
}

//MARK: 确认是否是手机号码
public func isTelNumber(num:String)->Bool{
    
    let mobile = "^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$"
    let  CM = "^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$"
    let  CU = "^1(3[0-2]|5[256]|8[56])\\d{8}$"
    let  CT = "^1((33|53|8[09])[0-9]|349)\\d{7}$"
    let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
    let regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
    let regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
    let regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
    if ((regextestmobile.evaluate(with: num) == true)
        || (regextestcm.evaluate(with: num)  == true)
        || (regextestct.evaluate(with: num) == true)
        || (regextestcu.evaluate(with: num) == true)) {
        
        return true
    }else {
        
        return false
    }
}

//MARK: 确认密码格式
public func isTruePassWord(num:String) -> Bool {
    
    let passWord = "^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$"
    let regextestpassWord = NSPredicate(format: "SELF MATCHES %@",passWord)
    if regextestpassWord.evaluate(with: num) == true {
        
        return true
    }else{
        
        return false
    }
}

public func creatAlert(_ title: String) {
    
    let alert = UIAlertView.init(title: "抱歉",
                                 message: title,
                                 delegate: nil,
                                 cancelButtonTitle: "确定")
    alert.show()
}

class wx_GlobalFunctionSwiftFile: NSObject {

}

// MARK: - 清除缓存
func fileSizeOfCache() -> Int {
    // 取出cache文件夹目录 缓存文件都在这个目录下
    let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
    //缓存目录路径 
    delog(cachePath)
    // 取出文件夹下所有文件数组
    let fileArr = FileManager.default.subpaths(atPath: cachePath!)
    //快速枚举出所有文件名 计算文件大小
    var size = 0
    for file in fileArr! {
        // 把文件名拼接到路径中
        let path = cachePath?.appending("/\(file)")
        // 取出文件属性 
        let floder = try! FileManager.default.attributesOfItem(atPath: path!)
        // 用元组取出文件大小属性
        for (abc, bcd) in floder {
            // 累加文件大小
            if abc == FileAttributeKey.size {
                size += (bcd as AnyObject).integerValue
            }
        }
    }
    let mm = size / 1024 / 1024
    return mm
}

func clearCache() {
    
    delog("清除中...")
    // 取出cache文件夹目录 缓存文件都在这个目录下
    let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
    // 取出文件夹下所有文件数组
    let fileArr = FileManager.default.subpaths(atPath: cachePath!)
    // 遍历删除
    for file in fileArr! {
        let path = cachePath?.appending("/\(file)")
        if FileManager.default.fileExists(atPath: path!) {
            do {
                try FileManager.default.removeItem(atPath: path!)
            } catch {
                
            }
        }
    }
}

func returnDefaultWithRedioButton() -> UIButton {
    let btn = UIButton()
    btn.backgroundColor = backGroundColor
    btn.setTitleColor(getColorWithNotAlphe(0xF1931A), for: .normal)
    btn.titleLabel?.font = UIFont.systemFont(ofSize: GET_SIZE * 32)
    viewRadius(btn, 5.0, 0.5, UIColor.lightGray)
    return btn
}

func __compentString(_ str: String, _ char: String) -> [String] {
    
    return str.components(separatedBy: char)
}

//MARK: 获得渐变背景颜色
func getChangeIMG(_ height: NSInteger) -> UIImage {
    
    let view = UIView(frame: CGRect(x:0, y:0, width:Int(WIDTH), height:height))
    view.layer.insertSublayer(getChangeView(height), at: 0)
    UIGraphicsBeginImageContext(view.size)
    view.layer.render(in: UIGraphicsGetCurrentContext()!)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image!
}

//MARK: 获得渐变背景颜色
func getChangeView(_ height: NSInteger) -> CAGradientLayer {
    
    let leftColor = getColorWithNotAlphe(0xFF8A92)
    let rightColor = getColorWithNotAlphe(0xFF5D5E)
    let gradient = CAGradientLayer()
    gradient.frame = CGRect(x:0, y:0, width:Int(WIDTH), height:height)
    gradient.colors = [leftColor.cgColor,rightColor.cgColor]
    gradient.startPoint = CGPoint.init(x: 0, y: 0.5)
    gradient.endPoint = CGPoint.init(x: 1, y: 0.5)
    return gradient
}

func nowGotoLogin() {
    
    UIApplication.shared.keyWindow?.rootViewController?.present(NewLoginLocationViewController(), animated: true, completion: nil)
}
