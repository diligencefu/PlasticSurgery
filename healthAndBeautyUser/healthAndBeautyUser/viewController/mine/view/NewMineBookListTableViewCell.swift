//
//  NewMineBookListTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/18.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewMineBookListTableViewCell: Wx_baseTableViewCell {
    
    private var _model : NewMineBookModel?
    var model : NewMineBookModel? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    
    private func didSetModel(_ model: NewMineBookModel) {
        
    }
    
    let backView = UIView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildUI() {
    
        backView.backgroundColor = UIColor.white
        viewRadius(backView, 5.0, 0.5, UIColor.white)
        contentView.addSubview(backView)
        _ = backView.sd_layout()?
            .centerXEqualToView(contentView)?
            .centerYEqualToView(contentView)?
            .widthIs(GET_SIZE * 700)?
            .heightIs(GET_SIZE * 160)
        
        let book = UILabel()
        book.text = "优惠券"
        book.textColor = UIColor.lightGray
        book.textAlignment = .center
        book.font = UIFont.boldSystemFont(ofSize: GET_SIZE * 39)
        backView.addSubview(book)
        _ = book.sd_layout()?
            .centerXEqualToView(backView)?
            .centerYEqualToView(backView)?
            .widthIs(GET_SIZE * 500)?
            .heightIs(GET_SIZE * 100)
    }
}
