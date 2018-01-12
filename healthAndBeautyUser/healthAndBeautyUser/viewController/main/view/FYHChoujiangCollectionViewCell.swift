//
//  FYHChoujiangCollectionViewCell.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/20.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SnapKit

class FYHChoujiangCollectionViewCell: UICollectionViewCell {
    var luckView = LuckView()
    
    
    @IBOutlet weak var luckBgView: UIView!
    
//    @IBOutlet weak var luckView: LuckView!
    var beginLuckBlock:(()->())?  //声明闭包
    var finishLuckBlock:((String)->())?  //声明闭包

    override func awakeFromNib() {
        super.awakeFromNib()
        
        luckBgView.snp.updateConstraints { (ls) in
            ls.top.equalToSuperview().offset(10)
            ls.leading.equalToSuperview().offset(10)
            ls.width.equalTo(kSCREEN_WIDTH-20)
            ls.height.equalTo(kSCREEN_WIDTH-20)
//            ls.centerX.equalToSuperview()
        }
        
        luckView = LuckView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH-20, height: kSCREEN_WIDTH-20))
        
        //        抽奖结果回调
        luckView.getLuckResult { (index) in
            if self.finishLuckBlock != nil {
                self.finishLuckBlock!(String(index))
            }
        }
        //        点击开始抽奖
        luckView.beginLuck = {_ in
            if self.beginLuckBlock != nil {
                self.beginLuckBlock!()
            }
        }
        
        luckBgView.addSubview(luckView)
        
        luckView.snp.updateConstraints { (ls) in
//            ls.top.equalToSuperview()
//            ls.leading.equalToSuperview()
            ls.width.equalTo(kSCREEN_WIDTH-20)
            ls.height.equalTo(kSCREEN_WIDTH-20)
            ls.center.equalToSuperview()
        }

    }
    
    @IBAction func showMyAward(_ sender: UIButton) {
        viewController()?.navigationController?.pushViewController(FYHShowMyAwardViewController(), animated: true)
    }
    
    func beginLuckAction(index:Int32) {
        self.luckView.stopCount = index
        self.luckView.startDrawLotteryRaffle()
    }
    
    func setImagesForLuck(images:NSMutableArray) {
        luckView.imageArray = images
    }


}
