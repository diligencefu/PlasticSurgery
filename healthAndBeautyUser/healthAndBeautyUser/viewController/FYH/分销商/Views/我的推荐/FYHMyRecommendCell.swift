//
//  FYHMyRecommendCell.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/8.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class FYHMyRecommendCell: UITableViewCell {

    @IBOutlet weak var userIcon: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userSex: UIImageView!
    
    @IBOutlet weak var totalCount: UILabel!
    @IBOutlet weak var ship: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func FYHMyRecommendCellSetVlues(model:FYHMyRecModel) {
        
        userIcon.kf.setImage(with:  StringToUTF_8InUrl(str:model.photo))
        userName.text = model.nickName
        if model.gender == "1" {
            userSex.image = #imageLiteral(resourceName: "na")
        }else{
            userSex.image = #imageLiteral(resourceName: "nv")
        }
        totalCount.text = "￥"+model.teamConsumption
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
