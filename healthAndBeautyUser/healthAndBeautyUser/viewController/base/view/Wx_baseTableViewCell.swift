//
//  wx_baseTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by  on 2017/8/11.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SDAutoLayout
import SwiftyJSON

class Wx_baseTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = backGroundColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
