//
//  newsStoreProjectListTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/14.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewsStoreProjectListTableViewCell: Wx_baseTableViewCell {

    let img = UIImageView()
    let title = UILabel()
    let hospital = UILabel()
    let count = UILabel()
    let currentPrice = UILabel()
    let oldPrice = UILabel()
    
    let otherIMG = UIImageView()
    let other = UILabel()
    
    let storeIMG = UIImageView()
    let store = UILabel()
    
    let experienceIMG = UIImageView()
    let experience = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildUI() {
        
        //图像
        contentView.addSubview(img)
        _ = img.sd_layout()?
            .topSpaceToView(contentView,GET_SIZE * 24)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 160)?
            .heightIs(GET_SIZE * 160)
        
        //标签
        title.textColor = UIColor.black
        title.numberOfLines = 0
        title.font = UIFont.systemFont(ofSize: GET_SIZE * 30)
        contentView.addSubview(title)
        _ = title.sd_layout()?
            .topSpaceToView(contentView,GET_SIZE * 24)?
            .leftSpaceToView(img,GET_SIZE * 24)?
            .rightSpaceToView(contentView,GET_SIZE * 24)?
            .heightIs(GET_SIZE * 74)
        
        //医院
        hospital.textColor = UIColor.black
        hospital.font = UIFont.systemFont(ofSize: GET_SIZE * 22)
        contentView.addSubview(hospital)
        _ = hospital.sd_layout()?
            .topSpaceToView(title,2)?
            .leftSpaceToView(img,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 400)?
            .heightIs(GET_SIZE * 26)
        
        //数量
        count.textColor = UIColor.black
        count.font = UIFont.systemFont(ofSize: GET_SIZE * 24)
        contentView.addSubview(count)
        _ = count.sd_layout()?
            .topSpaceToView(hospital,2)?
            .leftSpaceToView(img,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 400)?
            .heightIs(GET_SIZE * 26)
        
        //价格
        currentPrice.textColor = UIColor.red
        currentPrice.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        contentView.addSubview(currentPrice)
        _ = currentPrice.sd_layout()?
            .topSpaceToView(count,3)?
            .leftSpaceToView(img,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 200)?
            .heightIs(GET_SIZE * 30)
        
        oldPrice.textColor = UIColor.black
        oldPrice.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        contentView.addSubview(oldPrice)
        _ = oldPrice.sd_layout()?
            .centerYEqualToView(currentPrice)?
            .leftSpaceToView(currentPrice,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 200)?
            .heightIs(GET_SIZE * 120)
        
        
        //返券
        contentView.addSubview(otherIMG)
        _ = otherIMG.sd_layout()?
            .topSpaceToView(img,GET_SIZE * 24)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 20)?
            .heightIs(GET_SIZE * 20)
        
        other.textColor = UIColor.black
        other.font = UIFont.systemFont(ofSize: GET_SIZE * 20)
        contentView.addSubview(other)
        _ = other.sd_layout()?
            .centerYEqualToView(otherIMG)?
            .leftSpaceToView(otherIMG,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 200)?
            .heightIs(GET_SIZE * 21)
        
        //积分
        contentView.addSubview(storeIMG)
        _ = storeIMG.sd_layout()?
            .topSpaceToView(img,GET_SIZE * 24)?
            .leftSpaceToView(other,4)?
            .widthIs(GET_SIZE * 20)?
            .heightIs(GET_SIZE * 20)
        
        store.textColor = UIColor.black
        store.font = UIFont.systemFont(ofSize: GET_SIZE * 20)
        contentView.addSubview(store)
        _ = store.sd_layout()?
            .centerYEqualToView(otherIMG)?
            .leftSpaceToView(storeIMG,4)?
            .widthIs(GET_SIZE * 150)?
            .heightIs(GET_SIZE * 21)
        
        let line = UIView()
        line.backgroundColor = lineColor
        contentView.addSubview(line)
        _ = line.sd_layout()?
            .bottomSpaceToView(contentView,0)?
            .leftSpaceToView(contentView,0)?
            .widthIs(WIDTH)?
            .heightIs(0.5)
    }
    
    func buildModel() {
        
        img.image = UIImage(named:"banner_240")
        otherIMG.image = UIImage(named:"delete")
        storeIMG.image = UIImage(named:"delete")
        experienceIMG.image = UIImage(named:"delete")

        title.text = "【毛发种植】武汉公里医院名医&一秒柳岩二秒外星人"
        title.numberOfLines = 0
        title.lineBreakMode = .byCharWrapping
        hospital.text = "武汉新医美医院"
        count.text = "预约数：560"
        currentPrice.text = "￥6788"
        oldPrice.text = "￥8766"
        other.text = "最高可返还50%预约金"
        store.text = "积分+877"
    }
}
