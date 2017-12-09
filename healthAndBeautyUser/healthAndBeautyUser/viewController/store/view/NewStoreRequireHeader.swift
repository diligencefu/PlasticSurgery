//
//  NewStoreRequireHeader.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/9/5.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewStoreRequireHeader: UITableViewHeaderFooterView {
    
    private var _model : String?
    var model : String? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    
    private func didSetModel(_ arr: String) {
        
        hospital.text = arr
    }
    
    let clickIMG = UIImageView()
    let hospital = UILabel()
    let line = UIView()
    
    private var isSelect = false
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildUI() {
        
        clickIMG.image = UIImage(named:"01_Hospital_icon_default")
        contentView.addSubview(clickIMG)
        _ = clickIMG.sd_layout()?
            .centerYEqualToView(contentView)?
            .leftSpaceToView(contentView,0)?
            .widthIs(GET_SIZE * 72)?
            .heightIs(GET_SIZE * 72)
        
        hospital.textColor = darkText
        hospital.font = UIFont.systemFont(ofSize: GET_SIZE * 30)
        hospital.textAlignment = .left
        contentView.addSubview(hospital)
        _ = hospital.sd_layout()?
            .centerYEqualToView(contentView)?
            .leftSpaceToView(clickIMG,GET_SIZE * 24)?
            .widthIs(WIDTH/4)?
            .heightIs(GET_SIZE * 30)
        
        line.backgroundColor = lineColor
        contentView.addSubview(line)
        _ = line.sd_layout()?
            .bottomSpaceToView(contentView,0)?
            .leftSpaceToView(contentView,0)?
            .widthIs(WIDTH)?
            .heightIs(0.5)
    }
}
