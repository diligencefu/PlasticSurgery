//
//  NewMainIconCollectionViewCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/19.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewMainIconCollectionViewCell: UICollectionViewCell {
    
    private var _model : iconModel?
    var model : iconModel? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    
    private func didSetModel(_ model: iconModel) {
        
        icon.image = UIImage(named: model.img)
        title.text = model.title
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    let icon = UIImageView()
    let title = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = backGroundColor
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildUI() {
        
        contentView.addSubview(icon)
        _ = icon.sd_layout()?
            .centerXEqualToView(contentView)?
            .topSpaceToView(contentView,GET_SIZE * 18)?
            .widthIs(GET_SIZE * 98)?
            .heightIs(GET_SIZE * 98)
        
        title.textColor = getColorWithNotAlphe(0x545454)
        title.font = UIFont.systemFont(ofSize: TEXT24)
        title.textAlignment = .center
        contentView.addSubview(title)
        _ = title.sd_layout()?
            .centerXEqualToView(contentView)?
            .topSpaceToView(contentView,GET_SIZE * 120)?
            .widthIs(contentView.width)?
            .heightIs(GET_SIZE * 28)
        
    }
}

