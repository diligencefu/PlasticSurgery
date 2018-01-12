//
//  FYHMainShowADCell.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/22.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class FYHMainShowADCell: UITableViewCell {
    
    @IBOutlet weak var ADImage: UIImageView!
    @IBOutlet weak var ADName: UILabel!
    
//    @IBOutlet weak var ADContent: UILabel!
//    @IBOutlet weak var viewCount: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func setValuesForFYHMainShowADCell(model:FYHSowMainADModel) {
        
        ADImage.kf.setImage(with: StringToUTF_8InUrl(str:model.infoBanner.imgUrl))
        ADName.text = model.infoBanner.name
//        ADContent.text = model.infoBanner.describes
//        viewCount.setTitle(model.infoBanner.hits, for: .normal)
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
