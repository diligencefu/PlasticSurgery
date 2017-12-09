//
//  NewOrderDetailDoctorTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 丿番茄 on 2017/11/9.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewOrderDetailDoctorTableViewCell: UITableViewCell {

    private var _model : NewOrderDetailDoctorModel?
    var model : NewOrderDetailDoctorModel? {
        didSet {
            self.didSetModel(model!)
            _model = model
        }
    }
    
    private func didSetModel(_ model: NewOrderDetailDoctorModel) {
        
        doctorName.text = model.doctorsName
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBOutlet weak var doctorName: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func click(_ sender: UIButton) {
        delog(_model!.doctorsId)
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let doctorView = NewDoctorMainPageViewController()
        doctorView.doctorID = _model!.doctorsId
        self.viewController()?.navigationController?.pushViewController(doctorView, animated: true)
    }
}
