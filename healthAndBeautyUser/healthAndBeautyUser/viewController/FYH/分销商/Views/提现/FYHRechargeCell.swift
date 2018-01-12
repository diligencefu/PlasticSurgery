//
//  FYHRechargeCell.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/9.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class FYHRechargeCell: UITableViewCell ,UITextFieldDelegate{

    @IBOutlet weak var theTitle: UILabel!
    
    @IBOutlet weak var content: UITextField!
    var mainModel = FYHWithdrawModel()
    var index11 = 0
    
    var textDidChangedBlock:((Bool,String)->())?  //声明闭包

    override func awakeFromNib() {
        super.awakeFromNib()
        content.delegate = self
        content.addTarget(self, action: #selector(textDidChanged(textField:)), for: .editingChanged)
//        theTitle.max
    }

    func FYHRechargeCellSetValues(title:String,index:NSInteger,model:FYHWithdrawModel) {
        index11 = index
        mainModel = model
        theTitle.text = title
        
        if index == 4 {
            
            content.isHidden = true
            theTitle.font = kFont28
        }else if index == 3 {
            
            theTitle.font = kFont38
            content.keyboardType = .numberPad
            content.isHidden = false
        }else if index == 2{
            
            theTitle.font = kFont32
            content.isHidden = false
            content.keyboardType = .default
        }else{
            
            theTitle.font = kFont32
            content.isHidden = false
            content.keyboardType = .default
        }
    }
    
    @objc func textDidChanged(textField:UITextField) {
        
        if index11 == 3 && textField.text?.count != 0{
            
            var maxWithdraw = mainModel.maxAmount
            var minWithdraw = mainModel.minAmount

            if mainModel.maxWithdraw.count == 0 {
                maxWithdraw = "0"
                minWithdraw = "0"
            }
            
            if Float(textField.text!)! >= Float(minWithdraw!)! && Float(textField.text!)! < Float(maxWithdraw!)! {
                
                let validCount = Float(mainModel.cashBalance!)!-Float(mainModel.cashBalance!)!*Float(mainModel.withdrawDiscount!)!
                
                
                if Float(textField.text!)! < validCount{
                    
                    if textDidChangedBlock != nil {
                        textDidChangedBlock!(true,"")
                    }
                }else{
                    
                    if textDidChangedBlock != nil {
                        textDidChangedBlock!(false,"超过您账户可提现的最大值!(包含手续费"+String(Float(mainModel.cashBalance!)!*Float(mainModel.withdrawDiscount!)!)+")")
                    }
                }
            }else{
                
                if Float(textField.text!)! < Float(minWithdraw!)! {
                    if textDidChangedBlock != nil {
                        textDidChangedBlock!(false,"低于单笔提现最低金额:￥"+mainModel.minAmount)
                    }
                }else{
                    if textDidChangedBlock != nil {
                        textDidChangedBlock!(false,"高于单笔提现最高金额:￥"+mainModel.maxAmount)
                    }
                }
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

