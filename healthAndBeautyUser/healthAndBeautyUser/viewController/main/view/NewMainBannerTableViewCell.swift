//
//  NewMainBannerTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/19.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewMainBannerTableViewCell: Wx_baseTableViewCell {
    
    func buildData() {
        leftBtn.setImage(UIImage(named:"11_banner_secondary_default"), for: .normal)
        rightTopBtn.setImage(UIImage(named:"12_banner_secondary_default"), for: .normal)
        rightBottomBtn.setImage(UIImage(named:"13_banner_secondary_default"), for: .normal)
    }
    
    private var _model : NewMineMessageModel?
    var model : NewMineMessageModel? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    
    private func didSetModel(_ model: NewMineMessageModel) {
        
    }
    
    let leftBtn = UIButton()
    let rightTopBtn = UIButton()
    let rightBottomBtn = UIButton()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func buildUI() {
        
        contentView.addSubview(leftBtn)
        _ = leftBtn.sd_layout()?
            .topSpaceToView(contentView,GET_SIZE * 12)?
            .leftSpaceToView(contentView,GET_SIZE * 12)?
            .widthIs(GET_SIZE * 357)?
            .heightIs(GET_SIZE * 376)
        
        contentView.addSubview(rightTopBtn)
        _ = rightTopBtn.sd_layout()?
            .topSpaceToView(contentView,GET_SIZE * 12)?
            .rightSpaceToView(contentView,GET_SIZE * 12)?
            .leftSpaceToView(leftBtn,GET_SIZE * 12)?
            .heightIs(GET_SIZE * 182)
        
        contentView.addSubview(rightBottomBtn)
        _ = rightBottomBtn.sd_layout()?
            .topSpaceToView(rightTopBtn,GET_SIZE * 12)?
            .rightSpaceToView(contentView,GET_SIZE * 12)?
            .leftSpaceToView(leftBtn,GET_SIZE * 12)?
            .heightIs(GET_SIZE * 182)
        
        let line = UIView()
        line.backgroundColor = lineColor
        contentView.addSubview(line)
        _ = line.sd_layout()?
            .bottomSpaceToView(contentView,0)?
            .leftSpaceToView(contentView,0)?
            .widthIs(WIDTH)?
            .heightIs(10)
    }
}
