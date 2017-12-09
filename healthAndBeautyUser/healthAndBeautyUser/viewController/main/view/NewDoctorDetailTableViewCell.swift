//
//  NewDoctorDetailTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/10/21.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewDoctorDetailTableViewCell: UITableViewCell {

    private var _model : doctorPage?
    var model : doctorPage? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    private func didSetModel(_ model: doctorPage) {
        
        position.text = model.currentPosition
        detail.text = model.doctorPrensent
        project.text = model.projectNames
    }
    
    @IBOutlet weak var position: UILabel!
    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var project: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
