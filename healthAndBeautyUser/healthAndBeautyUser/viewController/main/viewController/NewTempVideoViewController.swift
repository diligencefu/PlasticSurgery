//
//  NewTempVideoViewController.swift
//  healthAndBeautyUser
//
//  Created by 丿番茄 on 2017/11/28.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import AVKit

class NewTempVideoViewController: Wx_baseViewController {

    @IBOutlet weak var video: UIView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        createNaviController(title: "视频播放", leftBtn: buildLeftBtn(), rightBtn: nil)
    }
    
    @IBAction func click(_ sender: UIButton) {
        
        //网站
        let url = URL.init(string: "http://59.110.154.239/im.mp4")
        //对象化网站
        let item = AVPlayerItem.init(url: url!)
        //创建一个播放器对象
        let player = AVPlayer.init(playerItem: item)
        //讲对象抽象为一个图层
        let layer = AVPlayerLayer.init(player: player)
        //设置尺寸
        layer.frame = CGRect.init(x: 0, y: 0, width: video.width, height: video.height)
        //添加到页面上
        video.layer.addSublayer(layer)
        //播放
        player.play()
    }
}
