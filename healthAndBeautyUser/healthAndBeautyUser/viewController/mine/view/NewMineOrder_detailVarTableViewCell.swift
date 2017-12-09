//
//  NewMineOrderDetailTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/26.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

//这个是订单详情底部的5个属性

import UIKit

class NewMineOrder_detailVarTableViewCell: Wx_baseTableViewCell {
    
    private var _model : String?
    var model : String? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    
    private func didSetModel(_ model: String) {
        
        allLab.text = "订单合计： ￥\("104")"
        countLab.text = "数量： \("2")"
        timeLab.text = "订单时间： \("2017-08-09 15:51:55")"
        orderIdLab.text = "订单号： \("HG65JM8IOJ3KMK334223")"
        phoneLab.text = "手机号： \("18571720073")"
    }
    
    let allLab = UILabel()
    let countLab = UILabel()
    let timeLab = UILabel()
    let orderIdLab = UILabel()
    let phoneLab = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func buildUI() {
        
        allLab.textColor = UIColor.black
        allLab.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        allLab.textAlignment = .left
        contentView.addSubview(allLab)
        _ = allLab.sd_layout()?
            .topSpaceToView(contentView,GET_SIZE * 24)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .rightSpaceToView(contentView,GET_SIZE * 24)?
            .heightIs(GET_SIZE * 30)
        
        countLab.textColor = UIColor.black
        countLab.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        countLab.textAlignment = .left
        contentView.addSubview(countLab)
        _ = countLab.sd_layout()?
            .topSpaceToView(allLab,GET_SIZE * 12)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .rightSpaceToView(contentView,GET_SIZE * 24)?
            .heightIs(GET_SIZE * 30)
        
        timeLab.textColor = UIColor.black
        timeLab.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        timeLab.textAlignment = .left
        contentView.addSubview(timeLab)
        _ = timeLab.sd_layout()?
            .topSpaceToView(countLab,GET_SIZE * 12)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .rightSpaceToView(contentView,GET_SIZE * 24)?
            .heightIs(GET_SIZE * 30)
        
        orderIdLab.textColor = UIColor.black
        orderIdLab.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        orderIdLab.textAlignment = .left
        contentView.addSubview(orderIdLab)
        _ = orderIdLab.sd_layout()?
            .topSpaceToView(timeLab,GET_SIZE * 12)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .rightSpaceToView(contentView,GET_SIZE * 24)?
            .heightIs(GET_SIZE * 30)
        
        phoneLab.textColor = UIColor.black
        phoneLab.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        phoneLab.textAlignment = .left
        contentView.addSubview(phoneLab)
        _ = phoneLab.sd_layout()?
            .topSpaceToView(orderIdLab,GET_SIZE * 12)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .rightSpaceToView(contentView,GET_SIZE * 24)?
            .heightIs(GET_SIZE * 30)
    }
}
