//
//  NewMineMe_detailTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/28.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewMineMe_detailTableViewCell: Wx_baseTableViewCell {
    
    private var _model : NewMineMeModel?
    var model : NewMineMeModel? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    
    private func didSetModel(_ model: NewMineMeModel) {
        if model.gender == "1" {
            sex.text = "性  别:    \("男")"
        }else {
            sex.text = "性  别:    \("女")"
        }
        age.text = "年  龄:    \(model.age)岁"
        location.text = "地  区:    \(model.area)"
        score.text = "积  分:    \(model.integral)"
//        heightLab.text = "身  高:    \("165cm")"
//        weightLab.text = "体  重:    \("42kg")"
    }
    
    let sex = UILabel()
    let sexline = UIView()
    let age = UILabel()
    let ageline = UIView()
    let location = UILabel()
    let locationline = UIView()
    let score = UILabel()
    let scoreline = UIView()
//    let heightLab = UILabel()
//    let heightLabline = UIView()
//    let weightLab = UILabel()
//    let weightLabline = UIView()
    let line = UIView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func buildUI() {
        
        sex.textColor = darkText
        sex.font = UIFont.systemFont(ofSize: GET_SIZE * 32)
        sex.textAlignment = .left
        contentView.addSubview(sex)
        _ = sex.sd_layout()?
            .topSpaceToView(contentView,GET_SIZE * 23)?
            .leftSpaceToView(contentView,GET_SIZE * 32)?
            .widthIs(WIDTH)?
            .heightIs(GET_SIZE * 34)
        sexline.backgroundColor = lineColor
        contentView.addSubview(sexline)
        _ = sexline.sd_layout()?
            .topSpaceToView(sex,GET_SIZE * 23)?
            .leftSpaceToView(contentView,GET_SIZE * 32)?
            .widthIs(WIDTH)?
            .heightIs(0.5)
        
        age.textColor = darkText
        age.font = UIFont.systemFont(ofSize: GET_SIZE * 32)
        age.textAlignment = .left
        contentView.addSubview(age)
        _ = age.sd_layout()?
            .topSpaceToView(sexline,GET_SIZE * 24)?
            .leftSpaceToView(contentView,GET_SIZE * 32)?
            .widthIs(WIDTH)?
            .heightIs(GET_SIZE * 34)
        ageline.backgroundColor = lineColor
        contentView.addSubview(ageline)
        _ = ageline.sd_layout()?
            .topSpaceToView(age,GET_SIZE * 23)?
            .leftSpaceToView(contentView,GET_SIZE * 32)?
            .widthIs(WIDTH)?
            .heightIs(0.5)
        
        location.textColor = darkText
        location.font = UIFont.systemFont(ofSize: GET_SIZE * 32)
        location.textAlignment = .left
        contentView.addSubview(location)
        _ = location.sd_layout()?
            .topSpaceToView(ageline,GET_SIZE * 24)?
            .leftSpaceToView(contentView,GET_SIZE * 32)?
            .widthIs(WIDTH)?
            .heightIs(GET_SIZE * 34)
        locationline.backgroundColor = lineColor
        contentView.addSubview(locationline)
        _ = locationline.sd_layout()?
            .topSpaceToView(location,GET_SIZE * 23)?
            .leftSpaceToView(contentView,GET_SIZE * 32)?
            .widthIs(WIDTH)?
            .heightIs(0.5)
        
        score.textColor = darkText
        score.font = UIFont.systemFont(ofSize: GET_SIZE * 32)
        score.textAlignment = .left
        contentView.addSubview(score)
        _ = score.sd_layout()?
            .topSpaceToView(locationline,GET_SIZE * 24)?
            .leftSpaceToView(contentView,GET_SIZE * 32)?
            .widthIs(WIDTH)?
            .heightIs(GET_SIZE * 34)
        scoreline.backgroundColor = lineColor
        contentView.addSubview(scoreline)
        _ = scoreline.sd_layout()?
            .topSpaceToView(score,GET_SIZE * 23)?
            .leftSpaceToView(contentView,GET_SIZE * 32)?
            .widthIs(WIDTH)?
            .heightIs(0.5)
        
//        heightLab.textColor = darkText
//        heightLab.font = UIFont.systemFont(ofSize: GET_SIZE * 32)
//        heightLab.textAlignment = .left
//        contentView.addSubview(heightLab)
//        _ = heightLab.sd_layout()?
//            .topSpaceToView(scoreline,GET_SIZE * 24)?
//            .leftSpaceToView(contentView,GET_SIZE * 32)?
//            .widthIs(WIDTH)?
//            .heightIs(GET_SIZE * 34)
//        heightLabline.backgroundColor = lineColor
//        contentView.addSubview(heightLabline)
//        _ = heightLabline.sd_layout()?
//            .topSpaceToView(heightLab,GET_SIZE * 23)?
//            .leftSpaceToView(contentView,GET_SIZE * 32)?
//            .widthIs(WIDTH)?
//            .heightIs(0.5)
//
//        weightLab.textColor = darkText
//        weightLab.font = UIFont.systemFont(ofSize: GET_SIZE * 32)
//        weightLab.textAlignment = .left
//        contentView.addSubview(weightLab)
//        _ = weightLab.sd_layout()?
//            .topSpaceToView(heightLabline,GET_SIZE * 24)?
//            .leftSpaceToView(contentView,GET_SIZE * 32)?
//            .widthIs(WIDTH)?
//            .heightIs(GET_SIZE * 34)
//        weightLabline.backgroundColor = lineColor
//        contentView.addSubview(weightLabline)
//        _ = weightLabline.sd_layout()?
//            .topSpaceToView(weightLab,GET_SIZE * 23)?
//            .leftSpaceToView(contentView,GET_SIZE * 32)?
//            .widthIs(WIDTH)?
//            .heightIs(0.5)
        
        line.backgroundColor = lineColor
        contentView.addSubview(line)
        _ = line.sd_layout()?
            .bottomEqualToView(contentView)?
            .leftSpaceToView(contentView,0)?
            .widthIs(WIDTH)?
            .heightIs(10)
    }
}
