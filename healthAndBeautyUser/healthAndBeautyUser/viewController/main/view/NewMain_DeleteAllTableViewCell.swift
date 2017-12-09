//
//  NewMain_DeleteAllTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/22.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewMain_DeleteAllTableViewCell: Wx_baseTableViewCell {
    
    private var _model : NewMineMessageModel?
    var model : NewMineMessageModel? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    private func didSetModel(_ model: NewMineMessageModel) {
        
    }
    
    let title = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func buildUI() {
        
        title.text = "清除历史记录"
        title.textColor = darkText
        title.font = UIFont.systemFont(ofSize: GET_SIZE * 30)
        title.textAlignment = .center
        contentView.addSubview(title)
        _ = title.sd_layout()?
            .centerYEqualToView(contentView)?
            .centerXEqualToView(contentView)?
            .widthIs(GET_SIZE * 500)?
            .heightIs(GET_SIZE * 44)
    }
}
