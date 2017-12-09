//
//  NewReviewHeadTabCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/10/26.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewReviewHeadTabCell: UITableViewCell {

    private var _model : NewReviewingModel?
    var model : NewReviewingModel? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    
    private func didSetModel(_ model: NewReviewingModel) {
        
        head.kf.setImage(with: StringToUTF_8InUrl(str: model.photo))
        viewRadius(head, 24.5, 0.5, lineColor)
        head.contentMode = .scaleAspectFill
        
        title.text = model.nickName
        other.text = model.title
        if model.auditState == "0" {
            state.text = "审核中"
        }else {
            state.text = "审核失败"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var head: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var other: UILabel!
    @IBOutlet weak var state: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
