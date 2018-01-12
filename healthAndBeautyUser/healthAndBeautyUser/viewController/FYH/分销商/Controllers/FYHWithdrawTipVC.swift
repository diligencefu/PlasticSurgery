//
//  FYHWithdrawTipVC.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/11.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class FYHWithdrawTipVC: Base2ViewController {
    var mainModel = FYHWithdrawModel()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func configSubViews() {
        
        setupTitleViewSectionStyle(titleStr: "提现须知")
        
        self.navigationItem.title = "提现须知"
        let tipLabel = UITextView.init(frame: CGRect(x: 10, y: CGFloat(74), width: kSCREEN_WIDTH-20, height: kSCREEN_HEIGHT-80))
        tipLabel.text = "每日提现的次数上限为"+mainModel.count+"次，今日已提现"+mainModel.withdrawCount+"次，单笔提现扣除手续费按提现金额的"+mainModel.withdrawDiscount+"收取，单笔手续费小于"+mainModel.minWithdraw+"元，按照"+mainModel.minWithdraw+"元收取，单笔手续费大于"+mainModel.maxWithdraw+"元，按照"+mainModel.maxWithdraw+"元收取.单笔提现金额最低"+mainModel.minAmount+"元，最高"+mainModel.maxAmount+"元。"
        tipLabel.backgroundColor = UIColor.white
        tipLabel.textColor = kTextColor()
        tipLabel.font = kFont30
        tipLabel.clipsToBounds = true
        tipLabel.layer.cornerRadius = 3
        tipLabel.isEditable = false
        self.view.addSubview(tipLabel)
        
    }

}
