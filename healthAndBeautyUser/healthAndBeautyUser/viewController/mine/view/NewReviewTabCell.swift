//
//  NewReviewTabCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/10/25.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewReviewTabCell: NewMainNoteListTabCell {
    
    private var _reviewingModel : NewMineReviewingModel?
    var reviewingModel : NewMineReviewingModel? {
        didSet {
            _reviewingModel = reviewingModel
            self.didSetReviewingModel(reviewingModel!)
        }
    }
    private func didSetReviewingModel(_ model: NewMineReviewingModel) {
        
        head.kf.setImage(with: StringToUTF_8InUrl(str: model.photo))
        name.text = model.nickName
        time.text = model.title
        
        if model.auditState == "0" {
            stateLab.text = "审核中"
        }else if model.auditState == "2" {
            stateLab.text = "审核失败"
        }
        
        //日记内容尺寸
        let size = getSizeOnString(model.content, 14)
        detail.text = model.content
        _ = detail.sd_layout()?
            .topSpaceToView(head,GET_SIZE * 24)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 700)?
            .heightIs(size.height + 5)
        
        //移除所有数据
        for sub in imgView.subviews {
            sub.removeFromSuperview()
        }
        tmp.removeAll()
        // 中文逗号  不是英文逗号
        
        var x = model.images.count / 3   //行数
        if model.images.count == 3 ||  model.images.count == 6 ||  model.images.count == 9 {
            x -= 1
        }
        _ = imgView.sd_layout()?
            .topSpaceToView(detail,GET_SIZE * 14)?
            .leftSpaceToView(contentView,GET_SIZE * 28)?
            .rightSpaceToView(contentView,GET_SIZE * 28)?
            .heightIs(GET_SIZE * CGFloat(176 * (x + 1) + 16 * x))
        
        for index in 0..<model.images.count {
            
            let img = UIImageView()
            img.tag = 900 + index
            img.kf.setImage(with: URL.init(string: model.images[index]))
            img.contentMode = .scaleAspectFill
            img.layer.masksToBounds = true
            let x = index / 3   //行数
            let y = index % 3   //列数
            
            imgView.addSubview(img)
            _ = img.sd_layout()?
                .leftSpaceToView(imgView,GET_SIZE * CGFloat(y * (220+16)))?
                .topSpaceToView(imgView,GET_SIZE * CGFloat(x * (176+12)))?
                .widthIs(GET_SIZE * 220)?
                .heightIs(GET_SIZE * 176)
            
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(click(_:)))
            img.addGestureRecognizer(tap)
            img.isUserInteractionEnabled = true
            tmp.append(img)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    let stateLab = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        rebuildUI()
    }
    
    private func rebuildUI() {
        
        //移除多余的部分
        watchView.removeFromSuperview()
        watchIMG.removeFromSuperview()
        watchLab.removeFromSuperview()
        commentView.removeFromSuperview()
        commentIMG.removeFromSuperview()
        commentLab.removeFromSuperview()
        upView.removeFromSuperview()
        upIMG.removeFromSuperview()
        upLab.removeFromSuperview()
        lineView.removeFromSuperview()
        Vline1.removeFromSuperview()
        Vline2.removeFromSuperview()
        tagView.removeFromSuperview()
        tagLabel.removeFromSuperview()
        
        //状态标签
        stateLab.textColor = tabbarColor
        stateLab.textAlignment = .right
        stateLab.font = UIFont.systemFont(ofSize: GET_SIZE * 34)
        contentView.addSubview(stateLab)
        _ = stateLab.sd_layout()?
            .centerYEqualToView(head)?
            .rightSpaceToView(contentView,GET_SIZE * 44)?
            .widthIs(WIDTH/3)?
            .heightIs(GET_SIZE * 30)
        
        _ = line.sd_layout()?
            .bottomSpaceToView(contentView,0)?
            .leftSpaceToView(contentView,0)?
            .widthIs(WIDTH)?
            .heightIs(0.5)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
