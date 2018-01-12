//
//  FYHMineShowNitifCell.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/26.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class FYHMineShowNitifCell: UITableViewCell {

    
    @IBOutlet weak var nitiImage: UIImageView!
    @IBOutlet weak var notiTitle: UILabel!
    @IBOutlet weak var notiContent: UILabel!
    @IBOutlet weak var notiDate: UILabel!
    
    @IBOutlet weak var isUnread: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nitiImage.clipsToBounds = true
        nitiImage.layer.cornerRadius = nitiImage.width/2

        isUnread.clipsToBounds = true
        isUnread.layer.cornerRadius = isUnread.width/2

    }
    
    
    func setValuesForFYHMineShowNitifCell(model:FYHShowNotiModel) {
        if model.icon != nil {
            nitiImage.kf.setImage(with: StringToUTF_8InUrl(str:model.icon))
        }
        notiTitle.text = model.title
        notiContent.text = model.content
        notiDate.text = model.sendTime
        
        if model.isRead == "0" {
            isUnread.isHidden = false
        }else{
            isUnread.isHidden = true
        }
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
