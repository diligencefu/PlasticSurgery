//
//  NewRequireOtherTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 丿番茄 on 2017/10/31.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewRequireOtherTableViewCell: UITableViewCell {

    private var _phoneNum : String?
    var phoneNum : String? {
        didSet {
            self.didSetModel(phoneNum!)
            _phoneNum = phoneNum
        }
    }
    
    private func didSetModel(_ phoneNum: String) {
        
        phone.text = phoneNum
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var phone: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
