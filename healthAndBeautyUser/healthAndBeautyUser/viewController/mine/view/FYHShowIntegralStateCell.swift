//
//  FYHShowIntegralStateCell.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/26.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class FYHShowIntegralStateCell: UITableViewCell {

    @IBOutlet weak var goodImage: UIImageView!
    @IBOutlet weak var goodName: UILabel!
    @IBOutlet weak var forPostage: UILabel!
    @IBOutlet weak var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func setValuesForFYHShowIntegralStateCell(model:FYHIntergralGoodsModel) {
        
        goodImage.kf.setImage(with: StringToUTF_8InUrl(str:model.thumbnail))
        goodName.text = model.name
        
        if model.isPostage == "1" {
            forPostage.text = "包邮"
        }else{
            forPostage.text = "邮费:￥"+model.postage
        }
        price.text = model.integral
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
