//
//  NewStoreDetailGoodsDetailTabCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/10/23.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewStoreDetailGoodsDetailTabCell: UITableViewCell {

    private var _model : NewStoreDetailModel?
    var model : NewStoreDetailModel? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    
    private func didSetModel(_ model: NewStoreDetailModel) {
        
        content.text = model.productDescrible
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var content: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
