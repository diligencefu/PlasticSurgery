//
//  newStoreExampleListTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/14.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewStoreExampleListTableViewCell: Wx_baseTableViewCell {
    
    let head = UIImageView()
    let name = UILabel()
    let time = UILabel()
    let follow = UIButton()
    
    let imgView = UIView()
    let exampleDetail = UILabel()
    
    let detailImg = UIImageView()
    let detail = UILabel()
    
    let line = UIView()

    let doctor = UILabel()
    let doctoriMG = UIImageView()
    let doctorcomment = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildUI() {
        
        //图像
        contentView.addSubview(head)
        _ = head.sd_layout()?
            .topSpaceToView(contentView,GET_SIZE * 24)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 90)?
            .heightIs(GET_SIZE * 90)
        
        //标签
        name.textColor = UIColor.black
        name.numberOfLines = 0
        name.font = UIFont.systemFont(ofSize: GET_SIZE * 30)
        contentView.addSubview(name)
        _ = name.sd_layout()?
            .topSpaceToView(head,4)?
            .leftSpaceToView(head,GET_SIZE * 24)?
            .widthIs(WIDTH/2)?
            .heightIs(GET_SIZE * 30)
        
        //医院
        time.textColor = UIColor.black
        time.font = UIFont.systemFont(ofSize: GET_SIZE * 22)
        contentView.addSubview(time)
        _ = time.sd_layout()?
            .topSpaceToView(name,2)?
            .leftSpaceToView(head,GET_SIZE * 24)?
            .widthIs(WIDTH/2)?
            .heightIs(GET_SIZE * 24)
        
        //数量
        follow.setTitle("关注+", for: .normal)
        follow.backgroundColor = backGroundColor
        follow.setTitleColor(getColorWithNotAlphe(0xF1931A), for: .normal)
        follow.titleLabel?.font = UIFont.systemFont(ofSize: GET_SIZE * 32)
        viewRadius(follow, 5.0, 0.5, UIColor.lightGray)
        contentView.addSubview(follow)
        _ = follow.sd_layout()?
            .centerYEqualToView(contentView)?
            .rightSpaceToView(contentView,left)?
            .widthIs(GET_SIZE * 100)?
            .heightIs(GET_SIZE * 40)
        
        let backView = UIView()
        backView.backgroundColor = backGroundColor;
        contentView.addSubview(backView)

        var imgArr = [UIImageView]()
        for _ in 0...2 {
            let img = UIImageView()
            img.image = UIImage(named:"banner_240")
            backView.addSubview(img)
            img.sd_layout()?.autoHeightRatio(0.5)
            imgArr.append(img)
        }
        _ = backView.sd_layout()?
            .leftSpaceToView(contentView,10)?
            .rightSpaceToView(contentView,10)?
            .widthIs(GET_SIZE * 100)?
            .heightIs(GET_SIZE * 60)
//        * 设置类似collectionView效果的固定间距自动宽度浮动子view
//        * viewsArray       : 需要浮动布局的所有视图
//        * perRowItemsCount : 每行显示的视图个数
//        * verticalMargin   : 视图之间的垂直间距
//        * horizontalMargin : 视图之间的水平间距
//        * vInset           : 上下缩进值
//        * hInset           : 左右缩进值
        backView.setupAutoWidthFlowItems(imgArr,
                                         withPerRowItemsCount: 3,
                                         verticalMargin: 0,
                                         horizontalMargin: 10,
                                         verticalEdgeInset: 5,
                                         horizontalEdgeInset: 5)
    }
            
