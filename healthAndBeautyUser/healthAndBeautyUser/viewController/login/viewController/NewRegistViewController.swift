//
//  NewRegistViewController.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/9/22.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewRegistViewController: UIViewController {

    var isRegist = Bool()
    var isExchange = Bool()

    @IBOutlet weak var viewTitle: UILabel!
    
    @IBOutlet weak var secrotCode: UIButton!
    
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var codeTF: UITextField!
    @IBOutlet weak var fPasswordTF: UITextField!
    @IBOutlet weak var sPasswordTF: UITextField!
    @IBOutlet weak var otherTF: UITextField!
    
    @IBOutlet weak var registBtn: UIButton!
    
    @IBOutlet weak var other1: UIImageView!
    @IBOutlet weak var other2: UITextField!
    @IBOutlet weak var other3: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        secrotCode.layer.cornerRadius = 5.0
        secrotCode.layer.masksToBounds = true
        secrotCode.layer.borderColor = UIColor.white.cgColor
        secrotCode.layer.borderWidth = 1
        
        registBtn.layer.cornerRadius = 5.0
        registBtn.layer.masksToBounds = true
        registBtn.layer.borderColor = UIColor.white.cgColor
        registBtn.layer.borderWidth = 0.5
        
        if !isRegist {
            
            other1.isHidden = true
            other2.isHidden = true
            other3.isHidden = true
            
            viewTitle.text = "找回密码"
            registBtn.setTitle("找回密码", for: .normal)
        }else {
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isExchange {
            viewTitle.text = "修改密码"
            registBtn.setTitle("修改密码", for: .normal)
        }
    }
    @IBAction func click(_ sender: UIButton) {
        switch sender.tag {
        case 300://返回
            navigationController?.popViewController(animated: true)
            break
        case 301://发送验证码
            sendCode()
            break
        case 302://注册
            findOrRegist()
            break
        case 303://找回密码----》废弃
            if isRegist {
                let regist = NewRegistViewController.init(nibName: "NewRegistViewController", bundle: nil)
                regist.isRegist = false
                navigationController?.pushViewController(regist, animated: true)
            }else {
                let regist = NewRegistViewController.init(nibName: "NewRegistViewController", bundle: nil)
                regist.isRegist = true
                navigationController?.pushViewController(regist, animated: true)
            }
            break
        default:
            break
        }
    }
    
    private func sendCode() {
        
        if !MD5.isTelphoneNumber(phoneTF.text!) {
            
            SVPwillShowAndHide("请输入正确的手机号码")
            return
        }
        
        let up = ["phone": phoneTF.text!]
            as [String : Any]
        
        SVPWillShow("载入中...")
        delog(up)
        
        Net.share.getRequest(urlString: getSmsJoggle, params: up, success: { (datas) in
            let json = JSON(datas)
            delog(json)
            SVPHide()
            if json["code"].int == 1 {
                self.secrotCode.becomeFirstResponder()
            }else {
                SVPwillShowAndHide(json["message"].string!)
            }
        }) { (error) in
            delog(error)
            SVPwillShowAndHide("请检查您的网路")
        }
    }
    
    private func findOrRegist() {
        
        if !MD5.isTelphoneNumber(phoneTF.text!) {
            
            SVPwillShowAndHide("请输入正确的手机号码")
            return
        }
        
        if (fPasswordTF.text?.count)! < 6 {
            
            SVPwillShowAndHide("请输入6位数以上密码")
            return
        }
        
        if (sPasswordTF.text?.count)! < 6 {
            
            SVPwillShowAndHide("请输入6位数以上密码")
            return
        }
        
        if fPasswordTF.text != sPasswordTF.text {
            
            SVPwillShowAndHide("确认两次输入密码一致")
            return
        }
        
        var up = ["phone": phoneTF.text!,
                  "password": fPasswordTF.text!,
                  "content": codeTF.text!]
            as [String : Any]
        
        if isRegist {
            up["type"] = "1"
        }else {
            up["type"] = "2"
        }
        
        if (otherTF.text?.count)! != 0 {
            
            up["referralCode"] = otherTF.text
        }
        
        SVPWillShow("载入中...")
        delog(up)
        
        Net.share.postRequest(urlString: operationUserJoggle, params: up, success: { (datas) in
            let json = JSON(datas)
            delog(json)
            SVPHide()
            if json["code"].int == 1 {
                self.secrotCode.becomeFirstResponder()
            }else {
                SVPwillShowAndHide(json["message"].string!)
            }
        }) { (error) in
            delog(error)
            SVPwillShowAndHide("请检查您的网路")
        }
    }
}

extension NewRegistViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            if textField == phoneTF {
                if textField.text == "" {
                    textField.text = "请输入手机号码"
                }
            }else if codeTF == fPasswordTF {
                if fPasswordTF.text == "" {
                    fPasswordTF.text = "请输入密码"
                }
            }else if codeTF == sPasswordTF {
                if sPasswordTF.text == "" {
                    sPasswordTF.text = "请再次输入密码"
                }
            }
        }
    }
}
