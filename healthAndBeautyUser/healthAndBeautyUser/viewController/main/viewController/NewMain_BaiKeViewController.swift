//
//  NewMain_BaiKeViewController.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/21.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewMain_BaiKeViewController: Wx_baseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildNavi()
        buildUI()
    }
    
    private func buildUI() {

        let baikeView = Wx_twoTableView()
        view.addSubview(baikeView)
        _ = baikeView.sd_layout()?
            .topSpaceToView(naviView,0)?
            .leftSpaceToView(view,0)?
            .rightSpaceToView(view,0)?
            .bottomSpaceToView(view,0)
        baikeView.reBuildData()
        weak var weakSelf = self
        baikeView.callBackBlock { (id, name) in
            
            let tmp = NewMain_BaiKe_DetailViewController()
            tmp.id = id
            tmp.name = name
            weakSelf?.navigationController?.pushViewController(tmp, animated: true)
        }
    }
    
    private func buildNavi() {
        
        let naviView = UIView.init(frame: CGRect(x: 0, y: 0, width: WIDTH, height: 64))
        naviView.backgroundColor = UIColor.white
        view.addSubview(naviView)
        
        let title = UIImageView()
        title.image = UIImage(named:"01_zhengxingbaike_font_default")
        naviView.addSubview(title)
        _ = title.sd_layout()?
            .topSpaceToView(naviView,20)?
            .centerXEqualToView(naviView)?
            .widthIs(100)?
            .heightIs(44)
        
        let btn = buildLeftBtn()
        naviView.addSubview(btn)
        _ = btn.sd_layout()?
            .centerYEqualToView(title)?
            .leftSpaceToView(naviView,0)?
            .widthIs(44)?
            .heightIs(44)
        
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
