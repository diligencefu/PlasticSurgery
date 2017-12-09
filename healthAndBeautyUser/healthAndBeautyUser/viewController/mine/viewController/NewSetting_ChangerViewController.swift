//
//  newSetting_ChangerViewController.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/15.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewSetting_ChangerViewController: Wx_baseViewController {

    let type = "意见反馈"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createNaviController(title: type, leftBtn: buildLeftBtn(), rightBtn: nil)
        buildUI()
    }
    
    private func buildUI() {
        
        let currentPassword = UITextField()
        currentPassword.borderStyle = .none
        currentPassword.placeholder = "输入当前密码"
        currentPassword.textColor = UIColor.black
        currentPassword.backgroundColor = UIColor.white
        currentPassword.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        view.addSubview(currentPassword)
        _ = currentPassword.sd_layout()?
            .centerXEqualToView(view)?
            .topSpaceToView(view,GET_SIZE * 32)?
            .widthIs(GET_SIZE * 680)?
            .heightIs(GET_SIZE * 60)
        viewRadius(currentPassword, 5.0, 0.5, UIColor.black)
        currentPassword.leftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: GET_SIZE * 20, height: GET_SIZE * 20))
        currentPassword.leftViewMode = .always
        
        let newPassword = UITextField()
        newPassword.borderStyle = .none
        newPassword.placeholder = "请输入密码"
        newPassword.textColor = UIColor.black
        newPassword.backgroundColor = UIColor.white
        newPassword.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        view.addSubview(newPassword)
        _ = newPassword.sd_layout()?
            .centerXEqualToView(view)?
            .topSpaceToView(currentPassword,GET_SIZE * 32)?
            .widthIs(GET_SIZE * 680)?
            .heightIs(GET_SIZE * 60)
        viewRadius(newPassword, 5.0, 0.5, UIColor.black)
        newPassword.leftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: GET_SIZE * 20, height: GET_SIZE * 20))
        newPassword.leftViewMode = .always
        
        let secondNewPassword = UITextField()
        secondNewPassword.borderStyle = .none
        secondNewPassword.placeholder = "请再次输入密码"
        secondNewPassword.textColor = UIColor.black
        secondNewPassword.backgroundColor = UIColor.white
        secondNewPassword.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        view.addSubview(secondNewPassword)
        _ = secondNewPassword.sd_layout()?
            .centerXEqualToView(view)?
            .topSpaceToView(newPassword,GET_SIZE * 32)?
            .widthIs(GET_SIZE * 680)?
            .heightIs(GET_SIZE * 60)
        viewRadius(secondNewPassword, 5.0, 0.5, UIColor.black)
        secondNewPassword.leftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: GET_SIZE * 20, height: GET_SIZE * 20))
        secondNewPassword.leftViewMode = .always
        
        let btn = UIButton()
        btn.setTitle("修改密码", for: .normal)
        btn.backgroundColor = backGroundColor
        btn.setTitleColor(getColorWithNotAlphe(0xF1931A), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: GET_SIZE * 32)
        btn.addTarget(self, action: #selector(forgetPassword), for: .touchUpInside)
        viewRadius(btn, 5.0, 0.5, UIColor.lightGray)
        view.addSubview(btn)
        _ = btn.sd_layout()?
            .centerXEqualToView(view)?
            .topSpaceToView(secondNewPassword,GET_SIZE * 75)?
            .widthIs(GET_SIZE * 650)?
            .heightIs(GET_SIZE * 68)
    }
    
    @objc private func forgetPassword() {
        
        delog("修改密码")
        let over = NewSetting_OverViewController()
        over.type = type
        navigationController?.pushViewController(over, animated: true)
    }
}
