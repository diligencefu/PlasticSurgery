//
//  NewSeting_ComplainViewController.swift
//  healthAndBeautyUser
//
//  Created by 丿番茄 on 2017/11/29.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewSeting_ComplainViewController: Wx_baseViewController {

    @IBOutlet weak var tv: UITextView!
    @IBOutlet weak var tf: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        createNaviController(title: "意见反馈", leftBtn: buildLeftBtn(), rightBtn: buildRightBtnWithName("提交"))
        viewRadius(tv, 5.0, 0.5, lineColor)
        viewRadius(tf, 5.0, 0.5, lineColor)
    }
    
    override func rightClick() {
        
        delog("提交反馈")
    }
}
