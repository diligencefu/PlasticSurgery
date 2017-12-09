//
//  FYHRewardCell.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/9.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class FYHRewardCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var content: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func FYHRewardCellSetValues(model:FYHRewardModel,title1:String) {
        title.text = title1+"."+model.starName
        
        var state = ""
        
        if model.receive == "false" {
            state = "未"
        }else{
            state = "已"
        }
        
        content.text = "团队消费达到"+model.consumption+"元，奖励金额"+model.reward+"元，奖励积分"+model.integral+"分，您"+state+"达到该星级奖励。"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
