//
//  NewMineJob_listTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/30.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewMineJob_listTableViewCell: Wx_baseTableViewCell {
    
    private var _model : String?
    var model : String? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    private func didSetModel(_ model: String) {
        
        title.text = "收藏李柏林"
        score.text = "积分 +10"
        viewRadius(score, 5.0, 0.5, UIColor.darkGray)
        _ = advance.sd_layout()?
            .topSpaceToView(icon,GET_SIZE * 24)?
            .leftEqualToView(icon)?
            .widthIs(GET_SIZE * (600/5*2))?
            .heightIs(3)
        advanceLab.text = "进度2/5"
    }
    
    let icon = UIImageView()
    
    let title = UILabel()
    let score = UILabel()
    
    let controllerBtn = UIButton()
    
    var advanceBack = UIView()
    var advance = UIView()
    var advanceLab = UILabel()
    
    var line = UIView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildUI() {
        
        icon.image = UIImage(named:"banner_240")
        contentView.addSubview(icon)
        _ = icon.sd_layout()?
            .centerYEqualToView(contentView)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 88)?
            .heightIs(GET_SIZE * 88)
        
        //标签和分数
        title.textColor = darkText
        title.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        title.textAlignment = .left
        contentView.addSubview(title)
        _ = title.sd_layout()?
            .topEqualToView(icon)?
            .leftSpaceToView(icon,GET_SIZE * 24)?
            .widthIs(WIDTH/3)?
            .heightIs(GET_SIZE * 30)
        
        score.textColor = darkText
        score.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        score.textAlignment = .left
        contentView.addSubview(score)
        _ = score.sd_layout()?
            .bottomEqualToView(icon)?
            .leftSpaceToView(icon,GET_SIZE * 24)?
            .widthIs(WIDTH/3)?
            .heightIs(GET_SIZE * 30)
        
        //控制按钮
        controllerBtn.backgroundColor = UIColor.blue
        controllerBtn.setTitleColor(getColorWithNotAlphe(0xF1931A), for: .normal)
        controllerBtn.titleLabel?.font = UIFont.systemFont(ofSize: GET_SIZE * 32)
        viewRadius(controllerBtn, 5.0, 0.5, UIColor.lightGray)
        contentView.addSubview(controllerBtn)
        _ = controllerBtn.sd_layout()?
            .centerYEqualToView(icon)?
            .rightSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 250)?
            .heightIs(GET_SIZE * 72)
        
        //进度条部分
        advanceBack.backgroundColor = UIColor.white
        contentView.addSubview(advanceBack)
        _ = advanceBack.sd_layout()?
            .topSpaceToView(icon,GET_SIZE * 24)?
            .leftEqualToView(icon)?
            .widthIs(GET_SIZE * 600)?
            .heightIs(3)
        
        advance.backgroundColor = lineColor
        contentView.addSubview(advance)
        _ = advance.sd_layout()?
            .topSpaceToView(icon,GET_SIZE * 24)?
            .leftEqualToView(icon)?
            .widthIs(GET_SIZE * 600)?
            .heightIs(3)
        
        advanceLab.textColor = darkText
        advanceLab.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        advanceLab.textAlignment = .right
        contentView.addSubview(advanceLab)
        _ = advanceLab.sd_layout()?
            .centerYEqualToView(advanceBack)?
            .rightSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(WIDTH/4)?
            .heightIs(GET_SIZE * 30)
        
        //进度条部分
        line.backgroundColor = lineColor
        contentView.addSubview(line)
        _ = line.sd_layout()?
            .bottomSpaceToView(contentView,0)?
            .leftSpaceToView(contentView,0)?
            .widthIs(WIDTH)?
            .heightIs(0.5)
    }
}
