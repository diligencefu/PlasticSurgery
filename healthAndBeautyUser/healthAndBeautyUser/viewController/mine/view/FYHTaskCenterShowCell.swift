//
//  FYHTaskCenterShowCell.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/22.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class FYHTaskCenterShowCell: UITableViewCell {

    @IBOutlet weak var taskType: UILabel!
    
    @IBOutlet weak var taskImage: UIImageView!
    @IBOutlet weak var rewardType: UILabel!
    @IBOutlet weak var integral: UIButton!
    
    @IBOutlet weak var todoIt: UIButton!
    @IBOutlet weak var progress: UILabel!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 3
        progressView.layer.borderWidth = 0.5
        progressView.layer.borderColor = kGaryColor(num: 170).cgColor

        progressView.transform.scaledBy(x: 2.5, y: 1)
        
        todoIt.clipsToBounds = true
        todoIt.layer.cornerRadius = 10*kSCREEN_SCALE
        
        integral.clipsToBounds = true
        integral.layer.cornerRadius = 3
        integral.layer.borderWidth = 0.5
        integral.layer.borderColor = kGaryColor(num: 170).cgColor
        
        taskImage.clipsToBounds = true
        taskImage.layer.cornerRadius = 25

    }

    func setValuesForFYHTaskCenterShowCell(model:FYHTaskCenterShowModel,isDaily:Bool) {
        taskImage.kf.setImage(with:  StringToUTF_8InUrl(str:model.icon))
        integral.setTitle("+"+model.credit, for: .normal)
        progress.text = "进度 " + model.count+"/"+model.rewardNum
        
        if Int(model.count)! == Int(model.rewardNum)! {
            todoIt.isEnabled = true
            todoIt.setTitle("已完成", for: .normal)
            todoIt.backgroundColor = kGaryColor(num: 222)
        }else{
            todoIt.isEnabled = false
            todoIt.setTitle("去完成", for: .normal)
            todoIt.backgroundColor = kMainColor()
        }
        
        if isDaily {
            taskType.text = "每日任务"
        }else{
            taskType.text = "累计任务"
        }
        if Int(model.count) == 0 {
            progressView.progress = 0
        }else{
            progressView.progress = Float(model.count)!/Float(model.rewardNum)!
        }
        integral.snp.updateConstraints { (ls) in
            ls.width.equalTo(getSizeOnString("+"+model.credit, 14).width+18)
        }
        rewardType.text = model.name
    }
    
    
    @IBAction func todoAction(_ sender: UIButton) {
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
