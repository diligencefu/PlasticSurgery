//
//  newSetting_SuggestViewController.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/15.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewSetting_SuggestViewController: Wx_baseViewController,UITextViewDelegate {

    let type = "意见反馈"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createNaviController(title: type, leftBtn: buildLeftBtn(), rightBtn: buildRightBtnWithName("提交"))
        buildUI()
    }
    
    private func buildUI() {
        
        let detail = UITextView()
        detail.text = "请详细描述您的问题,我们将第一时间为您解决"
        detail.delegate = self
        detail.textColor = UIColor.black
        detail.backgroundColor = UIColor.white
        detail.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        view.addSubview(detail)
        _ = detail.sd_layout()?
            .centerXEqualToView(view)?
            .topSpaceToView(view,GET_SIZE * 32)?
            .widthIs(GET_SIZE * 680)?
            .heightIs(GET_SIZE * 450)
        viewRadius(detail, 5.0, 0.5, UIColor.black)
        
        let qq = UITextField()
        qq.borderStyle = .none
        qq.placeholder = "请留下QQ/E-mail，以便给您回复"
        qq.textColor = UIColor.black
        qq.backgroundColor = UIColor.white
        qq.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        view.addSubview(qq)
        _ = qq.sd_layout()?
            .centerXEqualToView(view)?
            .topSpaceToView(detail,GET_SIZE * 32)?
            .widthIs(GET_SIZE * 680)?
            .heightIs(GET_SIZE * 60)
        viewRadius(qq, 5.0, 0.5, UIColor.black)
        qq.leftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: GET_SIZE * 20, height: GET_SIZE * 20))
        qq.leftViewMode = .always
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "请详细描述您的问题,我们将第一时间为您解决" {
            textView.text = ""
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "请详细描述您的问题,我们将第一时间为您解决"
        }
    }
    override func rightClick() {
        super.rightClick()
        let over = NewSetting_OverViewController()
        over.type = type
        navigationController?.pushViewController(over, animated: true)
    }
}
