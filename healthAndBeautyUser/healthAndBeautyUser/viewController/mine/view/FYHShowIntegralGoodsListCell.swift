//
//  FYHShowIntegralGoodsListCell.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/25.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class FYHShowIntegralGoodsListCell: UITableViewCell {

    @IBOutlet weak var cellName: UILabel!
    
    @IBOutlet weak var showAll: UIButton!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    
    var isShowMessage = Bool()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        showAll.setTitleColor(tabbarColor, for: .normal)
        cellName.font = UIFont.systemFont(ofSize: GET_SIZE * 32)

    }

    
    func layoutForMainList(isMessage:Bool) {
        
        isShowMessage = isMessage
        
        if isMessage {
            
            cellName.text = "消息"
            
            button1.setImage(#imageLiteral(resourceName: "comment"), for: .normal)
            button1.setTitle("评论", for: .normal)
            
            button2.setImage(#imageLiteral(resourceName: "fabulous"), for: .normal)
            button2.setTitle("赞", for: .normal)
            
            button3.setImage(#imageLiteral(resourceName: "fans"), for: .normal)
            button3.setTitle("新粉丝", for: .normal)
            
            button4.setImage(#imageLiteral(resourceName: "notice"), for: .normal)
            button4.setTitle("通知", for: .normal)
            
            
            button1.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 19, right: -30)
            button1.titleEdgeInsets = UIEdgeInsets(top: 27, left: -25, bottom: 0, right: 0)
            
            button2.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 19, right: -17)
            button2.titleEdgeInsets = UIEdgeInsets(top: 27, left: -25, bottom: 0, right: 0)
            
            button3.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 19, right: -45)
            button3.titleEdgeInsets = UIEdgeInsets(top: 27, left: -25, bottom: 0, right: 0)
            
            button4.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 19, right: -30)
            button4.titleEdgeInsets = UIEdgeInsets(top: 27, left: -25, bottom: 0, right: 0)
        }else{
            cellName.text = "积分订单"

            button1.setImage(#imageLiteral(resourceName: "pending payment"), for: .normal)
            button1.setTitle("待付款", for: .normal)
            
            button2.setImage(#imageLiteral(resourceName: "pending use"), for: .normal)
            button2.setTitle("待发货", for: .normal)
            
            button3.setImage(#imageLiteral(resourceName: "refund"), for: .normal)
            button3.setTitle("已发货", for: .normal)
            
            button4.setImage(#imageLiteral(resourceName: "commodity"), for: .normal)
            button4.setTitle("已完成", for: .normal)
            
            button1.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 19, right: -45)
            button1.titleEdgeInsets = UIEdgeInsets(top: 27, left: -32, bottom: 0, right: 0)
            button2.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 19, right: -45)
            button2.titleEdgeInsets = UIEdgeInsets(top: 27, left: -32, bottom: 0, right: 0)
            button3.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 19, right: -45)
            button3.titleEdgeInsets = UIEdgeInsets(top: 27, left: -32, bottom: 0, right: 0)
            button4.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 19, right: -45)
            button4.titleEdgeInsets = UIEdgeInsets(top: 27, left: -32, bottom: 0, right: 0)
            
        }
        
    }
    
    
    @IBAction func buttonAction(_ sender: UIButton) {
        
        if isShowMessage {
            let view = NewMineMessageViewController()
            view.topView.currentBtn = sender.tag-1230
            viewController()?.navigationController?.pushViewController(view, animated: true)
        }else{
            let view = FYHOrderForIntegralViewController()
            view.topView.currentBtn = sender.tag-1230
            viewController()?.navigationController?.pushViewController(view, animated: true)
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
