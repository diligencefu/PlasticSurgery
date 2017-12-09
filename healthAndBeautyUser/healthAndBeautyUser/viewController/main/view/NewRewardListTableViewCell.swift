//
//  NewRewardListTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/10/20.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewRewardListTableViewCell: UITableViewCell {

    @IBOutlet weak var head: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var money: UILabel!
    @IBOutlet weak var time: UILabel!
    
    
    private var _model : NewRewordListModel?
    var model : NewRewordListModel? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    
    private func didSetModel(_ model: NewRewordListModel) {
        
        head.kf.setImage(with: StringToUTF_8InUrl(str: model.personalphoto))
        viewRadius(head, 30, 0.5, lineColor)
        head.contentMode = .scaleAspectFill
        
        name.text = model.personalnickName
        money.text = "￥ \(model.money)元"
        time.text = model.createDate
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
