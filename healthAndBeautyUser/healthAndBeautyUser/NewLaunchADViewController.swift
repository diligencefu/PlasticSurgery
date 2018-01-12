//
//  NewLaunchADViewController.swift
//  healthAndBeautyUser
//
//  Created by 丿番茄 on 2017/11/17.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewLaunchADViewController: UIViewController,UIWebViewDelegate {
    
    var isLoginPresent = false
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
//        if isLoginPresent {
        
            buildTabbar()
//        }else{
//
//            let web = UIWebView()
//            web.backgroundColor = UIColor.white
//            web.scrollView.isScrollEnabled = false
//            web.frame = CGRect.init(x: 0, y: 0, width: WIDTH, height: HEIGHT)
//            web.delegate = self
//            let url = URL.init(string: "http://192.168.1.172:8020/test/guidePage/guidePage.html?__hbt=1510896687287")
//            let request = URLRequest.init(url: url!)
//            web.loadRequest(request)
//            view.addSubview(web)
//
//            let time : TimeInterval = 3.0
//            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
//                self.buildTabbar()
//            }
//        }
        
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        let time : TimeInterval = 3.0
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
            self.buildTabbar()
        }
    }
    
    private func buildTabbar() {
        
        let viewClass: Array<UIViewController.Type> = [NewMainViewController.self,
                                                       NewStoreViewController.self,
                                                       NewNoteViewController.self,
                                                       NewQuestionViewController.self,
                                                       NewMineViewController.self]
        
        let dontSelectIMGArr = ["27_home_icon_default",
                                "29_shop_icon_default",
                                "31_diary_icon_default",
                                "33_Consultation_icon_default",
                                "35_my_icon_default"]
        let selectIMGArr =     ["28_home_icon_pressed",
                                "30_shop_icon_pressed",
                                "32_diary_icon_pressed",
                                "34_Consultation_icon_pressed",
                                "36_my_icon_pressed"]
        let title =            ["首页",
                                "商城",
                                "日记本",
                                "问医生",
                                "我的"]
        
        var viewController = [UIViewController]()
        
        for index in 0..<viewClass.count {
            
            let controller = viewClass[index].init()
            let rootControlller = Wx_baseNaviViewController(rootViewController: controller)
            
            let selectIMG = UIImage(named:selectIMGArr[index])
            selectIMG?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            let unSelectIMG = UIImage(named:dontSelectIMGArr[index])
            unSelectIMG?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            
            rootControlller.tabBarItem = UITabBarItem.init(title: title[index],
                                                           image: unSelectIMG,
                                                           selectedImage: selectIMG)
            viewController.append(rootControlller)
        }
        
        let tabbarController = UITabBarController()
        tabbarController.viewControllers = viewController
        tabbarController.selectedIndex = 0
        tabbarController.tabBar.tintColor = tabbarColor
        
        view.window?.rootViewController = tabbarController
        view.window?.makeKeyAndVisible()
    }
}

