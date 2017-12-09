//
//  newMineMeViewController.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/17.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewMineMeViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildUI()
    }
    
    private func buildUI() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
}
