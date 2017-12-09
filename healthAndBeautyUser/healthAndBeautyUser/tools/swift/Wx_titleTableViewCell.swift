//
//  Wx_titleTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/21.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class Wx_titleTableViewCell: Wx_baseTableViewCell {
    
    private var _model : Wx_twoTableModel?
    var model : Wx_twoTableModel? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    private func didSetModel(_ model: Wx_twoTableModel) {
        
        title.text = model.name
    }
    
    let title = UILabel()
    let line = UIView()
    let rightLine = UIView()
    let leftView = UIView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = Wx_backColor
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildUI() {
        
        leftView.backgroundColor = Wx_selectColor
        contentView.addSubview(leftView)
        _ = leftView.sd_layout()?
            .leftSpaceToView(contentView,0)?
            .topSpaceToView(contentView,0)?
            .widthIs(4)?
            .bottomSpaceToView(contentView,0)
        leftView.alpha = 0
        
        title.textColor = Wx_darkText
        title.font = UIFont.systemFont(ofSize: GET_SIZE * 26)
        title.textAlignment = .center
        contentView.addSubview(title)
        _ = title.sd_layout()?
            .centerYEqualToView(contentView)?
            .centerYEqualToView(contentView)?
            .widthIs(Wx_leftWidth)?
            .heightIs(contentView.height)
        
        line.backgroundColor = Wx_lineColor
        contentView.addSubview(line)
        _ = line.sd_layout()?
            .bottomSpaceToView(contentView,0)?
            .leftSpaceToView(contentView,0)?
            .widthIs(contentView.width)?
            .heightIs(0.5)
        
        rightLine.backgroundColor = Wx_lineColor
        contentView.addSubview(rightLine)
        _ = rightLine.sd_layout()?
            .topSpaceToView(contentView,0)?
            .rightSpaceToView(contentView,0)?
            .widthIs(0.5)?
            .heightIs(contentView.height)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            
            leftView.alpha = 1
            backgroundColor = Wx_selectBackColor
            rightLine.alpha = 0
            
        }else {
            
            leftView.alpha = 0
            backgroundColor = Wx_backColor
            rightLine.alpha = 1
        }
    }
}
