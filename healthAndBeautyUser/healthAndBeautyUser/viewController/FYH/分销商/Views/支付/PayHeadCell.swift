//
//  PayHeadCell.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/6.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class PayHeadCell: UITableViewCell {
    
    @IBOutlet weak var orderImage: UIImageView!
    @IBOutlet weak var orderTitle: UILabel!
    @IBOutlet weak var orderPrice: UILabel!
    
    @IBOutlet weak var orderTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setValuesWithModel(model:FYHPayModel) {
        orderImage.kf.setImage(with:  URL(string:model.memberImage)!, placeholder: #imageLiteral(resourceName: "12_banner_secondary_default"), options: nil, progressBlock: nil, completionHandler: nil)
        orderTitle.text = model.memberName
        orderPrice.text = "￥"+model.price
        orderTime.text = "请在"+model.overTime+"分钟内完成支付"
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
