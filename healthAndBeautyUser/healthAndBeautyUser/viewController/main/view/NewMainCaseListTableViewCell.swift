//
//  NewMainCaseListTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/9/2.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import Kingfisher

class NewMainCaseListTableViewCell: Wx_baseTableViewCell {
    
    private var _model : NewMain_ProjectListModel?
    var model : NewMain_ProjectListModel? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    
    private func didSetModel(_ model: NewMain_ProjectListModel) {
        
        img.kf.setImage(with: URL.init(string: model.thumbnail))
        title.text = "【\(model.productName)】\(model.productChildName)"
        hospital.text = model.doctorNames
        count.text = "预约数\(model.reservationCount)"
        newPrice.text = "\(model.disPrice)"
        oldPrice.text = "\(model.salaPrice)"
        
        //价格
        var sizes = getSizeOnLabel(newPrice)
        _ = newPrice.sd_layout()?
            .topSpaceToView(contentView,GET_SIZE * 175)?
            .leftSpaceToView(img,GET_SIZE * 24)?
            .widthIs(sizes.width)?
            .heightIs(sizes.height)
        
        sizes = getSizeOnLabel(oldPrice)
        _ = oldPrice.sd_layout()?
            .centerYEqualToView(newPrice)?
            .leftSpaceToView(newPrice,GET_SIZE * 24)?
            .widthIs(sizes.width)?
            .heightIs(sizes.height)
        line2.backgroundColor = lightText
        oldPrice.addSubview(line2)
        _ = line2.sd_layout()?
            .centerYEqualToView(oldPrice)?
            .centerXEqualToView(oldPrice)?
            .widthIs(sizes.width+4)?
            .heightIs(0.5)
        
        if !model.isAD {
            type.isHidden = true
        }
    }
    
    let img = UIImageView()
    
    let title = UILabel()
    let hospital = UILabel()
    let count = UILabel()
    let newPrice = UILabel()
    let oldPrice = UILabel()
    let type = UILabel()
    
    let line = UIView()
    let line2 = UIView()

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
            .centerYEqualToView(contentView)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 200)?
            .heightIs(GET_SIZE * 200)
        viewRadius(img, 5.0, 0.5, lineColor)
        
        //标签
        title.textColor = darkText
        title.numberOfLines = 0
        title.font = UIFont.systemFont(ofSize: TEXT32)
        contentView.addSubview(title)
        _ = title.sd_layout()?
            .topSpaceToView(contentView,GET_SIZE * 30)?
            .leftSpaceToView(img,GET_SIZE * 24)?
            .rightSpaceToView(contentView,GET_SIZE * 30)?
            .heightIs(GET_SIZE * 78)
        
        //医院
        hospital.textColor = lightText
        hospital.font = UIFont.systemFont(ofSize: TEXT24)
        contentView.addSubview(hospital)
        _ = hospital.sd_layout()?
            .topSpaceToView(title,4)?
            .leftSpaceToView(img,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 300)?
            .heightIs(GET_SIZE * 26)
        
        //数量
        count.textColor = lightText
        count.font = UIFont.systemFont(ofSize: TEXT24)
        count.textAlignment = .left
        contentView.addSubview(count)
        _ = count.sd_layout()?
            .topSpaceToView(hospital,2)?
            .rightSpaceToView(contentView,GET_SIZE * 30)?
            .leftSpaceToView(img,GET_SIZE * 24)?
            .heightIs(GET_SIZE * 26)
        
        //价格
        newPrice.textColor = redText
        newPrice.font = UIFont.systemFont(ofSize: GET_SIZE * 40)
        contentView.addSubview(newPrice)
        _ = newPrice.sd_layout()?
            .topSpaceToView(contentView,GET_SIZE * 175)?
            .leftSpaceToView(img,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 200)?
            .heightIs(GET_SIZE * 44)
        
        oldPrice.textColor = lightText
        oldPrice.font = UIFont.systemFont(ofSize: GET_SIZE * 30)
        contentView.addSubview(oldPrice)
        _ = oldPrice.sd_layout()?
            .centerYEqualToView(newPrice)?
            .leftSpaceToView(newPrice,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 200)?
            .heightIs(GET_SIZE * 32)
        
        type.textColor = blueText
        type.backgroundColor = backGroundColor
        type.text = "广告"
        type.font = UIFont.systemFont(ofSize: GET_SIZE * 20)
        type.textAlignment = .center
        contentView.addSubview(type)
        _ = type.sd_layout()?
            .centerYEqualToView(newPrice)?
            .rightSpaceToView(contentView,GET_SIZE * 30)?
            .widthIs(GET_SIZE * 72)?
            .heightIs(GET_SIZE * 28)
        viewRadius(type, Float(GET_SIZE * 14), 0.5, blueText)
        
        line.backgroundColor = lineColor
        contentView.addSubview(line)
        _ = line.sd_layout()?
            .bottomSpaceToView(contentView,0)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(WIDTH)?
            .heightIs(0.5)
    }
    
    func buildModel() {
        
        img.image = UIImage(named:"01_project_image_default")
        
        title.text = "【毛发种植】武汉公立医院名医&一秒柳岩---二秒外星人"
        title.numberOfLines = 0
        title.lineBreakMode = .byCharWrapping
        hospital.text = "武汉新医美医院"
        count.text = "预约数：560"
        newPrice.text = "￥1755"
        oldPrice.text = "￥4576"
    }
}
