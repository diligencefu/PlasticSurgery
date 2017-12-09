//
//  DistributorHeadView.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/5.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class DistributorHeadView: UIView {

    @IBOutlet weak var headIcon: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var sexMark: UIImageView!
    @IBOutlet weak var VipLevel: UILabel!
    
    override func awakeFromNib() {
        
        headIcon.clipsToBounds = true
        headIcon.layer.cornerRadius = 33
        
        sexMark.clipsToBounds = true
        sexMark.layer.cornerRadius = 1
        
    }
    
    func setValuesWithModel(model:DistributorModel) {
        
        headIcon.kf.setImage(with:  StringToUTF_8InUrl(str:model.photo))
            
        userName.text = model.nickName
        
        VipLevel.text = model.memberName
        if model.sex == "1" {
            sexMark.image = #imageLiteral(resourceName: "na")
        }else{
            sexMark.image = #imageLiteral(resourceName: "nv")
        }
        
    }
    
    
    
    
}
