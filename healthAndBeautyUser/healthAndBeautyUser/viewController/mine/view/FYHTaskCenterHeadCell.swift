//
//  FYHTaskCenterHeadCell.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/22.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class FYHTaskCenterHeadCell: UITableViewCell {

    @IBOutlet weak var userIcon: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userSex: UIImageView!
    
    @IBOutlet weak var userAge: UILabel!
    @IBOutlet weak var userAdress: UILabel!
    
    @IBOutlet weak var userIntegral: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        userIcon.clipsToBounds = true
        userIcon.layer.cornerRadius = userIcon.width/2
    }

    func setValuesForFYHTaskCenterHeadCell(model:FYHTaskCenrtInfoModel) {
        userIcon.kf.setImage(with:  StringToUTF_8InUrl(str:model.photo))
        userName.text = model.nickName
        
        if model.gender == "2" {
            userSex.image = #imageLiteral(resourceName: "nv")
        }else{
            userSex.image = #imageLiteral(resourceName: "na")
        }
        userAge.text = model.age+"岁"
        userAdress.text = model.area
        userIntegral.text = model.integral
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