//        textColor = UIColor.black
//        count.font = UIFont.systemFont(ofSize: GET_SIZE * 24)
//        contentView.addSubview(count)
//        _ = count.sd_layout()?
//            .topSpaceToView(hospital,2)?
//            .leftSpaceToView(img,GET_SIZE * 24)?
//            .widthIs(GET_SIZE * 400)?
//            .heightIs(GET_SIZE * 26)
//        
//        //价格
//        currentPrice.textColor = UIColor.red
//        currentPrice.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
//        contentView.addSubview(currentPrice)
//        _ = currentPrice.sd_layout()?
//            .topSpaceToView(count,3)?
//            .leftSpaceToView(img,GET_SIZE * 24)?
//            .widthIs(GET_SIZE * 200)?
//            .heightIs(GET_SIZE * 30)
//        
//        oldPrice.textColor = UIColor.black
//        oldPrice.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
//        contentView.addSubview(oldPrice)
//        _ = oldPrice.sd_layout()?
//            .centerYEqualToView(currentPrice)?
//            .leftSpaceToView(currentPrice,GET_SIZE * 24)?
//            .widthIs(GET_SIZE * 200)?
//            .heightIs(GET_SIZE * 120)
//        
//        
//        //返券
//        contentView.addSubview(otherIMG)
//        _ = otherIMG.sd_layout()?
//            .bottomSpaceToView(contentView,GET_SIZE * 24)?
//            .leftSpaceToView(contentView,GET_SIZE * 24)?
//            .widthIs(GET_SIZE * 20)?
//            .heightIs(GET_SIZE * 20)
//        
//        other.textColor = UIColor.black
//        other.font = UIFont.systemFont(ofSize: GET_SIZE * 20)
//        contentView.addSubview(other)
//        _ = other.sd_layout()?
//            .centerYEqualToView(otherIMG)?
//            .leftSpaceToView(otherIMG,GET_SIZE * 24)?
//            .widthIs(GET_SIZE * 200)?
//            .heightIs(GET_SIZE * 21)
//        
//        //积分
//        contentView.addSubview(storeIMG)
//        _ = storeIMG.sd_layout()?
//            .bottomSpaceToView(contentView,GET_SIZE * 24)?
//            .leftSpaceToView(other,4)?
//            .widthIs(GET_SIZE * 20)?
//            .heightIs(GET_SIZE * 20)
//        
//        store.textColor = UIColor.black
//        store.font = UIFont.systemFont(ofSize: GET_SIZE * 20)
//        contentView.addSubview(store)
//        _ = store.sd_layout()?
//            .centerYEqualToView(otherIMG)?
//            .leftSpaceToView(storeIMG,4)?
//            .widthIs(GET_SIZE * 150)?
//            .heightIs(GET_SIZE * 21)
//        
//        //经验
//        contentView.addSubview(experienceIMG)
//        _ = experienceIMG.sd_layout()?
//            .bottomSpaceToView(contentView,GET_SIZE * 24)?
//            .leftSpaceToView(store,GET_SIZE * 24)?
//            .widthIs(GET_SIZE * 20)?
//            .heightIs(GET_SIZE * 20)
//        experience.textColor = UIColor.black
//        experience.font = UIFont.systemFont(ofSize: GET_SIZE * 20)
//        contentView.addSubview(experience)
//        _ = experience.sd_layout()?
//            .centerYEqualToView(otherIMG)?
//            .leftSpaceToView(experienceIMG,4)?
//            .widthIs(GET_SIZE * 150)?
//            .heightIs(GET_SIZE * 21)
//    }
//    
//    func buildModel() {
//        img.image = UIImage(named:"banner_240")
//        otherIMG.image = UIImage(named:"delete")
//        storeIMG.image = UIImage(named:"delete")
//        experienceIMG.image = UIImage(named:"delete")
//        
//        title.text = "【毛发种植】武汉公里医院名医&一秒柳岩二秒外星人"
//        title.sizeToFit()
//        hospital.text = "武汉新医美医院"
//        count.text = "预约数：560"
//        currentPrice.text = "￥6788"
//        oldPrice.text = "￥8766"
//        other.text = "最高可返还50%预约金"
//        store.text = "积分+877"
//        experience.text = "经验+60"
//    }
}
