//
//  NewNoteSelectoOrderTabCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/9/20.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewNoteSelectoOrderTabCell: Wx_baseTableViewCell {
    
    private var _model : NewChoseOrderModel?
    var model : NewChoseOrderModel? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    private func didSetModel(_ model: NewChoseOrderModel) {
        
        img.kf.setImage(with: URL.init(string: model.thumbnail))
        
        title.text = "【\(model.productName)】\(model.productChildName)"
        title.numberOfLines = 0
        title.lineBreakMode = .byCharWrapping
        
        var doctorStr = String()
        for index in model.doctor {
            doctorStr += index
            doctorStr += "  "
        }
        
        doctor.text = doctorStr

        count.text = " x \(model.num)"
        project.text = "\(model.projectName)"
        Price.text = "￥ \(model.paidPrice)"
    }
    
    let img = UIImageView()
    
    let title = UILabel()
    let doctor = UILabel()
    let count = UILabel()
    let project = UILabel()
    let Price = UILabel()
    
    let line = UIView()
    
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
            .topSpaceToView(contentView,GET_SIZE * 26)?
            .leftSpaceToView(img,GET_SIZE * 24)?
            .rightSpaceToView(contentView,GET_SIZE * 30)?
            .heightIs(GET_SIZE * 78)
        
        //医院
        doctor.textColor = lightText
        doctor.font = UIFont.systemFont(ofSize: TEXT24)
        contentView.addSubview(doctor)
        _ = doctor.sd_layout()?
            .topSpaceToView(title,4)?
            .leftSpaceToView(img,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 200)?
            .heightIs(GET_SIZE * 26)
        
        //数量
        count.textColor = getColorWithNotAlphe(0x707070)
        count.font = UIFont.systemFont(ofSize: TEXT24)
        count.textAlignment = .right
        contentView.addSubview(count)
        _ = count.sd_layout()?
            .topSpaceToView(title,4)?
            .rightSpaceToView(contentView,GET_SIZE * 30)?
            .leftSpaceToView(contentView,GET_SIZE * 600)?
            .heightIs(GET_SIZE * 26)
        
        //项目
        project.textColor = lightText
        project.font = UIFont.systemFont(ofSize: GET_SIZE * 26)
        contentView.addSubview(project)
        _ = project.sd_layout()?
            .topSpaceToView(doctor,2)?
            .leftSpaceToView(img,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 300)?
            .heightIs(GET_SIZE * 26)
        
        Price.textColor = redText
        Price.font = UIFont.systemFont(ofSize: GET_SIZE * 38)
        contentView.addSubview(Price)
        _ = Price.sd_layout()?
            .topSpaceToView(project,6)?
            .leftSpaceToView(img,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 300)?
            .heightIs(GET_SIZE * 44)
        
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
        doctor.text = "李柏林"
        count.text = " X 10"
    }
}
