//
//  VideoCell.swift
//  CorrectsPapers
//
//  Created by RongXing on 2017/10/11.
//  Copyright © 2017年 Fu Yaohui. All rights reserved.
//

import UIKit
import Kingfisher

class VideoCell: UITableViewCell {

    @IBOutlet weak var userIcon: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var pic: UIImageView!
    
    @IBOutlet weak var videoDescrip: UILabel!
    
    
    @IBOutlet weak var likeCount: UIButton!
    @IBOutlet weak var dislikeCount: UIButton!
    @IBOutlet weak var shareCount: UIButton!
    @IBOutlet weak var commentConut: UIButton!
    
    
    var playBtn = UIButton()
    var playAction:((UIButton)->())?  //声明闭包
    
    override func awakeFromNib() {
        super.awakeFromNib()

        userIcon.layer.cornerRadius = 20
        userIcon.clipsToBounds = true
        
        playBtn = UIButton.init(type: .custom)
        playBtn.setImage(#imageLiteral(resourceName: "video_list_cell_big_icon"), for: .normal)
        playBtn.addTarget(self, action: #selector(playActionss(sender:)), for: .touchUpInside)
        pic.addSubview(playBtn)
        pic.isUserInteractionEnabled = true
        
        _ = playBtn.sd_layout()?
            .centerXEqualToView(pic)?
            .centerYEqualToView(pic)?
            .widthIs(50)?
            .heightIs(50)

        
//        playBtn.snp.makeConstraints { (make) in
//            make.center.equalTo(pic.snp.center)
//            make.width.height.equalTo(50)
//        }
    }

    @objc func playActionss(sender:UIButton) {
        
        if playAction != nil {
            playAction!(sender)
        }
    }
    
    
    func assin(model:VideoModel) {
        pic.kf.setImage(with:  URL(string:model.coverForFeed)!, placeholder: #imageLiteral(resourceName: "loading_bgView1"), options: nil, progressBlock: nil, completionHandler: nil)
        titleLabel.text = "你付大爷啊"
        videoDescrip.text = model.title
        likeCount.setTitle(model.consumption.collectionCount, for: .normal)
        dislikeCount.setTitle(model.consumption.playCount, for: .normal)
        shareCount.setTitle(model.consumption.shareCount, for: .normal)
        commentConut.setTitle(model.consumption.replyCount, for: .normal)
        
    }

    
    
    @IBAction func chooseAction(_ sender: UIButton) {
  
        if sender.tag != 104 {
            if sender.isSelected {
                sender.isSelected = false
                sender.setTitle("\(NSInteger((sender.titleLabel?.text)!)!-1)", for: .normal)
                sender.setTitleColor(kSetRGBColor(r: 184, g: 184, b: 188), for: .normal)
            }else{
                sender.isSelected = true
                sender.setTitle("\(NSInteger((sender.titleLabel?.text)!)!+1)", for: .normal)
                sender.setTitleColor(kSetRGBColor(r: 231, g: 99, b: 52), for: .normal)
            }

        }else{
            setToast(str: "不想让你评论")
        }
        
        
    }
    
    
    
    
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
