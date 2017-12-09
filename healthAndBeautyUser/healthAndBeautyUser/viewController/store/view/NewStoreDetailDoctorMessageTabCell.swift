//
//  NewStoreDetailDoctorMessageTabCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/10/23.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewStoreDetailDoctorMessageTabCell: UITableViewCell {

    private var _model : doctorPage?
    var model : doctorPage? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    
    private func didSetModel(_ model: doctorPage) {
        
        head.kf.setImage(with: StringToUTF_8InUrl(str: model.headImage))
        head.contentMode = .scaleAspectFill
        viewRadius(head, 30, 0.5, lineColor)
        
        name.text = model.doctorName
        prefer.text = model.projectNames
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var head: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var prefer: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let doctorView = NewDoctorMainPageViewController()
        doctorView.doctorID = _model!.id
        self.viewController()?.navigationController?.pushViewController(doctorView, animated: true)
    }
}
