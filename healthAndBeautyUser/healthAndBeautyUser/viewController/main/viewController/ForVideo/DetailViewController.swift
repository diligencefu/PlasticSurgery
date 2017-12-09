//
//  DetailViewController.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/12.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import ZFPlayer

class DetailViewController: UIViewController {

    var playModel = ZFPlayerModel()
    var playerView = ZFPlayerView()

    var playAction:((String)->())?  //声明闭包

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        let bgView = UIView.init(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 300))
        bgView.tag = 123456789
        bgView.backgroundColor = UIColor.brown
        self.view.addSubview(bgView)
        
        playModel.scrollView = nil
        playModel.fatherViewTag = bgView.tag
        playModel.fatherView = bgView
        playerView.playerControlView(nil, playerModel: playModel)
        playerView.autoPlayTheVideo()
//
//        if playAction != nil {
//            playAction!("stop")
//        }
        
        let description = UILabel.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        description.text = playModel.descrip
        description.textColor = UIColor.gray
        description.font = UIFont.systemFont(ofSize: 30)
        description.numberOfLines = 0
        self.view.addSubview(description)
        
        _ = bgView.sd_layout()?
            .topSpaceToView(bgView.superview,0)?
            .leftSpaceToView(bgView.superview,0)?
            .rightSpaceToView(bgView.superview,0)?
            .heightIs(274)
        

        _ = bgView.sd_layout()?
            .topSpaceToView(bgView,10)?
            .leftSpaceToView(bgView,5)?
            .rightSpaceToView(bgView,5)?
            .maxHeightIs(20)

        
//        bgView.snp.makeConstraints { (make) in
//            make.top.left.right.equalToSuperview()
//            make.height.equalTo(274)
//        }
        
//        description.snp.makeConstraints { (make) in
//            make.top.equalTo(bgView.snp.bottom).offset(10)
//            make.left.right.equalToSuperview().offset(5)
//            make.height.greaterThanOrEqualTo(20)
//        }
        
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        playerView.resetPlayer()
        
    }


}
