//
//  DistributorCell2.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/5.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class DistributorCell2: UITableViewCell {

    @IBOutlet weak var rechargeBtn: UIButton!
    @IBOutlet weak var withdrawBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        rechargeBtn.clipsToBounds = true
        rechargeBtn.layer.cornerRadius = 10*kSCREEN_SCALE
        rechargeBtn.layer.borderColor = kSetRGBColor(r: 255, g: 93, b: 94).cgColor
        rechargeBtn.layer.borderWidth = 1
        rechargeBtn.backgroundColor = kSetRGBColor(r: 255, g: 93, b: 94)
        
        withdrawBtn.clipsToBounds = true
        withdrawBtn.layer.cornerRadius = 10*kSCREEN_SCALE
        withdrawBtn.layer.borderColor = kGaryColor(num: 117).cgColor
        withdrawBtn.layer.borderWidth = 1

        //        #warning:
        //            sdd f :ss 
//        关于提现说明：
//        如果isCash=0，说明此用户已经禁止提现，提现按钮隐藏
//        如果isCash=1,说明可以提现，但需根据账单日判断
//        账单日当天不允许提现操作，提现按钮处于不允许状态
//        例：billType=2 billDay=15 即每月15号为账单日，当天不允许提现
        
    }

    
    func setValueWithwithdrawBtn(canWithdraw:Bool) {
        
        if canWithdraw {
            withdrawBtn.isEnabled = true
        }else{
            withdrawBtn.isEnabled = false
        }
    }
    
    
    @IBAction func rechargeBtnAction(_ sender: UIButton) {
        
        let rechare = FYHRechargeOrCashVC()
        rechare.isRecharge = true
        viewController()?.navigationController?.pushViewController(rechare, animated: true)
    }
    
    
    @IBAction func withdrawBtnAction(_ sender: UIButton) {
        
        let rechare = FYHRechargeOrCashVC()
        rechare.isRecharge = false
        viewController()?.navigationController?.pushViewController(rechare, animated: true)
    }
    
    
    @IBAction func viewDayAction(_ sender: UIButton) {
        
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
