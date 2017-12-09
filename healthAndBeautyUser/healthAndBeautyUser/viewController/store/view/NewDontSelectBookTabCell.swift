//
//  NewDontSelectBookTabCell.swift
//  healthAndBeautyUser
//
//  Created by 丿番茄 on 2017/11/2.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewDontSelectBookTabCell: UITableViewCell {

    @IBOutlet weak var notUse: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        notUse.layer.cornerRadius = 5.0
        notUse.layer.masksToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
