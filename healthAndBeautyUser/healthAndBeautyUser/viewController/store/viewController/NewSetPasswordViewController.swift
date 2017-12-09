//
//  NewSetPasswordViewController.swift
//  healthAndBeautyUser
//
//  Created by 丿番茄 on 2017/11/4.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewSetPasswordViewController: Wx_baseViewController {

    @IBOutlet weak var tf: UIView!
    @IBOutlet weak var btn: UIButton!
    
    var textField : JJCPayCodeTextField? = nil
    var password = String()
    //是否是设置
    var firstSet = Bool()
    var isSecongEnter = Bool()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        createNaviController(title: "设置支付密码", leftBtn: buildLeftBtn(), rightBtn: nil)
        textField = JJCPayCodeTextField.init(frame: CGRect.init(x: 32, y: 128, width: WIDTH-64, height: 44), textFieldType: .spaceBorder)
        textField!.isChangeTextFieldNum = true
        textField!.textFieldNum = 6
        textField!.borderSpace = ((WIDTH-64)-(6*44))/5
        textField!.borderColor = lineColor
        textField!.backgroundColor = getColorWithNotAlphe(0xF0F0F0)
        view.addSubview(textField!)

        weak var weakSelf = self
        textField!.finishedBlock = { type in
            delog(type!)
            if weakSelf?.password.count == 0 {
                weakSelf?.password = type!
            }else {
                if type! != weakSelf?.password {
                    SVPwillShowAndHide("两次输入密码不一致，重新输入新密码")
                    weakSelf?.textField!.clearKeyCode()
                }
            }
        }
        btn.layer.cornerRadius = 5.0
        textField!.textField.becomeFirstResponder()
    }

    @IBAction func click(_ sender: UIButton) {
        
        if isSecongEnter {
            completeEnter()
        }else {
            sender.setTitle("再次输入密码", for: .normal)
            textField!.clearKeyCode()
            textField!.textField.becomeFirstResponder()
            isSecongEnter = !isSecongEnter
        }
    }
    
    private func completeEnter() {
        
        let up = ["mobileCode":Defaults["mobileCode"].stringValue,
                  "SESSIONID":Defaults["SESSIONID"].stringValue,
                  "payPwd":password]
            as [String: Any]
        
        delog(up)
        SVPWillShow("载入中...")
        
        Net.share.postRequest(urlString: (firstSet ? setPayPwd_35_joggle : updatePayPwd_36_joggle ), params: up, success: { (datas) in
            let json = JSON(datas)
            delog(json)
            SVPHide()
            if json["code"].int == 1 {
                if self.firstSet {
                    SVPwillSuccessShowAndHide("设置密码成功")
                }else {
                    SVPwillSuccessShowAndHide("重新设置密码成功")
                }
                self.navigationController?.popViewController(animated: true)
            }
        }) { (error) in
            delog(error)
        }
    }
}
