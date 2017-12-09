//
//  NewMeHeadTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 丿番茄 on 2017/11/4.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewMeHeadTableViewCell: UITableViewCell {

    private var _model : NewEditMeModel?
    var model : NewEditMeModel? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    
    private func didSetModel(_ model: NewEditMeModel) {
        
        hrad.kf.setImage(with: StringToUTF_8InUrl(str: model.photo))
        viewRadius(hrad, 22.5, 0.5, lineColor)
        hrad.contentMode = .scaleAspectFill
    }
    
    @IBOutlet weak var hrad: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
