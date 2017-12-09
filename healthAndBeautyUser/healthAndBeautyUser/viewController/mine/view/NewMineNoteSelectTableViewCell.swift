//
//  newMineNoteSelectTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/16.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewMineNoteSelectTableViewCell: Wx_baseTableViewCell {
    
    let head = UIImageView()
    let name = UILabel()
    let time = UILabel()
    
    let select = UIImageView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildUI() {
        
        //图像
        contentView.addSubview(head)
        _ = head.sd_layout()?
            .topSpaceToView(contentView,GET_SIZE * 24)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 90)?
            .heightIs(GET_SIZE * 90)
        viewRadius(head, Float(head.width/2), 0.5, UIColor.black)
        
        //标签
        name.textColor = UIColor.black
        name.numberOfLines = 0
        name.font = UIFont.systemFont(ofSize: GET_SIZE * 30)
        contentView.addSubview(name)
        _ = name.sd_layout()?
            .topSpaceToView(contentView,GET_SIZE * 32)?
            .leftSpaceToView(head,GET_SIZE * 24)?
            .widthIs(WIDTH/2)?
            .heightIs(GET_SIZE * 30)
        
        //时间
        time.textColor = UIColor.black
        time.font = UIFont.systemFont(ofSize: GET_SIZE * 22)
        contentView.addSubview(time)
        _ = time.sd_layout()?
            .topSpaceToView(name,GET_SIZE * 14)?
            .leftSpaceToView(head,GET_SIZE * 24)?
            .widthIs(WIDTH/2)?
            .heightIs(GET_SIZE * 24)
        
        contentView.addSubview(select)
        _ = select.sd_layout()?
            .topSpaceToView(contentView,GET_SIZE * 24)?
            .rightSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 30)?
            .heightIs(GET_SIZE * 30)
    }
    
    func buildData() {
        
        
        
    }
}
