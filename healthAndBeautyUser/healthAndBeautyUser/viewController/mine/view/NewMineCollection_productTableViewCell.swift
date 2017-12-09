//
//  NewMineCollection_productTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/29.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewMineCollection_productTableViewCell: NewsStoreProjectListTableViewCell {

    private var _model : NewMineMessageModel?
    var model : NewMineMessageModel? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    private func didSetModel(_ model: NewMineMessageModel) {
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func buildUI() {
        
        storeIMG.removeFromSuperview()
        store.removeFromSuperview()
        experienceIMG.removeFromSuperview()
        experience.removeFromSuperview()
    }
}
