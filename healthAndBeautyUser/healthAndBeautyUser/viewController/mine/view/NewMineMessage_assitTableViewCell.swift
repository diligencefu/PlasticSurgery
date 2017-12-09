//
//  newMineMessage_assitTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/17.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewMineMessage_assitTableViewCell: Wx_baseTableViewCell {
    
    private var _model : NewMineMessageAssitModel?
    var model : NewMineMessageAssitModel? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    
    private func didSetModel(_ model: NewMineMessageAssitModel) {
        
        head.image = UIImage(named:model.head)
        otherIMG.image = UIImage(named:"Selected")

        time.text = model.time
        detail.text = model.detail
        name.text = model.name
        other.text = "赞了你的评论"
    }
    
    let head = UIImageView()
    let name = UILabel()
    let time = UILabel()
    let other = UILabel()
    let otherIMG = UIImageView()
    let detail = UILabel()

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
            .widthIs(WIDTH/2)?
            .heightIs(GET_SIZE * 30)
        
        other.textColor = UIColor.blue
        other.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        other.textAlignment = .left
        contentView.addSubview(other)
        _ = other.sd_layout()?
            .topSpaceToView(head,GET_SIZE * 24)?
            .leftSpaceToView(head,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 180)?
            .heightIs(GET_SIZE * 30)
        
        contentView.addSubview(otherIMG)
        _ = otherIMG.sd_layout()?
            .centerYEqualToView(other)?
            .leftSpaceToView(other,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 30)?
            .heightIs(GET_SIZE * 30)
        
        detail.textColor = UIColor.blue
        detail.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        detail.textAlignment = .left
        detail.numberOfLines = 0
        detail.lineBreakMode = .byWordWrapping
        contentView.addSubview(detail)
        _ = detail.sd_layout()?
            .topSpaceToView(contentView,GET_SIZE * 24)?
            .bottomSpaceToView(contentView,GET_SIZE * 24)?
            .rightSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 180)
        
        let line = UIView()
        line.backgroundColor = lineColor
        contentView.addSubview(line)
        _ = line.sd_layout()?
            .bottomSpaceToView(contentView,0)?
            .leftSpaceToView(contentView,0)?
            .widthIs(WIDTH)?
            .heightIs(0.5)
    }
}
