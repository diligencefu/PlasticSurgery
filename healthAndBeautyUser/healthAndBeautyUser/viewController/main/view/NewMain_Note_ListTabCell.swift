//
//  NewMain_Note_ListTabCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/9/25.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewMain_Note_ListTabCell:  Wx_baseTableViewCell {
    
    private var _model : NewNoteDetail_2Model_Articles?
    var model : NewNoteDetail_2Model_Articles? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    var tmp = [UIImageView]()

    private func didSetModel(_ model: NewNoteDetail_2Model_Articles) {
        
        date.text = model.title
        
        //日记内容尺寸
        let size = getSizeOnString(model.content, 14)
        detail.text = model.content
        _ = detail.sd_layout()?
            .topSpaceToView(date,GET_SIZE * 24)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 700)?
            .heightIs(size.height + 5)
        
        //移除所有数据
        for sub in imgView.subviews {
            sub.removeFromSuperview()
        }
        tmp.removeAll()
        // 中文逗号  不是英文逗号

        var x = model.imageList.count / 3   //行数
        if model.imageList.count == 3 ||  model.imageList.count == 6 ||  model.imageList.count == 9 {
            x -= 1
        }
        _ = imgView.sd_layout()?
            .topSpaceToView(detail,GET_SIZE * 14)?
            .leftSpaceToView(contentView,GET_SIZE * 28)?
            .rightSpaceToView(contentView,GET_SIZE * 28)?
            .heightIs(GET_SIZE * CGFloat(176 * (x + 1) + 16 * x))
        
        for index in 0..<model.imageList.count {
            
            let img = UIImageView()
            img.tag = 900 + index
            img.kf.setImage(with: URL.init(string: model.imageList[index]))
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
        
        _ = line.sd_layout()?
            .topSpaceToView(imgView,GET_SIZE * 18)?
            .leftSpaceToView(contentView,0)?
            .widthIs(WIDTH)?
            .heightIs(0.5)
        
        watchLab.text = "浏览 · \(model.hits)"
        commentLab.text = "评论 · \(model.comments)"
        upLab.text = "赞 · \(model.thumbs)"
        
        _ = watchView.sd_layout()?
            .topSpaceToView(line,0)?
            .leftSpaceToView(contentView,0)?
            .widthIs(WIDTH/3)?
            .heightIs(GET_SIZE * 80)
        
        _ = commentView.sd_layout()?
            .topSpaceToView(line,0)?
            .leftSpaceToView(contentView,WIDTH/3)?
            .widthIs(WIDTH/3)?
            .heightIs(GET_SIZE * 80)
        
        _ = upView.sd_layout()?
            .topSpaceToView(line,0)?
            .rightSpaceToView(contentView,0)?
            .widthIs(WIDTH/3)?
            .heightIs(GET_SIZE * 80)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        buildUI()
    }
    
    let date = UILabel()
    
    let detail = UILabel()
    
    var imgView = UIView()//9宫格图像载体
    
    let line = UIView()
    
    let watchView = UIView()//浏览数
    let watchIMG = UIImageView()
    let watchLab = UILabel()
    
    let commentView = UIView()//评论数
    let commentIMG = UIImageView()
    let commentLab = UILabel()
    
    let upView = UIView()//赞数
    let upIMG = UIImageView()
    let upLab = UILabel()
    
    let lineView = UIView()
    
    let Vline1 = UIView()
    let Vline2 = UIView()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildUI() {
        
        #if DEBUG
            date.text = "术后第7天"
            detail.text = "金坷垃，种庄稼，不流失不蒸发，吸收5米以下氮磷钾，亩产1800，8000名美国特种兵日夜守候，美国上帝压狗。。金坷垃，种庄稼，不流失不蒸发，吸收5米以下氮磷钾，亩产1800，8000名美国特种兵日夜守候，美国上帝压狗。。金坷垃，种庄稼，不流失不蒸发，吸收5米以下氮磷钾，亩产1800，8000名美国特种兵日夜守候，美国上帝压狗。。金坷垃，种庄稼，不流失不蒸发，吸收5米以下氮磷钾，亩产1800，8000名美国特种兵日夜守候，美国上帝压狗"
        #endif
        
        date.textColor = UIColor.white
        date.backgroundColor = redText
        date.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        date.textAlignment = .center
        contentView.addSubview(date)
        _ = date.sd_layout()?
            .topSpaceToView(contentView,GET_SIZE * 24)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 210)?
            .heightIs(GET_SIZE * 48)
        viewRadius(date, Float(date.height/2), 0.5, redText)
        
        //日记内容尺寸
        detail.textColor = darkText
        detail.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        detail.textAlignment = .left
        contentView.addSubview(detail)
        _ = detail.sd_layout()?
            .topSpaceToView(date,GET_SIZE * 24)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 700)?
            .heightIs(GET_SIZE * 120)
        detail.numberOfLines = 3//最高3行
        detail.lineBreakMode = .byCharWrapping
        
        contentView.addSubview(imgView)
        _ = imgView.sd_layout()?
            .topSpaceToView(detail,GET_SIZE * 14)?
            .leftSpaceToView(contentView,GET_SIZE * 28)?
            .rightSpaceToView(contentView,GET_SIZE * 28)?
            .heightIs(GET_SIZE * (176 * 3 + 16 * 2))
        
        // 9宫格
        for index in 0..<9 {
            
            let img = UIImageView()
            #if DEBUG
                img.image = UIImage(named:"image_icon_1_default")
            #endif
            
            let x = index / 3   //行数
            let y = index % 3   //列数
            
            imgView.addSubview(img)
            _ = img.sd_layout()?
                .leftSpaceToView(imgView,GET_SIZE * CGFloat(x * (220+16)))?
                .topSpaceToView(imgView,GET_SIZE * CGFloat(y * (176+12)))?
                .widthIs(GET_SIZE * 220)?
                .heightIs(GET_SIZE * 176)
        }
        
        line.backgroundColor = lineColor
        contentView.addSubview(line)
        _ = line.sd_layout()?
            .topSpaceToView(imgView,GET_SIZE * 18)?
            .leftSpaceToView(contentView,0)?
            .widthIs(WIDTH)?
            .heightIs(0.5)
        
        //
        //        let watchView = UIView()//浏览数
        //        let watchIMG = UIImageView()
        //        let watchLab = UILabel()
        //
        //        let commentView = UIView()//评论数
        //        let commentIMG = UIImageView()
        //        let commentLab = UILabel()
        //
        //        let upView = UIView()//赞数
        //        let upIMG = UIImageView()
        //        let upLab = UILabel()
        // 三组按钮
        #if DEBUG
            watchLab.text = "浏览 * 99万+"
            commentLab.text = "评论 * 99万+"
            upLab.text = "赞 * 99万+"
        #endif
        contentView.addSubview(watchView)
        _ = watchView.sd_layout()?
            .topSpaceToView(line,0)?
            .leftSpaceToView(contentView,0)?
            .widthIs(WIDTH/3)?
            .heightIs(GET_SIZE * 80)
        
        watchIMG.image = UIImage(named:"24_browse_icon_default")
        watchView.addSubview(watchIMG)
        _ = watchIMG.sd_layout()?
            .centerYEqualToView(watchView)?
            .leftSpaceToView(watchView,GET_SIZE * 40)?
            .widthIs(GET_SIZE * 24)?
            .heightIs(GET_SIZE * 20)
        
        watchLab.textColor = lightText
        watchLab.font = UIFont.systemFont(ofSize: GET_SIZE * 22)
        watchLab.textAlignment = .center
        watchView.addSubview(watchLab)
        _ = watchLab.sd_layout()?
            .centerYEqualToView(watchView)?
            .leftSpaceToView(watchIMG,GET_SIZE * 15)?
            .rightSpaceToView(watchView,GET_SIZE * 35)?
            .heightIs(GET_SIZE * 30)
        
        
        contentView.addSubview(commentView)
        _ = commentView.sd_layout()?
            .topSpaceToView(line,0)?
            .leftSpaceToView(contentView,WIDTH/3)?
            .widthIs(WIDTH/3)?
            .heightIs(GET_SIZE * 80)
        
        commentIMG.image = UIImage(named:"25_comment_icon_default")
        commentView.addSubview(commentIMG)
        _ = commentIMG.sd_layout()?
            .centerYEqualToView(commentView)?
            .leftSpaceToView(commentView,GET_SIZE * 40)?
            .widthIs(GET_SIZE * 24)?
            .heightIs(GET_SIZE * 20)
        
        commentLab.textColor = lightText
        commentLab.font = UIFont.systemFont(ofSize: GET_SIZE * 22)
        commentLab.textAlignment = .center
        commentView.addSubview(commentLab)
        _ = commentLab.sd_layout()?
            .centerYEqualToView(commentView)?
            .leftSpaceToView(commentIMG,GET_SIZE * 15)?
            .rightSpaceToView(commentView,GET_SIZE * 35)?
            .heightIs(GET_SIZE * 30)
        
        
        contentView.addSubview(upView)
        _ = upView.sd_layout()?
            .topSpaceToView(line,0)?
            .rightSpaceToView(contentView,0)?
            .widthIs(WIDTH/3)?
            .heightIs(GET_SIZE * 80)
        
        upIMG.image = UIImage(named:"23_appreciate_icon_pressed")
        upView.addSubview(upIMG)
        _ = upIMG.sd_layout()?
            .centerYEqualToView(upView)?
            .leftSpaceToView(upView,GET_SIZE * 40)?
            .widthIs(GET_SIZE * 24)?
            .heightIs(GET_SIZE * 20)
        
        upLab.textColor = lightText
        upLab.font = UIFont.systemFont(ofSize: GET_SIZE * 22)
        upLab.textAlignment = .center
        upView.addSubview(upLab)
        _ = upLab.sd_layout()?
            .centerYEqualToView(upView)?
            .leftSpaceToView(upIMG,GET_SIZE * 15)?
            .rightSpaceToView(upView,GET_SIZE * 35)?
            .heightIs(GET_SIZE * 30)
        
        lineView.backgroundColor = lineColor
        contentView.addSubview(lineView)
        _ = lineView.sd_layout()?
            .bottomEqualToView(contentView)?
            .leftSpaceToView(contentView,0)?
            .widthIs(WIDTH)?
            .heightIs(10)
        
        Vline1.backgroundColor = lineColor
        contentView.addSubview(Vline1)
        _ = Vline1.sd_layout()?
            .centerYEqualToView(watchView)?
            .leftSpaceToView(watchView,0)?
            .widthIs(1)?
            .heightIs(GET_SIZE * 28)
        
        Vline2.backgroundColor = lineColor
        contentView.addSubview(Vline2)
        _ = Vline2.sd_layout()?
            .centerYEqualToView(commentView)?
            .leftSpaceToView(commentView,0)?
            .widthIs(1)?
            .heightIs(GET_SIZE * 28)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc private func click(_ tap: UITapGestureRecognizer) {
        
        var itemArr = [KSPhotoItem]()
        
        for index in 0..<tmp.count {
            
            let watchIMGItem = KSPhotoItem.init(sourceView: tmp[index], image: tmp[index].image)
            itemArr.append(watchIMGItem!)
        }
        
        let watchIMGView = KSPhotoBrowser.init(photoItems: itemArr,
                                               selectedIndex: UInt((tap.view?.tag)! - 900))
        watchIMGView?.dismissalStyle = .scale
        watchIMGView?.backgroundStyle = .blurPhoto
        watchIMGView?.loadingStyle = .indeterminate
        watchIMGView?.pageindicatorStyle = .text
        watchIMGView?.bounces = false
        watchIMGView?.show(from: viewController()!)
    }
}
