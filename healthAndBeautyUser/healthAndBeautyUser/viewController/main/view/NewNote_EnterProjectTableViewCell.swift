//
//  NewNote_EnterProjectTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/9/26.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewNote_EnterProjectTableViewCell: NewMainCaseListTableViewCell {

    //...
    private var _cModel : NewNoteEnterDetail_2Model?
    var cModel : NewNoteEnterDetail_2Model? {
        didSet {
            _cModel = cModel
            self.cDidSetModel(cModel!)
        }
    }
    
    private func cDidSetModel(_ model: NewNoteEnterDetail_2Model) {
        
        img.kf.setImage(with: StringToUTF_8InUrl(str: model.product.thumbnail))
        img.contentMode = .scaleAspectFill
        img.layer.masksToBounds = true
        
        title.text = "【\(model.product.productName)】\(model.product.productChildName)"
        hospital.removeFromSuperview()
        count.text = "预约数\(model.product.reservationCount)"
        newPrice.text = "\(model.product.disPrice)"
        oldPrice.text = "\(model.product.salaPrice)"
        
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
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let detail = NewStoresDetailViewController.init(nibName: "NewStoresDetailViewController", bundle: nil)
        detail.isProject = true
        detail.id = _cModel!.product.id
        viewController()?.navigationController?.pushViewController(detail, animated: true)
    }
}
