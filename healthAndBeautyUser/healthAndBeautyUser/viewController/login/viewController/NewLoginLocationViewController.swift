//
//  NewLoginLocationViewController.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/9/22.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewLoginLocationViewController: Wx_baseViewController {

    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        loginBtn.layer.cornerRadius = 5.0
        loginBtn.layer.masksToBounds = true
        
        #if DEBUG
//            phoneTF.text = "15850717367"
//            passwordTF.text = "123"
//            phoneTF.text = "18771980865"
//            passwordTF.text = "123456"
            phoneTF.text = "18571720073"
            passwordTF.text = "123456"
        #endif
    }
    
    override func awakeFromNib() {
        
    }
    
    @IBAction func click(_ sender: UIButton) {
        
        switch sender.tag {
        case 666://返回
            back()
            break
        case 667://登录
            login()
            break
        case 668://注册账号
            let regist = NewRegistViewController.init(nibName: "NewRegistViewController", bundle: nil)
            regist.isRegist = true
            navigationController?.pushViewController(regist, animated: true)
            break
        case 669://忘记密码
            let regist = NewRegistViewController.init(nibName: "NewRegistViewController", bundle: nil)
            regist.isRegist = false
            navigationController?.pushViewController(regist, animated: true)
            break
        default:
            break
        }
    }
    private func login() {
        
        if !MD5.isTelphoneNumber(phoneTF.text!) {
            
            SVPwillShowAndHide("请输入正确的手机号码")
            return
        }
        if (passwordTF.text?.count)! < 6 {
            
            SVPwillShowAndHide("请输入6位数以上密码")
            return
        }
        
        let up = ["username": phoneTF.text!,
                  "password": passwordTF.text!,
                  "mobileLogin": true,
                  "mobileCode": Defaults["mobileCode"].string!]
            as [String : Any]
        
        SVPWillShow("载入中...")
        delog(up)
        
        Net.share.postRequest(urlString: loginJoggle, params: up, success: { (datas) in
            let json = JSON(datas)
            delog(json)
            SVPHide()
            if json["code"].int == 1 {
                let date = json["data"]
                Defaults["SESSIONID"] = date["sessionId"].string!
                Defaults["phone"] = self.phoneTF.text!
                self.back()
            }else {
                SVPwillShowAndHide(json["message"].string!)
            }
        }) { (error) in
            delog(error)
            SVPwillShowAndHide("请检查您的网路")
        }
    }
    
    private func back() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension NewLoginLocationViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == phoneTF {
            if textField.text == "" {
                textField.text = "请输入手机号码"
            }
        }else if textField == passwordTF {
            if textField.text == "" {
                textField.text = "请输入密码"
            }
        }
    }
}
