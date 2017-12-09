//
//  PayWayCell.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/6.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class PayWayCell: UITableViewCell {

    @IBOutlet weak var payImage: UIImageView!
    @IBOutlet weak var payWay: UILabel!
    @IBOutlet weak var balance: UILabel!
    
    @IBOutlet weak var isSelect: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func PayWayCellSetValues(image:String,title:String,balance1:String,select:Bool) {
        
        payImage.image = UIImage.init(named: image)
        payWay.text = title
        isSelect.isHidden = false
        if balance1.count>0 {
            balance.text = "余额:￥"+balance1
        }else{
            balance.text = ""
        }
        
        if select {
            isSelect.image = #imageLiteral(resourceName: "selector_selector_pressed")
        }else{
            isSelect.image = #imageLiteral(resourceName: "selector_selector_default")
        }
        
    }
    
    
    func PayWayCellSetValuesRecharge(image:String,title:String) {
        
        payImage.image = UIImage.init(named: image)
        payWay.text = title
        balance.text = ""
        isSelect.isHidden = true
    }

    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
