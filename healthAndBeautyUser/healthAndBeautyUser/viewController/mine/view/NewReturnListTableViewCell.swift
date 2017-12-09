//
//  NewReturnListTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 丿番茄 on 2017/11/23.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

var NewReturnListTableViewCell_tf = String()
var NewReturnListTableViewCell_tv = String()

class NewReturnListTableViewCell: UITableViewCell,UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var reason: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        phone.delegate = self
        reason.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "退货原因..." {
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text == "" {
            textView.text = "退货原因..."
        }
        NewReturnListTableViewCell_tv = textView.text
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        NewReturnListTableViewCell_tf = textField.text!
    }
}
