//
//  FYHGoodsCollectionViewCell.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/20.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class FYHGoodsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var goodImage: UIImageView!
    @IBOutlet weak var goodName: UILabel!
    @IBOutlet weak var integral: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var surplus: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setValuesForFYHGoodsCollectionViewCell(model:FYHConvertGoodsModel) {
        goodImage.kf.setImage(with:  StringToUTF_8InUrl(str:model.thumbnail))
        goodName.text = model.name
        integral.text = model.integral
        price.text = "￥"+model.originalPrice
        if model.stock != "-1" {
            surplus.text = "库存"+model.stock+"件"
        }else{
            surplus.text = ""
        }

    }

}
