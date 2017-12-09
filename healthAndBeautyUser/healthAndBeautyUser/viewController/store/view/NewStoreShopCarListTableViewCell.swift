//
//  NewStoreShopCarListTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/9/2.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

//数据交换用
protocol shoppingCarDelegate {
    
}

class NewStoreShopCarListTableViewCell: Wx_baseTableViewCell {
    
//    weak var weakDelegate : NewStoreShopCarViewController?

    private var _model : NewStoreShopCarModel?
    var model : NewStoreShopCarModel? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    
    private func didSetModel(_ model: NewStoreShopCarModel) {
        
        img.kf.setImage(with: StringToUTF_8InUrl(str: model.thumbnail))
        img.contentMode = .scaleAspectFill
        
        title.text = "【\(model.goodName)】 \(model.goodChildName)"
        hospital.text = model.doctorName
        
        newPrice.text = "￥ \(model.payPrice)"
        add.value = Double(model.num)
        
        if isProject {
            otherLab.isHidden = false
            otherLab.text = "预约金小计: ￥\(model.payPrice * 0.1)"
        }else {
            otherLab.isHidden = true
        }
        
        if model.isSelect {
            
            select.isSelected = true
        }
    }
    
    var isProject = Bool()
    var indexPath = IndexPath()
    
    let select = Wx_selectBtn()
    let img = UIImageView()
    
    let title = UILabel()
    let hospital = UILabel()
    let newPrice = UILabel()
    let otherLab = UILabel()
    
    let add = UIStepper()
    
    let line = UIView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildUI() {
        
        select.setImage(UIImage(named:"01_selector_selector_default"), for: .normal)
        select.setImage(UIImage(named:"02_selector_selector_pressed"), for: .selected)
        select.addTarget(self, action: #selector(clickSelect), for: .touchUpInside)
//        viewRadius(select, 5.0, 0.5, UIColor.lightGray)
        contentView.addSubview(select)
        _ = select.sd_layout()?
            .leftEqualToView(contentView)?
            .centerYEqualToView(contentView)?
            .widthIs(GET_SIZE * 72)?
            .heightIs(GET_SIZE * 72)
        
        //图像
        contentView.addSubview(img)
        _ = img.sd_layout()?
            .topSpaceToView(contentView,GET_SIZE * 24)?
            .leftSpaceToView(select,GET_SIZE * 24)?
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
            .topSpaceToView(title,6)?
            .leftSpaceToView(img,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 300)?
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
        
        //医院
        otherLab.textColor = lightText
        otherLab.font = UIFont.systemFont(ofSize: TEXT24)
        contentView.addSubview(otherLab)
        _ = otherLab.sd_layout()?
            .topSpaceToView(img,6)?
            .leftSpaceToView(contentView,GET_SIZE * 80)?
            .widthIs(GET_SIZE * 300)?
            .heightIs(GET_SIZE * 26)
        
        add.minimumValue = 1
        add.tintColor = tabbarColor
        add.wraps = false
        contentView.addSubview(add)
        add.addTarget(self, action: #selector(stepperChangeValue(_:)), for: .valueChanged)
        _ = add.sd_layout()?
            .bottomSpaceToView(contentView,GET_SIZE * 16)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 216)?
            .heightIs(GET_SIZE * 56)
        
        line.backgroundColor = lineColor
        contentView.addSubview(line)
        _ = line.sd_layout()?
            .bottomSpaceToView(contentView,0)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(WIDTH)?
            .heightIs(0.5)
    }
    
    @objc private func stepperChangeValue( _ step: UIStepper) {
        
        delog(step.value)
    }
    @objc private func clickSelect() {
        
//        if weakDelegate != nil && select.isSelected{
        
//            //获得代理的数据  并且修改
//            if indexPath.section < weakDelegate!.projectHostpitalArr.count {
//
//                let model = weakDelegate!.projectDateSource[indexPath.section][indexPath.row] as? NewStoreShopCarModel
//                model?.isSelect = true
//            }else {
//                let model = weakDelegate!.productDateSource[indexPath.section - weakDelegate!.projectHostpitalArr.count][indexPath.row] as? NewStoreShopCarModel
//                model?.isSelect = true
//            }
//        }else {
//            if indexPath.section < weakDelegate!.projectHostpitalArr.count {
//
//                let model = weakDelegate!.projectDateSource[indexPath.section][indexPath.row] as? NewStoreShopCarModel
//                model?.isSelect = false
//            }else {
//                let model = weakDelegate!.productDateSource[indexPath.section - weakDelegate!.projectHostpitalArr.count][indexPath.row] as? NewStoreShopCarModel
//                model?.isSelect = false
//            }
//        }
        select.isSelected = !select.isSelected;
//        weakDelegate?.tableView.reloadData()
    }
}
