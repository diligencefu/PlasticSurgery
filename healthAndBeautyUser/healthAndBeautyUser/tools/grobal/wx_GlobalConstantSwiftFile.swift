//
//  wx_GlobalConstantSwiftFile.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/11.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

let Defaults = UserDefaults(suiteName: "RXSoft")!

/*
 * 宽高
 */
let WIDTH = UIScreen.main.bounds.size.width
let HEIGHT = UIScreen.main.bounds.size.height

/*
 * 尺寸计算
 */
let GET_SIZE = WIDTH/750     //375

/*
 * 字体大小计算
 */
let TEXT20 = GET_SIZE * 20
let TEXT24 = GET_SIZE * 24
let TEXT28 = GET_SIZE * 28
let TEXT32 = GET_SIZE * 32
let TEXT36 = GET_SIZE * 36

/*
 * 各种颜色
 */
//tabbar颜色
let tabbarColor = getColorWithNotAlphe(0xFF5D5E)
//线颜色
let lineColor = getColorWithNotAlphe(0xF0F0F0)

//背景颜色
let backGroundColor = getColorWithNotAlphe(0xFDFDFD)

//字体颜色
let darkText = getColorWithNotAlphe(0x454545)
let lightText = getColorWithNotAlphe(0x999999)
let redText = getColorWithNotAlphe(0xF82C2D)
let blueText = getColorWithNotAlphe(0x179FFF)
let orangeText = getColorWithNotAlphe(0xFFA800)

//组件
let typeLabColor = getColorWithNotAlphe(0x34B0FF)














class wx_GlobalConstantSwiftFile: NSObject {

}
