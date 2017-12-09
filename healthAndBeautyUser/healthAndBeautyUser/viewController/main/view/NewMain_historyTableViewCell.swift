//
//  NewMain_historyTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/22.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewMain_historyTableViewCell: Wx_baseTableViewCell {
    
    private var _model : String?
    var model : String? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    private func didSetModel(_ model: String) {
        
        title.text = model
    }
    
    let img = UIImageView()
    let title = UILabel()
    let btn = UIButton()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func buildUI() {
        
        contentView.addSubview(img)
        _ = img.sd_layout()?
            .centerYEqualToView(contentView)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 44)?
            .heightIs(GET_SIZE * 44)
        img.image = UIImage(named:"Selected")
        
        title.textColor = darkText
        title.font = UIFont.systemFont(ofSize: GET_SIZE * 30)
        title.textAlignment = .left
        contentView.addSubview(title)
        _ = title.sd_layout()?
            .centerYEqualToView(contentView)?
            .leftSpaceToView(img,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 500)?
            .heightIs(GET_SIZE * 44)
        
        btn.setImage(UIImage(named:"Selected"), for: .normal)
        btn.backgroundColor = backGroundColor
        contentView.addSubview(btn)
        _ = btn.sd_layout()?
            .centerYEqualToView(contentView)?
            .rightSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 49)?
            .heightIs(GET_SIZE * 49)
        
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
