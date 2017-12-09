//
//  FYHRCDetailCell.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/8.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class FYHRCDetailCell: UITableViewCell {

    @IBOutlet weak var theTitle: UILabel!
    
    @IBOutlet weak var theContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func FYHRCDetailCellSetValues(title:String,content:String) {
        theTitle.text = title
        theContent.text = content
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
