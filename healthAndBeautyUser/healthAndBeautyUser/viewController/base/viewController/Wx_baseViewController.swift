//
//  wx_baseViewController.swift
//  healthAndBeautyUser
//
//  Created by  on 2017/8/11.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SDAutoLayout
import MJRefresh
import SwiftyJSON
import DeviceKit
import DZNEmptyDataSet

class Wx_baseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = true
        view.backgroundColor = backGroundColor
        
    }

    // 基本方法
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        SVPHide()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    //MARK: - provide
    //  MARK: - 警告框
    ///
    /// - Parameters: 值
    ///     - title    标题
    ///     - detail    详细注释
    ///     - controller    按钮状态
    func buildAlter(_ title : String, _ detail : String, _ controller : String) {
        
        let alert = UIAlertController.init(title: title, message: detail, preferredStyle: .alert)
        let alertAction = UIAlertAction.init(title: controller, style: .default) { (type) in
            self.alertController()
        }
        let cancelAction = UIAlertAction.init(title: "返回", style: .cancel, handler: nil)
        alert.addAction(alertAction)
        alert.addAction(cancelAction)
        _ = self.present(alert, animated: true, completion: nil)
    }
    func alertController() {
        delog("有需要重写alertController()")
    }
    
    //导航栏
    func buildLeftBtn() -> UIButton{
        
        let btn = UIButton.init()
        btn.setImage(UIImage(named:"02_back"), for: .normal)
        btn.addTarget(self, action: #selector(pop), for: .touchUpInside)
        btn.frame = CGRect.init(x: 0, y: 0, width: 44, height: 44)
        return btn
    }
    
    func buildRightBtnWithName(_ name: String) -> UIButton{
        
        let btn = UIButton()
        btn.setTitle(name, for: .normal)
        btn.setTitleColor(tabbarColor, for: .normal)
        btn.addTarget(self, action: #selector(rightClick), for: .touchUpInside)
        let framas = getSizeOnLabel(btn.titleLabel!)
        btn.frame = CGRect.init(x: 0, y: 0, width: framas.width, height: framas.height)
        return btn
    }
    
    func buildRightBtnWithIMG(_ img: UIImage) -> UIButton{
        
        let btn = UIButton()
        btn.setImage(img, for: .normal)
        btn.addTarget(self, action: #selector(rightClick), for: .touchUpInside)
        btn.frame = CGRect.init(x: 0, y: 0, width: 44, height: 44)
        return btn
    }
    
    func rightClick() {
        delog("rightBtn")
    }
    func pop() {
        if !((self.navigationController?.popViewController(animated: true)) != nil) {
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    let naviView = UIView.init(frame: CGRect(x: 0, y: 0, width: WIDTH, height: 64))
    func createNaviController(title: String, leftBtn: UIButton?, rightBtn: UIButton?) {
        
        //适配iphoneX
        if HEIGHT == 812 {
            naviView.frame = CGRect(x: 0, y: 0, width: WIDTH, height: 88)
        }
        
        naviView.backgroundColor = UIColor.white
        naviView.tag = 1099
        view.addSubview(naviView)
        
        let titleLabel = UILabel.init()
        titleLabel.text = title
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.darkText
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        let sizes = getSizeOnLabel(titleLabel)
        naviView.addSubview(titleLabel)
        _ = titleLabel.sd_layout()?
            .bottomSpaceToView(naviView,0)?
            .centerXEqualToView(naviView)?
            .widthIs(sizes.width)?
            .heightIs(44)
        
        if leftBtn != nil {
            
            naviView.addSubview(leftBtn!)
            _ = leftBtn!.sd_layout()?
                .centerYEqualToView(titleLabel)?
                .leftSpaceToView(naviView,0)?
                .widthIs((leftBtn?.width)!)?
                .heightIs((leftBtn?.height)!)
        }
        if rightBtn != nil {
            
            naviView.addSubview(rightBtn!)
            _ = rightBtn!.sd_layout()?
                .centerYEqualToView(titleLabel)?
                .rightSpaceToView(naviView,GET_SIZE * 24)?
                .widthIs((rightBtn?.width)!)?
                .heightIs((rightBtn?.height)!)
        }
        
        let line = UIView()
        line.backgroundColor = lineColor
        naviView.addSubview(line)
        _ = line.sd_layout()?
            .bottomSpaceToView(naviView,0)?
            .leftSpaceToView(naviView,0)?
            .widthIs(WIDTH)?
            .heightIs(0.5)
    }
    
    
}
