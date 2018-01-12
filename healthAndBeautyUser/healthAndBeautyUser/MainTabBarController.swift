//
//  MainTabBarController.swift
//  PlasticSurgery
//
//  Created by RongXing on 2017/9/20.
//  Copyright © 2017年 RongXing. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    
    var messageVC  = NewMainViewController()
    var contactVC  = NewStoreViewController()
    var diaryVC    = NewNoteViewController()
    var orderVC    = NewQuestionViewController()
    var personalVC = NewMineViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildCOntrollers()
    }
    
    func addChildCOntrollers() {
//        消息
        messageVC.tabBarItem = UITabBarItem.init(title: "首页", image: UIImage.init(named: "27_home_icon_default"), selectedImage: UIImage.init(named: "28_home_icon_pressed"))
        messageVC.tabBarItem.tag = 0
        messageVC.tabBarItem.accessibilityIdentifier = "messageVC"
        selectedTapTabBarItems(tabBarItem: messageVC.tabBarItem)
        unSelectedTapTabBarItems(tabBarItem: messageVC.tabBarItem)
        let Nav0 = Wx_baseNaviViewController.init(rootViewController: messageVC)
        
//        联系人
        contactVC.tabBarItem = UITabBarItem.init(title: "商城", image: UIImage.init(named: "29_shop_icon_default"), selectedImage: UIImage.init(named: "30_shop_icon_pressed"))
        contactVC.tabBarItem.tag = 1
        contactVC.tabBarItem.accessibilityIdentifier = "contactVC"
        selectedTapTabBarItems(tabBarItem: contactVC .tabBarItem)
        unSelectedTapTabBarItems(tabBarItem: contactVC.tabBarItem)
        let Nav1 = Wx_baseNaviViewController.init(rootViewController: contactVC)

//        日记
        diaryVC.tabBarItem = UITabBarItem.init(title: "日记本", image: UIImage.init(named: "31_diary_icon_default"), selectedImage: UIImage.init(named: "32_diary_icon_pressed"))
        diaryVC.tabBarItem.tag = 2
        diaryVC.tabBarItem.accessibilityIdentifier = "diaryVC"
        selectedTapTabBarItems(tabBarItem: diaryVC.tabBarItem)
        unSelectedTapTabBarItems(tabBarItem: diaryVC.tabBarItem)
        let Nav2 = Wx_baseNaviViewController.init(rootViewController: diaryVC)

////        订单
//        orderVC.tabBarItem = UITabBarItem.init(title: "问医生", image: UIImage.init(named: "33_Consultation_icon_default"), selectedImage: UIImage.init(named: "34_Consultation_icon_pressed"))
//        orderVC.tabBarItem.tag = 3
//        orderVC.tabBarItem.accessibilityIdentifier = "orderVC"
//        selectedTapTabBarItems(tabBarItem: orderVC.tabBarItem)
//        unSelectedTapTabBarItems(tabBarItem: orderVC.tabBarItem)
//        let Nav3 = Wx_baseNaviViewController.init(rootViewController: orderVC)

//        我的
        personalVC.tabBarItem = UITabBarItem.init(title: "我的", image: UIImage.init(named: "35_my_icon_default"), selectedImage: UIImage.init(named: "36_my_icon_pressed"))
        personalVC.tabBarItem.tag = 4
        personalVC.tabBarItem.accessibilityIdentifier = "personalVC"
        selectedTapTabBarItems(tabBarItem: personalVC.tabBarItem)
        unSelectedTapTabBarItems(tabBarItem: personalVC.tabBarItem)
        let Nav4 = Wx_baseNaviViewController.init(rootViewController: personalVC)
        
//        personalVC.tabBarItem.badgeValue = "64"
        self.tabBarController?.tabBar.barTintColor = kMainColor()
                
        self.viewControllers = [Nav0,Nav1,Nav2,Nav4]
        self.selectedIndex = 0
    }
    
    func unSelectedTapTabBarItems(tabBarItem:UITabBarItem) {
        tabBarItem.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 12),NSForegroundColorAttributeName:UIColor.lightGray], for: .normal);
    }
    
    
    func selectedTapTabBarItems(tabBarItem:UITabBarItem) {
        
        tabBarItem.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 12),NSForegroundColorAttributeName:kMainColor()], for: .selected);
        
    }
}
