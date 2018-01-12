//
//  FYHIntegralHeadCell0.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/20.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class FYHIntegralHeadCell0: UICollectionViewCell {

    @IBOutlet weak var intagral: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var surplus: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func setInfomation(intagralStr:String,priceStr:String,surplusStr:String) {
        intagral.text = "积分 "+intagralStr
        price.text = priceStr+"积分/次"
        surplus.text = "您今天还剩余"+surplusStr+"次机会"

    }
    
}
