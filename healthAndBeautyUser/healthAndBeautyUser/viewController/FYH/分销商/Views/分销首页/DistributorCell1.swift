//
//  DistributorCell1.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/5.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class DistributorCell1: UITableViewCell {

    @IBOutlet weak var distriImage: UIImageView!
    @IBOutlet weak var distriTitle: UILabel!
    @IBOutlet weak var distriMoney: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func DistributorCell1SetValues(image:String,title1:String,count:String,flag:Bool) {
        
        distriImage.image = UIImage.init(named: image)
        distriTitle.text = title1
        distriMoney.text = "￥" + count
        
        if flag {
            distriMoney.textColor = kGaryColor(num: 69)
            distriMoney.font = kFont42
        }else{
            distriMoney.textColor = kGaryColor(num: 162)
            distriMoney.font = kFont36
        }
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
