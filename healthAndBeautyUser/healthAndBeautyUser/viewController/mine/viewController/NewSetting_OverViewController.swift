//
//  newSetting_OverViewController.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/15.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewSetting_OverViewController: Wx_baseViewController {

    var type = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createNaviController(title: "修改成功", leftBtn: buildLeftBtn(), rightBtn: nil)
        buildUI()
    }
    override func pop() {
        let index = navigationController?.viewControllers.index(of: self)
        let controller = navigationController?.viewControllers[index!-2]
        navigationController?.popToViewController(controller!, animated: true)
    }
    private func buildUI() {
        
        let img = UIImageView()
        view.addSubview(img)
        _ = img.sd_layout()?
            .centerYEqualToView(view)?
            .centerXEqualToView(view)?
            .widthIs(GET_SIZE * 240)?
            .heightIs(GET_SIZE * 240)
        
        let detail = UILabel()
        detail.textColor = UIColor.blue
        detail.font = UIFont.systemFont(ofSize: GET_SIZE * 32)
        detail.textAlignment = .center
        view.addSubview(detail)
        _ = detail.sd_layout()?
            .topSpaceToView(img,GET_SIZE * 24)?
            .centerXEqualToView(view)?
            .widthIs(WIDTH/2)?
            .heightIs(GET_SIZE * 32)
        
        switch type {
            //img还没有设置值
        case "修改密码":
            detail.text = "修改密码成功"
            break
        case "意见反馈":
            detail.text = "意见反馈已提交"
            break
        case "投诉":
            detail.text = "您的投诉已提交，我们会尽快处理"
            break
        default:
            break
        }
    }
}
