//
//  NewStoreDetailHostitalView.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/18.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewStoreDetailHostitalView: Wx_baseTableViewCell {
    
    private var _model : NewStoreDetailModel?
    var model : NewStoreDetailModel? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    
    private func didSetModel(_ model: NewStoreDetailModel) {
        
    }
    
    let icon = UIImageView()
    let name = UILabel()
    let hospitalMG = UIImageView()
    let phone = UILabel()
    let location = UILabel()
    var phoneConnect = UIButton()
    var lineConnect = UIButton()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func buildUI() {
        
        contentView.addSubview(icon)
        _ = icon.sd_layout()?
            .topSpaceToView(contentView,GET_SIZE * 24)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 88)?
            .heightIs(GET_SIZE * 88)
        viewRadius(icon, Float(icon.width/2), 0.5, UIColor.darkGray)
        
        name.textColor = getColorWithNotAlphe(0xF1931A)
        name.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        contentView.addSubview(name)
        _ = name.sd_layout()?
            .topSpaceToView(contentView,GET_SIZE * 24)?
            .leftSpaceToView(icon,GET_SIZE * 24)?
            .widthIs(WIDTH/2)?
            .heightIs(GET_SIZE * 30)
        
        contentView.addSubview(hospitalMG)
        _ = hospitalMG.sd_layout()?
            .centerYEqualToView(name)?
            .leftSpaceToView(name,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 60)?
            .heightIs(GET_SIZE * 25)
        
        
        phone.textColor = UIColor.black
        phone.font = UIFont.systemFont(ofSize: GET_SIZE * 22)
        contentView.addSubview(phone)
        _ = phone.sd_layout()?
            .topSpaceToView(name,GET_SIZE * 10)?
            .leftSpaceToView(icon,GET_SIZE * 24)?
            .widthIs(WIDTH/2)?
            .heightIs(GET_SIZE * 24)
        
        location.textColor = UIColor.black
        location.font = UIFont.systemFont(ofSize: GET_SIZE * 22)
        contentView.addSubview(location)
        _ = location.sd_layout()?
            .topSpaceToView(phone,GET_SIZE * 10)?
            .leftSpaceToView(icon,GET_SIZE * 24)?
            .widthIs(WIDTH/2)?
            .heightIs(GET_SIZE * 24)
        
        phoneConnect = returnDefaultWithRedioButton()
        contentView.addSubview(phoneConnect)
        _ = phoneConnect.sd_layout()?
            .topSpaceToView(location,GET_SIZE * 10)?
            .leftSpaceToView(icon,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 250)?
            .heightIs(GET_SIZE * 64)
        phoneConnect.setTitle("电话咨询", for: .normal)
        
        lineConnect = returnDefaultWithRedioButton()
        contentView.addSubview(lineConnect)
        _ = lineConnect.sd_layout()?
            .topSpaceToView(location,GET_SIZE * 10)?
            .leftSpaceToView(phoneConnect,GET_SIZE * 36)?
            .widthIs(GET_SIZE * 250)?
            .heightIs(GET_SIZE * 64)
        phoneConnect.setTitle("在线咨询", for: .normal)
    }
}
