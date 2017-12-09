//
//  NewRequireLocationTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 丿番茄 on 2017/11/1.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewRequireLocationTableViewCell: UITableViewCell {
    
    private var _model : NewStoreLocationModel?
    var model : NewStoreLocationModel? {
        didSet {
            self.didSetModel(model!)
            _model = model
        }
    }
    
    private func didSetModel(_ model: NewStoreLocationModel) {
        
        namer.text = model.realName
        phone.text = model.tel
        address.text = model.area + model.street
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var namer: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var address: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
