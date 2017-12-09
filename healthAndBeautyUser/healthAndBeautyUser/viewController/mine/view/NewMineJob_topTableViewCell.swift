//
//  NewMineJob_topTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/29.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewMineJob_topTableViewCell: Wx_baseTableViewCell {
    
    private var _model : String?
    var model : String? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    private func didSetModel(_ model: String) {
        name.text = "李柏林"
        score.text = "我的积分 \("645")"
    }
    
    let meView = UIView()
    let img = UIButton()
    let name = UILabel()
    let sex = UIImageView()
    let other1 = UIImageView()

    let scoreView = UIView()
    let score = UILabel()
    let other2 = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func buildUI() {
        
        meView.backgroundColor = backGroundColor
        contentView.addSubview(meView)
        _ = meView.sd_layout()?
            .topSpaceToView(contentView,0)?
            .leftSpaceToView(contentView,0)?
            .widthIs(WIDTH)?
            .heightIs(GET_SIZE * 125)
        let meTap = UITapGestureRecognizer.init(target: self, action: #selector(meClick))
        meView.addGestureRecognizer(meTap)
        
        scoreView.backgroundColor = backGroundColor
        contentView.addSubview(scoreView)
        _ = scoreView.sd_layout()?
            .bottomSpaceToView(contentView,0)?
            .leftSpaceToView(contentView,0)?
            .widthIs(WIDTH)?
            .heightIs(GET_SIZE * 125)
        let scoreTap = UITapGestureRecognizer.init(target: self, action: #selector(scoreClick))
        meView.addGestureRecognizer(scoreTap)
        
        img.setImage(UIImage(named:"banner_240"), for: .normal)
        img.addTarget(self, action: #selector(meClick), for: .touchUpInside)
        contentView.addSubview(img)
        _ = img.sd_layout()?
            .centerYEqualToView(contentView)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 144)?
            .heightIs(GET_SIZE * 144)
        viewRadius(img, Float(GET_SIZE * 72), 0.5, UIColor.black)
        
        name.textColor = darkText
        name.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        name.textAlignment = .left
        meView.addSubview(name)
        _ = name.sd_layout()?
            .centerYEqualToView(meView)?
            .leftSpaceToView(meView,GET_SIZE * 128)?
            .widthIs(WIDTH/4)?
            .heightIs(GET_SIZE * 30)
        
        sex.image = UIImage(named:"banner_240")
        meView.addSubview(sex)
        _ = sex.sd_layout()?
            .centerYEqualToView(name)?
            .leftSpaceToView(name,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 30)?
            .heightIs(GET_SIZE * 30)
        
        other1.image = UIImage(named:"Selected")
        meView.addSubview(other1)
        _ = other1.sd_layout()?
            .centerYEqualToView(name)?
            .rightSpaceToView(meView,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 30)?
            .heightIs(GET_SIZE * 30)
        
        
        score.textColor = darkText
        score.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        score.textAlignment = .left
        scoreView.addSubview(score)
        _ = score.sd_layout()?
            .centerYEqualToView(scoreView)?
            .leftSpaceToView(scoreView,GET_SIZE * 128)?
            .widthIs(WIDTH/4)?
            .heightIs(GET_SIZE * 30)
        
        other2.image = UIImage(named:"Selected")
        meView.addSubview(other2)
        _ = other2.sd_layout()?
            .centerYEqualToView(name)?
            .rightSpaceToView(meView,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 30)?
            .heightIs(GET_SIZE * 30)
    }
    
    //点击我
    @objc private func meClick() {
        
    }
    
    //点击我的积分
    @objc private func scoreClick() {
        
    }
}
