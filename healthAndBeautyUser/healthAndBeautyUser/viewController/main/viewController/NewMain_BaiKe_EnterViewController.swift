//
//  NewMain_BaiKe_EnterViewController.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/9/25.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import WebKit

class NewMain_BaiKe_EnterViewController: Wx_baseViewController {

    var id = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createNaviController(title: "百科详情", leftBtn: buildLeftBtn(), rightBtn: nil)
        
        let webView = WKWebView()
        view.addSubview(webView)
        _ = webView.sd_layout()?
            .topSpaceToView(naviView,0)?
            .leftSpaceToView(view,0)?
            .rightSpaceToView(view,0)?
            .bottomSpaceToView(view,0)
        
        let url = URL.init(string:"\(getProjectContentJoggle)?id=\(id)")
        let request = URLRequest.init(url: url!)
        webView.load(request)
    }
}
