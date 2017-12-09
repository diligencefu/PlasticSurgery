//
//  FYHReturnCashCell.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/8.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class FYHReturnCashCell: UITableViewCell {

    @IBOutlet weak var totalMoney: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var countPeriod: UILabel!
    
    @IBOutlet weak var periods: UILabel!
    
    @IBOutlet weak var state: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func FYHReturnCashCellSetValues(model:FYHRCModel) {
        totalMoney.text = "￥"+model.cashback
        timeLabel.text = model.enableDate
        countPeriod.text = "每期返现:￥"+model.eachAmount
        periods.text = "期数:"+"第"+model.periods+"期"
        
        if model.cashbackStatus == "1" {
            state.text = "进行中"
            state.textColor = kSetRGBColor(r: 255, g: 93, b: 94)
        }else{
            state.text = "已结束"
            state.textColor = kGaryColor(num: 74)
        }
    }
    
    func FYHReturnCashCellSetValuesDetail(model:FYHRCDetailModel2) {
        totalMoney.text = "￥"+model.amount
        timeLabel.text = "预期返现:"+model.cashbackDate
        countPeriod.text = "实际返现:"+model.actualDate
        periods.text = ""
        
        if model.cashbackStatus == "1" {
            state.text = "进行中"
            state.textColor = kSetRGBColor(r: 255, g: 93, b: 94)
        }else{
            state.text = "已结束"
            state.textColor = kGaryColor(num: 74)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
