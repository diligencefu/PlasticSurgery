//
//  NewStoreListTabCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/10/16.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewStoreListTabCell: NewMainCaseListTableViewCell {
    
    private var _projectModel : NewStoreProjectModel?
    var projectModel : NewStoreProjectModel? {
        didSet {
            _projectModel = projectModel
            self.didSetProjectModel(projectModel!)
        }
    }
    
    private func didSetProjectModel(_ model: NewStoreProjectModel) {
        
        img.kf.setImage(with: StringToUTF_8InUrl(str: model.thumbnail))
        title.text = "【\(model.productName)】\(model.productChildName)"
        hospital.text = model.doctorNames
        count.text = "预约数: \(model.reservationCount)"
        newPrice.text = "\(model.disPrice)"
        oldPrice.text = "\(model.salaPrice)"
        
        var sizes = getSizeOnLabel(newPrice)
        _ = newPrice.sd_layout()?
            .topSpaceToView(contentView,GET_SIZE * 175)?
            .leftSpaceToView(img,GET_SIZE * 24)?
            .widthIs(sizes.width)?
            .heightIs(GET_SIZE * 44)
        sizes = getSizeOnLabel(oldPrice)
        _ = oldPrice.sd_layout()?
            .centerYEqualToView(newPrice)?
            .leftSpaceToView(newPrice,GET_SIZE * 24)?
            .widthIs(sizes.width)?
            .heightIs(GET_SIZE * 32)
        line2.backgroundColor = lightText
        oldPrice.addSubview(line2)
        _ = line2.sd_layout()?
            .centerYEqualToView(oldPrice)?
            .centerXEqualToView(oldPrice)?
            .widthIs(sizes.width+4)?
            .heightIs(0.5)
        type.isHidden = true
    }
    
    private var _goodsModel : NewStoreGoodsModel?
    var goodsModel : NewStoreGoodsModel? {
        didSet {
            _goodsModel = goodsModel
            self.didSetGoodsModel(goodsModel!)
        }
    }
    
    private func didSetGoodsModel(_ model: NewStoreGoodsModel) {
        
        img.kf.setImage(with: StringToUTF_8InUrl(str: model.thumbnail))
        title.text = "【\(model.goodItemName)】\(model.goodItemChildName)"
        hospital.text = model.goodItemDescrible
        count.text = "已售: \(model.reservationCount)"
        newPrice.text = "\(model.disPrice)"
        oldPrice.text = "\(model.salaPrice)"
        
        var sizes = getSizeOnLabel(newPrice)
        _ = newPrice.sd_layout()?
            .topSpaceToView(contentView,GET_SIZE * 175)?
            .leftSpaceToView(img,GET_SIZE * 24)?
            .widthIs(sizes.width)?
            .heightIs(GET_SIZE * 44)
        sizes = getSizeOnLabel(oldPrice)
        _ = oldPrice.sd_layout()?
            .centerYEqualToView(newPrice)?
            .leftSpaceToView(newPrice,GET_SIZE * 24)?
            .widthIs(sizes.width)?
            .heightIs(GET_SIZE * 32)
        line2.backgroundColor = lightText
        oldPrice.addSubview(line2)
        _ = line2.sd_layout()?
            .centerYEqualToView(oldPrice)?
            .centerXEqualToView(oldPrice)?
            .widthIs(sizes.width+4)?
            .heightIs(0.5)
        type.isHidden = true
    }
}
