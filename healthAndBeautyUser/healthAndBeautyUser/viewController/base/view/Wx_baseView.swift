//
//  wx_baseView.swift
//  healthAndBeautyUser
//
//  Created by  on 2017/8/11.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SDAutoLayout
import SwiftyJSON

class Wx_baseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = backGroundColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
