//
//  NewPaySuccessOrFailedViewController.swift
//  healthAndBeautyUser
//
//  Created by 丿番茄 on 2017/11/3.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewPaySuccessOrFailedViewController: Wx_baseViewController {

    var isSuccess = Bool()
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !isSuccess {
            
            createNaviController(title: "支付失败", leftBtn: buildLeftBtn(), rightBtn: nil)
            
            img.image = UIImage(named:"payment-fails")
            label.text = "订单支付失败"
            btn.setTitle("重新支付", for: .normal)
        }else {
            createNaviController(title: "支付成功", leftBtn: buildLeftBtn(), rightBtn: nil)
        }
        btn.layer.cornerRadius = 5.0
    }
    override func pop() {
        navigationController?.popToRootViewController(animated: true)
    }

    @IBAction func click(_ sender: UIButton) {
        
        if isSuccess {
            
        }else {
            pop()
        }
    }
}
