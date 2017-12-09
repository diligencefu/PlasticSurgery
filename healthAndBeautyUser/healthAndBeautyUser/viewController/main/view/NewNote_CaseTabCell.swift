//
//  NewNote_CaseTabCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/9/25.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import Kingfisher

//数据不一样 重写setget方法
class NewNote_CaseTabCell: NewMainCaseListTableViewCell {

    private var _dModel : NewNoteDetail_2Model_Product?
    var dModel : NewNoteDetail_2Model_Product? {
        didSet {
            _dModel = dModel
            self.dDidSetModel(dModel!)
        }
    }
    
    private func dDidSetModel(_ model: NewNoteDetail_2Model_Product) {

        img.kf.setImage(with: StringToUTF_8InUrl(str: model.thumbnail))
        img.contentMode = .scaleAspectFill
        img.layer.masksToBounds = true
        
        title.text = "【\(model.productName)】\(model.productChildName)"
        hospital.removeFromSuperview()
        count.text = "预约数\(model.reservationCount)"
        newPrice.text = "\(model.disPrice)"
        oldPrice.text = "\(model.salaPrice)"
        
        var sizes = getSizeOnLabel(newPrice)
        //价格
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
            .leftSpaceToView(oldPrice,0)?
            .widthIs(sizes.width+4)?
            .heightIs(0.5)
        
        type.isHidden = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let detail = NewStoresDetailViewController.init(nibName: "NewStoresDetailViewController", bundle: nil)
        detail.isProject = true
        detail.id = _dModel!.id
        viewController()?.navigationController?.pushViewController(detail, animated: true)
    }
}
