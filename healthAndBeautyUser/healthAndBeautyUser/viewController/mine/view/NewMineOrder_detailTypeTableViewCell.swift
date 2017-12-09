//
//  NewMineOrder_detailTypeTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/24.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

//这个是订单详情上方显示当前订单状态的cell

import UIKit

class NewMineOrder_detailTypeTableViewCell: Wx_baseTableViewCell {
    
    private var _model : String?
    var model : String? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    private func didSetModel(_ model: String) {
        State.text = model
    }
    
    let State = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func buildUI() {
        
        State.textColor = UIColor.black
        State.font = UIFont.boldSystemFont(ofSize: GET_SIZE * 36)
        State.textAlignment = .center
        contentView.addSubview(State)
        _ = State.sd_layout()?
            .topSpaceToView(contentView,0)?
            .leftSpaceToView(contentView,0)?
            .widthIs(WIDTH)?
            .heightIs(GET_SIZE * 200)
    }
}
