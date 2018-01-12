//
//  FYHAccountRecordCell.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/11.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class FYHAccountRecordCell: UITableViewCell {

    @IBOutlet weak var typeImage: UIImageView!
    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var disCount: UILabel!
    @IBOutlet weak var count: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        typeImage.clipsToBounds = true
        typeImage.layer.cornerRadius = 33
    }

    func FYHAccountRecordCellSetValuesWithdraw(model:FYHWRecordModel) {
       
        if model.withdrawalType == "1" {
            typeImage.image = UIImage.init(named: "01_alipay_head_default")
        }else{
            typeImage.image = UIImage.init(named: "03_wechat_head_default")
        }
        
        if model.withdrawalStatus == "1" {
            state.text = "提现成功"
        } else if model.withdrawalStatus == "2" {
            state.text = "提现失败"
        } else if model.withdrawalStatus == "0" {
            state.text = "待处理"
        }
        time.text = model.createDate
        disCount.text = "+"+model.poundage
        count.text = "￥"+model.amount
    }
    
    func FYHAccountRecordCellSetValuesRecharge(model:FYHWRecordModel) {
        
        if model.withdrawalType == "1" {
            typeImage.image = UIImage.init(named: "01_alipay_head_default")
        }else{
            typeImage.image = UIImage.init(named: "03_wechat_head_default")
        }
        state.text = model.createDate
        state.font = kFont30
        time.text = ""
        disCount.text = ""
        
        count.text = "￥"+model.amount
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
