//
//  FYHShowDoneView.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/20.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class FYHShowDoneView: UIView {
    
    @IBOutlet weak var goodImage: UIImageView!
    
    @IBOutlet weak var goodName: UILabel!
    
    @IBOutlet weak var certainBtn: UIButton!
    
    override func awakeFromNib() {
        
    }
    
    
    func 展示抽奖得到的奖品(图片:String,名称:String) {
        goodName.text = 名称
        goodImage.kf.setImage(with:  StringToUTF_8InUrl(str:图片))
    }
    
    @IBAction func certainAction(_ sender: UIButton) {
        
    }
    
}
