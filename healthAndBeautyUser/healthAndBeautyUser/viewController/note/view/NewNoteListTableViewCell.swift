//
//  NewNoteListTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/25.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewNoteListTableViewCell: Wx_baseTableViewCell {
    
    private var _model : NewNoteListModel?
    var model : NewNoteListModel? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    
    private func didSetModel(_ model: NewNoteListModel) {
        
        detail.text = model.title
        count.text = "共有\(model.count)日记"
        
        if model.isAllowWrite {
            count.textColor = kGaryColor(num: 220)
        }else{
            count.textColor = kMainColor()
        }
        
        if model.isAllowWrite {
            count.textColor = tabbarColor
        }
    }
    
    let icon = UIImageView()
    let detail = UILabel()
    let count = UILabel()
    let enter = UIImageView()
    
    let bottomView = UIView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildUI() {
        
        icon.image = UIImage(named:"DiaryIcon_icon_default")
        contentView.addSubview(icon)
        _ = icon.sd_layout()?
            .topSpaceToView(contentView,GET_SIZE * 24)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 64)?
            .heightIs(GET_SIZE * 64)
        
        detail.textColor = lightText
        detail.font = UIFont.systemFont(ofSize: GET_SIZE * 32)
        detail.textAlignment = .left
        contentView.addSubview(detail)
        _ = detail.sd_layout()?
            .centerYEqualToView(icon)?
            .leftSpaceToView(icon,GET_SIZE * 24)?
            .widthIs(WIDTH/2)?
            .heightIs(GET_SIZE * 34)
        
        enter.image = UIImage(named:"00_go_icon_default")
        contentView.addSubview(enter)
        _ = enter.sd_layout()?
            .centerYEqualToView(icon)?
            .rightSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 10)?
            .heightIs(GET_SIZE * 15)
        
        count.textColor = tabbarColor
        count.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        count.textAlignment = .right
        contentView.addSubview(count)
        _ = count.sd_layout()?
            .centerYEqualToView(icon)?
            .rightSpaceToView(enter,GET_SIZE * 12)?
            .widthIs(WIDTH/2)?
            .heightIs(GET_SIZE * 32)
        
        bottomView.backgroundColor = lineColor
        contentView.addSubview(bottomView)
        _ = bottomView.sd_layout()?
            .bottomSpaceToView(contentView,0)?
            .leftSpaceToView(contentView,0)?
            .widthIs(WIDTH)?
            .heightIs(10)
    }
}
