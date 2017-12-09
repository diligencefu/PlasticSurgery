//
//  NewMainADTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 丿番茄 on 2017/11/24.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewMainADTableViewCell: UITableViewCell {

    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var rightTopBtn: UIButton!
    @IBOutlet weak var rightBottomBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func click(_ sender: UIButton) {
        
        switch sender.tag {
        case 666:
            break
        case 667:
            break
        case 668:
            break
        default:
            break
        }
    }
}
