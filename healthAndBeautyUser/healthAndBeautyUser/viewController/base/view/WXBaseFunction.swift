//
//  WXBaseFunction.swift
//  WXselectPopModule
//
//  Created by  on 2017/9/16.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import Foundation

class selectVar : NSObject {

    // MARK: - 可设置基本变量
    public var source : [NSMutableArray]? = [["年份","2017年","2018年","2019年","2020年"],
                                             ["月份","9月","10月","11月","12月","13月","14月","15月"],
                                             ["地点","德玛西亚","洛克萨斯","艾欧尼亚","皮尔特沃夫","弗雷尔卓德","祖安"]]
    
    //背景颜色
    public var backColor : UIColor? =           getColorWithNotAlphe(0xF1F1F1)

    //选中后的字体颜色
    public var selectColor : UIColor? =         getColorWithNotAlphe(0x454545)
    
    //未选中的字体颜色
    public var unSelectColor : UIColor? =       getColorWithNotAlphe(0x858585)

    //未选中的字体大小
    public var mainFont : UIFont? =             UIFont.systemFont(ofSize: TEXT32)

    //选中后会旋转的图片
    public var isSelectIMG : UIImage? =         UIImage(named:"shangla_icon_default")
    
    //线的颜色
    public var lineColor : UIColor? =           getColorWithNotAlphe(0xD7D7D7)

    //未选中的cell标题颜色
    public var unSelectCellTitleColor :         UIColor? = getColorWithNotAlphe(0xB0B0B0)

    //选中的cell的标题颜色
    public var selectCellTitleColor :           UIColor? = getColorWithNotAlphe(0x858585)

    //未选中的字体颜色
    public var cellFont : UIFont? =             UIFont.systemFont(ofSize: TEXT28)

    //cell被选中后的图片
    public var selectImage : UIImage? =         UIImage(named:"02_selector_selector_pressed")

    //cell最多显示行数
    public var cellShowNumber : NSInteger? =    5
}
