//
//  NewEditTableCollectionViewCell.swift
//  healthAndBeautyUser
//
//  Created by 丿番茄 on 2017/11/6.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewEditTableCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    //点击事件
    typealias swiftBlock = (_ id:String, _ name:String) -> Void
    var willClick : swiftBlock? = nil
    func callBackBlock(block: @escaping (_ id:String, _ name:String) -> Void ) {
        willClick = block
    }
    
    private var _model : Wx_twoTableModel?
    var model : Wx_twoTableModel? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    
    private func didSetModel(_ model: Wx_twoTableModel) {
        
        if model.isSelect {
            titleLabel.layer.borderColor = tabbarColor.cgColor
            titleLabel.layer.borderWidth = 0.5
            titleLabel.backgroundColor = tabbarColor
            titleLabel.textColor = UIColor.white
        }else {
            titleLabel.layer.borderColor = tabbarColor.cgColor
            titleLabel.layer.borderWidth = 0.5
            titleLabel.backgroundColor = UIColor.white
            titleLabel.textColor = tabbarColor
        }
        titleLabel.layer.cornerRadius = GET_SIZE * 24
        titleLabel.clipsToBounds = true
        titleLabel.text = model.name
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
