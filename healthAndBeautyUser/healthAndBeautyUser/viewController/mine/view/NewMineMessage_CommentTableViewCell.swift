//
//  newMineMessage_CommentTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/17.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewMineMessage_CommentTableViewCell: Wx_baseTableViewCell {
    
    private var _model : NewMineMessageCommentModel?
    var model : NewMineMessageCommentModel? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    
    private func didSetModel(_ model: NewMineMessageCommentModel) {
        
        head.image = UIImage(named:model.head)
        
        time.text = model.time
        detail.text = model.detail
        name.text = model.name
        repeatLab.text = model.repeatComment
    }
    
    let head = UIImageView()
    let name = UILabel()
    let time = UILabel()
    let repeatBtn = UIButton()

    let detail = UILabel()
    let repeatLab = UILabel()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func buildUI() {
        
        contentView.addSubview(head)
        _ = head.sd_layout()?
            .topSpaceToView(contentView,GET_SIZE * 24)?
            .leftSpaceToView(contentView,GET_SIZE * 44)?
            .widthIs(GET_SIZE * 88)?
            .heightIs(GET_SIZE * 88)
        viewRadius(head, Float(head.width/2), 0.5, UIColor.black)
        
        name.textColor = UIColor.blue
        name.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        name.textAlignment = .left
        contentView.addSubview(name)
        _ = name.sd_layout()?
            .topSpaceToView(contentView,GET_SIZE * 24)?
            .leftSpaceToView(head,GET_SIZE * 24)?
            .widthIs(WIDTH/2)?
            .heightIs(GET_SIZE * 30)
        
        time.textColor = UIColor.blue
        time.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        time.textAlignment = .left
        contentView.addSubview(time)
        _ = time.sd_layout()?
            .topSpaceToView(name,4)?
            .leftSpaceToView(head,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 180)?
            .heightIs(GET_SIZE * 30)
        
        //关注
        repeatBtn.setTitle("回复", for: .normal)
        repeatBtn.backgroundColor = backGroundColor
        repeatBtn.setTitleColor(getColorWithNotAlphe(0xF1931A), for: .normal)
        repeatBtn.titleLabel?.font = UIFont.systemFont(ofSize: GET_SIZE * 32)
        viewRadius(repeatBtn, 5.0, 0.5, UIColor.lightGray)
        contentView.addSubview(repeatBtn)
        _ = repeatBtn.sd_layout()?
            .centerYEqualToView(head)?
            .rightSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 150)?
            .heightIs(GET_SIZE * 64)
        
        detail.textColor = UIColor.black
        detail.numberOfLines = 2
        detail.lineBreakMode = .byCharWrapping
        detail.font = UIFont.systemFont(ofSize: GET_SIZE * 26)
        contentView.addSubview(detail)
        _ = detail.sd_layout()?
            .topSpaceToView(head,4)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .rightSpaceToView(contentView,GET_SIZE * 24)?
            .heightIs(GET_SIZE * 70)
        
        repeatLab.textColor = UIColor.black
        repeatLab.numberOfLines = 2
        repeatLab.lineBreakMode = .byCharWrapping
        repeatLab.font = UIFont.systemFont(ofSize: GET_SIZE * 26)
        contentView.addSubview(repeatLab)
        _ = repeatLab.sd_layout()?
            .topSpaceToView(detail,4)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .rightSpaceToView(contentView,GET_SIZE * 24)?
            .heightIs(GET_SIZE * 70)
        
        let line = UIView()
        line.backgroundColor = lineColor
        contentView.addSubview(line)
        _ = line.sd_layout()?
            .bottomSpaceToView(contentView,0)?
            .leftSpaceToView(contentView,0)?
            .widthIs(WIDTH)?
            .heightIs(1)
    }
}
