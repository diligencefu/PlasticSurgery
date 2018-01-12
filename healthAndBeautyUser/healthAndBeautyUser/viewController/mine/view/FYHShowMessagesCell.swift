//
//  FYHShowMessagesCell.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/26.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class FYHShowMessagesCell: UITableViewCell {

    @IBOutlet weak var userIcon: UIButton!
    @IBOutlet weak var userName: UIButton!
    @IBOutlet weak var createDate: UILabel!
    
    @IBOutlet weak var eventDetail: UILabel!
    @IBOutlet weak var comment: UILabel!
    
    @IBOutlet weak var backView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userIcon.clipsToBounds = true
        userIcon.layer.cornerRadius = userIcon.width/2
        
        backView.clipsToBounds = true
        userIcon.layer.cornerRadius = 3
        // Initialization code
    }
    
    
    func setValuesForFYHShowMessagesCell(model:FYHMineMessgeAllModel,type:NSInteger) {

        if model.photo != nil {
            userIcon.kf.setImage(with: StringToUTF_8InUrl(str:model.photo), for: .normal)
        }
        userName.setTitle(model.nickName, for: .normal)
        
        createDate.text = model.infoNotify.createDate
        if type == 1 {
            comment.text = ""
        }
        if type == 2 {
            comment.text = model.content
        }
        if type == 3 {
            comment.text = ""
        }
        eventDetail.text = model.infoNotify.title
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
