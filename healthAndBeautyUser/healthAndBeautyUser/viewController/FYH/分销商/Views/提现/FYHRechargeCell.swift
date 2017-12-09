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
    
    var textDidChangedBlock:(()->())?  //声明闭包

    override func awakeFromNib() {
        super.awakeFromNib()
        content.delegate = self
        content.addTarget(self, action: #selector(textDidChanged(textField:)), for: .editingChanged)
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
            
            var balance = mainModel.cashBalance
            
            if mainModel.cashBalance.count == 0 {
                balance = "0"
            }
            
            if Float(textField.text!)! > Float(balance!)! {
                setToast(str: "您最多可提现"+mainModel.cashBalance+"元")
                textField.text = mainModel.cashBalance
            }
        }
        
        if textDidChangedBlock != nil {
            textDidChangedBlock!()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
