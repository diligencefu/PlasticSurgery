//
//  MemberCenterCell.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/6.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SDWebImage

class MemberCenterCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var memberLevel: UILabel!
    @IBOutlet weak var rewardCount: UILabel!
    @IBOutlet weak var discount: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var buyBtn: UIButton!
    
    var buyNowAction:(()->())?  //声明闭包

    override func awakeFromNib() {
        super.awakeFromNib()
        buyBtn.clipsToBounds = true
        buyBtn.layer.cornerRadius = 10*kSCREEN_SCALE
    }

    func MemberCenterCellsetValuesWithModel(model:MemberModel) {
        
        productImage.kf.setImage(with: OCTools.getEfficientAddress(model.memberImage))
        
        memberLevel.text = model.memberName
        rewardCount.text = "奖励"+model.integral+"积分"
        discount.text = "项目折扣: " + String(Float(model.discount)!*10)+"折"
        price.text = "￥" + model.memberAmount
    }
    
    
    @IBAction func buyNowAction(_ sender: UIButton) {
        
        if buyNowAction != nil {
            buyNowAction!()
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
