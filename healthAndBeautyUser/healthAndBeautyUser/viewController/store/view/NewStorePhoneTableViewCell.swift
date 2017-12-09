//
//  NewStorePhoneTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/9/4.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewStorePhoneTableViewCell: Wx_baseTableViewCell {
    
    private var _model : String?
    var model : String? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    private func didSetModel(_ model: String) {
        phone.text = "手机号: \(model)"
    }
    
    let phone = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func buildUI() {
        
        phone.textColor = darkText
        phone.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        phone.textAlignment = .left
        contentView.addSubview(phone)
        _ = phone.sd_layout()?
            .centerYEqualToView(contentView)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(WIDTH/2)?
            .heightIs(GET_SIZE * 30)
    }
}
