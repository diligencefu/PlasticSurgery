//
//  NewMain_BaiKeTabCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/9/21.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewMain_BaiKeTabCell: UITableViewCell {

    private var _model : NewMain_BaiKe_detailModel?
    var model : NewMain_BaiKe_detailModel? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    private func didSetModel(_ model: NewMain_BaiKe_detailModel) {
        
        detail.text = model.projectPresent
        
        what.text = model.projectType
        price.text = "\(model.minPrice) - \(model.maxPrice)"
        Circle.text = model.recoveryCycle
        count.text = "\(model.treatmentCount)次"
    }
    
    @IBOutlet weak var detail: UILabel!
    
    @IBOutlet weak var what: UILabel!//治疗方式
    @IBOutlet weak var price: UILabel!//参考价格
    @IBOutlet weak var Circle: UILabel!//恢复周期
    @IBOutlet weak var count: UILabel!//治疗次shu
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func Learnmore(_ sender: Any) {
        
        let enter = NewMain_BaiKe_EnterViewController()
        enter.id = (_model?.id)!
        viewController()?.navigationController?.pushViewController(enter, animated: true)
    }
}
