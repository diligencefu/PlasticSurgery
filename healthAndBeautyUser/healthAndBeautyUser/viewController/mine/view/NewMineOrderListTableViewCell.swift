//
//  newMineOrderListTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/17.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewMineOrderListTableViewCell: Wx_baseTableViewCell {
    
    private var _model : NewMineOrderLIstModel?
    var model : NewMineOrderLIstModel? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    
    private func didSetModel(_ model: NewMineOrderLIstModel) {
        
//        hospital.text = model.hospital
//        state.text = model.orderState
//        
//        icon.image = UIImage(named:model.icon)
//        title.text = model.title
//        location.text = model.location
//        count.text = "* \(model.count)"
//        
//        payed.text = "预约金 \(model.count)"
//        willPay.text = "到院再付 \(model.count)"
        
        leftBtn.setTitle("取消支付", for: .normal)
        rightBtn.setTitle("去支付", for: .normal)
    }
    
//    var hospital = String()
//    var orderState = String()
//    var icon = String()
//    var title = String()
//    var location = String()
//    var count = String()
//    var payed = String()
//    var willPay = String()
//    var all = String()
    
    let hospital = UILabel()
    let hospitalRightIMG = UIImageView()
    let state = UILabel()
    let line1 = UIView()
    
    let icon = UIImageView()
    let title = UILabel()
    let location = UILabel()
    let count = UILabel()
    let payed = UILabel()
    let willPay = UILabel()
    let line2 = UIView()
    
    let leftBtn = UIButton()
    let rightBtn = UIButton()
    let line3 = UIView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildUI() {
        
        hospital.textColor = UIColor.black
        hospital.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        contentView.addSubview(hospital)
        _ = hospital.sd_layout()?
            .topSpaceToView(contentView,GET_SIZE * 14)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(WIDTH/3)?
            .heightIs(GET_SIZE * 30)
        
        hospitalRightIMG.image = UIImage(named:"Selected")
        contentView.addSubview(hospitalRightIMG)
        _ = hospitalRightIMG.sd_layout()?
            .centerYEqualToView(hospital)?
            .leftSpaceToView(hospital,GET_SIZE * 44)?
            .widthIs(GET_SIZE * 20)?
            .heightIs(GET_SIZE * 30)
        
        state.textColor = getColorWithNotAlphe(0xF1931A)
        state.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        state.textAlignment = .right
        contentView.addSubview(state)
        _ = state.sd_layout()?
            .centerYEqualToView(hospital)?
            .rightSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(WIDTH/4)?
            .heightIs(GET_SIZE * 30)
        
        line1.backgroundColor = lineColor
        contentView.addSubview(line1)
        _ = line1.sd_layout()?
            .topSpaceToView(state,GET_SIZE * 14)?
            .leftSpaceToView(contentView,0)?
            .widthIs(WIDTH)?
            .heightIs(0.5)
        
        contentView.addSubview(icon)
        _ = icon.sd_layout()?
            .topSpaceToView(line1,GET_SIZE * 24)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 175)?
            .heightIs(GET_SIZE * 175)
          
        title.textColor = UIColor.black
        title.font = UIFont.systemFont(ofSize: GET_SIZE * 32)
        title.textAlignment = .left
        title.numberOfLines = 0
        title.lineBreakMode = .byCharWrapping
        contentView.addSubview(title)
        _ = title.sd_layout()?
            .topSpaceToView(line1,GET_SIZE * 24)?
            .leftSpaceToView(icon,GET_SIZE * 24)?
            .rightSpaceToView(contentView,GET_SIZE * 24)?
            .heightIs(GET_SIZE * 90)
        
        location.textColor = UIColor.black
        location.font = UIFont.systemFont(ofSize: GET_SIZE * 22)
        contentView.addSubview(location)
        _ = location.sd_layout()?
            .topSpaceToView(title,0)?
            .leftSpaceToView(icon,GET_SIZE * 24)?
            .widthIs(WIDTH/3)?
            .heightIs(GET_SIZE * 24)
        
        count.textColor = UIColor.black
        count.font = UIFont.systemFont(ofSize: GET_SIZE * 22)
        count.textAlignment = .right
        contentView.addSubview(count)
        _ = count.sd_layout()?
            .centerYEqualToView(location)?
            .rightSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(WIDTH/3)?
            .heightIs(GET_SIZE * 24)
        
        payed.textColor = UIColor.black
        payed.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        payed.textAlignment = .left
        contentView.addSubview(payed)
        _ = payed.sd_layout()?
            .topSpaceToView(location,GET_SIZE * 24)?
            .leftSpaceToView(icon,GET_SIZE * 24)?
            .widthIs(WIDTH/4)?
            .heightIs(GET_SIZE * 30)
        
        willPay.textColor = UIColor.black
        willPay.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        willPay.textAlignment = .left
        contentView.addSubview(willPay)
        _ = willPay.sd_layout()?
            .centerYEqualToView(payed)?
            .leftSpaceToView(payed,GET_SIZE * 24)?
            .widthIs(WIDTH/4)?
            .heightIs(GET_SIZE * 30)
        
        let line2 = UIView()
        line2.backgroundColor = lineColor
        contentView.addSubview(line2)
        _ = line2.sd_layout()?
            .topSpaceToView(icon,GET_SIZE * 24)?
            .leftSpaceToView(contentView,0)?
            .widthIs(WIDTH)?
            .heightIs(0.5)
        
        leftBtn.backgroundColor = backGroundColor
        leftBtn.setTitleColor(getColorWithNotAlphe(0xF1931A), for: .normal)
        leftBtn.titleLabel?.font = UIFont.systemFont(ofSize: GET_SIZE * 32)
        viewRadius(leftBtn, 5.0, 0.5, UIColor.lightGray)
        contentView.addSubview(leftBtn)
        _ = leftBtn.sd_layout()?
            .topSpaceToView(line2,GET_SIZE * 10)?
            .bottomSpaceToView(contentView,GET_SIZE * 10)?
            .leftSpaceToView(contentView,GET_SIZE * 300)?
            .widthIs(GET_SIZE * 200)
        
        rightBtn.backgroundColor = backGroundColor
        rightBtn.setTitleColor(getColorWithNotAlphe(0xF1931A), for: .normal)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: GET_SIZE * 32)
        viewRadius(rightBtn, 5.0, 0.5, UIColor.lightGray)
        contentView.addSubview(rightBtn)
        _ = rightBtn.sd_layout()?
            .topSpaceToView(line2,GET_SIZE * 10)?
            .bottomSpaceToView(contentView,GET_SIZE * 10)?
            .leftSpaceToView(leftBtn,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 200)
    }
    
    @objc private func click(_ click: UIButton) {
        
        delog(click.tag)
//        //按钮tag枚举
//        case cancelPayBtn = 800
//        case wantPayBtn,wantDrawBackBtn,equalOrderBtn,payOtherBtn,deleteOrderBtn,writeNoteBtn,connectionBtn
        
        switch click.tag {
            
        case MineOrderStateEnum.cancelPayBtn.rawValue:
            break
            
        case MineOrderStateEnum.wantPayBtn.rawValue:
            break
            
        case MineOrderStateEnum.wantDrawBackBtn.rawValue:
            break
            
        case MineOrderStateEnum.equalOrderBtn.rawValue:
            break
            
        case MineOrderStateEnum.payOtherBtn.rawValue:
            break
            
        case MineOrderStateEnum.deleteOrderBtn.rawValue:
            break
            
        case MineOrderStateEnum.writeNoteBtn.rawValue:
            break
            
        case MineOrderStateEnum.connectionBtn.rawValue:
            break
        default:
            break
        }
    }
}
