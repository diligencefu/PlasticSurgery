//
//  FYHDistributionDetailCell.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/8.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class FYHDistributionDetailCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var payType: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var rewardType: UILabel!
    
    @IBOutlet weak var theType: UILabel!
    @IBOutlet weak var theCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func FYHDistributionDetailCellSetValues(model:DistriDetailModel) {
        userName.text = model.consumer.name
        timeLabel.text = model.createDate
        payType.text = model.cunsumeName
        price.text = model.cost
        rewardType.text = model.consumeMold
        
        if model.isAdd == "1" {
            theCount.text = "+"+model.commissionMoney
        }else{
            theCount.text = "-"+model.commissionMoney
        }
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
