//
//  wx_baseNaviViewController.swift
//  healthAndBeautyUser
//
//  Created by  on 2017/8/17.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class Wx_baseNaviViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.isHidden = true
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.childViewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
}

//@页面重写
extension UINavigationController {
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
//        self.navigationBar.isHidden = false
    }
}
