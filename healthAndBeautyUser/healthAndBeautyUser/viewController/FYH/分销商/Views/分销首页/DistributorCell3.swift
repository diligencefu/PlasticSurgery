//
//  DistributorCell3.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/5.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class DistributorCell3: UITableViewCell {

    @IBOutlet weak var cellTitle: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setTitle(title:String) {
        cellTitle.text = title
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
