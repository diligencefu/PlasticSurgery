//
//  NewReviewDetailTabCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/10/26.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewReviewDetailTabCell: UITableViewCell {

    private var _model : NewReviewingModel?
    var model : NewReviewingModel? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    
    private func didSetModel(_ model: NewReviewingModel) {
        
        details.text = model.remarks
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var details: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func click(_ sender: UIButton) {
        ///     - title    标题
        ///     - detail    详细注释
        ///     - controller    按钮状态
        let tmp = viewController() as! Wx_baseViewController
        tmp.buildAlter("提示", "是否删除该审核失败日志", "确定")
    }
}
