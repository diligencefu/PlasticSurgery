//
//  NewStoreDetailMostTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/18.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewStoreDetailMostTableViewCell: Wx_baseTableViewCell {
    
    private var _model : FYHMineMessgeAllModel?
    var model : FYHMineMessgeAllModel? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    private func didSetModel(_ model: FYHMineMessgeAllModel) {
        
    }
    
    let title = UILabel()
    let currentPrice = UILabel()
    let oldPrice = UILabel()
    let sell = UILabel()
    var location = UILabel()
    var count = UILabel()
    
    var line = UIView()
    
    var bookIMG = UIImageView()
    var book = UILabel()
    var bookIMG2 = UIImageView()
    var scoreIMG = UIImageView()
    var score = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func buildUI() {
        
        title.textColor = UIColor.black
        title.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        contentView.addSubview(title)
        _ = title.sd_layout()?
            .topSpaceToView(contentView,GET_SIZE * 24)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .rightSpaceToView(contentView,GET_SIZE * 24)?
            .heightIs(GET_SIZE * 65)
        
        currentPrice.textColor = UIColor.black
        currentPrice.font = UIFont.systemFont(ofSize: GET_SIZE * 36)
        contentView.addSubview(currentPrice)
        _ = currentPrice.sd_layout()?
            .topSpaceToView(title,GET_SIZE * 24)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 80)?
            .heightIs(GET_SIZE * 36)
        
        oldPrice.textColor = UIColor.black
        oldPrice.font = UIFont.systemFont(ofSize: GET_SIZE * 36)
        contentView.addSubview(oldPrice)
        _ = oldPrice.sd_layout()?
            .topSpaceToView(title,GET_SIZE * 24)?
            .leftSpaceToView(currentPrice,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 80)?
            .heightIs(GET_SIZE * 36)
        
        sell.textColor = UIColor.white
        sell.backgroundColor = UIColor.lightGray
        sell.font = UIFont.systemFont(ofSize: GET_SIZE * 36)
        contentView.addSubview(sell)
        _ = sell.sd_layout()?
            .topSpaceToView(title,GET_SIZE * 24)?
            .leftSpaceToView(currentPrice,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 80)?
            .heightIs(GET_SIZE * 36)
        viewRadius(sell, 5.0, 0.5, UIColor.lightGray)
        
        location.textColor = UIColor.black
        location.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        contentView.addSubview(location)
        _ = location.sd_layout()?
            .topSpaceToView(currentPrice,GET_SIZE * 24)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .rightSpaceToView(contentView,WIDTH/2)?
            .heightIs(GET_SIZE * 30)
        
        count.textColor = UIColor.black
        count.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        contentView.addSubview(count)
        _ = count.sd_layout()?
            .topSpaceToView(currentPrice,GET_SIZE * 24)?
            .rightSpaceToView(contentView,GET_SIZE * 24)?
            .leftSpaceToView(contentView,WIDTH/2)?
            .heightIs(GET_SIZE * 30)
        
        line.backgroundColor = lineColor
        contentView.addSubview(line)
        _ = line.sd_layout()?
            .topSpaceToView(location,GET_SIZE * 10)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .rightSpaceToView(contentView,GET_SIZE * 24)?
            .heightIs(0.5)
        
//        phoneConnect = returnDefaultWithRedioButton()
//        contentView.addSubview(phoneConnect)
//        _ = phoneConnect.sd_layout()?
//            .topSpaceToView(location,GET_SIZE * 10)?
//            .leftSpaceToView(icon,GET_SIZE * 24)?
//            .widthIs(GET_SIZE * 250)?
//            .heightIs(GET_SIZE * 64)
//        phoneConnect.setTitle("电话咨询", for: .normal)
//        
//        lineConnect = returnDefaultWithRedioButton()
//        contentView.addSubview(lineConnect)
//        _ = lineConnect.sd_layout()?
//            .topSpaceToView(location,GET_SIZE * 10)?
//            .leftSpaceToView(phoneConnect,GET_SIZE * 36)?
//            .widthIs(GET_SIZE * 250)?
//            .heightIs(GET_SIZE * 64)
//        phoneConnect.setTitle("在线咨询", for: .normal)
        
    }
}
