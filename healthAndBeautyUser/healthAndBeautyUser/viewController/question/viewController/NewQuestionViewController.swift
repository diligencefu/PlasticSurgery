//
//  newQuestionViewController.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/11.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewQuestionViewController: Wx_baseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createNaviController(title: "问医生", leftBtn: nil, rightBtn: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let login = NewLoginLocationViewController.init(nibName: "NewLoginLocationViewController", bundle: nil)
        let loginVC = Wx_baseNaviViewController.init(rootViewController: login)
        self.present(loginVC, animated: true, completion: nil)
    }
}
