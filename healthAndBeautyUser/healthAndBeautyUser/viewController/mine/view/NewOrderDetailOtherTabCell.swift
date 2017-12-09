//
//  NewOrderDetailOtherTabCell.swift
//  healthAndBeautyUser
//
//  Created by 丿番茄 on 2017/11/8.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewOrderDetailOtherTabCellModel: NSObject {
    
    var type = String()
    var detail = String()
}

class NewOrderDetailOtherTabCell: UITableViewCell {
    
    private var _model : NewOrderDetailOtherTabCellModel?
    var model : NewOrderDetailOtherTabCellModel? {
        didSet {
            self.didSetModel(model!)
            _model = model
        }
    }
    
    private func didSetModel(_ model: NewOrderDetailOtherTabCellModel) {
        
        detail.text = model.type
        detailOther.text = model.detail
    }
    
    //前半部分
    @IBOutlet weak var detail: UILabel!
    //后半部分
    @IBOutlet weak var detailOther: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
