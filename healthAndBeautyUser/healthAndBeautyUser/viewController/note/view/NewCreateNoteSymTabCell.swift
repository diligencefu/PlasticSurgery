//
//  NewCreateNoteSymTabCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/10/8.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewCreateNoteSymTabCell: NewCreateNoteSymptomTabCell {

    private var _model : [articleTagsAndArticleSymptomsModel]?
    var model : [articleTagsAndArticleSymptomsModel]? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    
    private func didSetModel(_ model: [articleTagsAndArticleSymptomsModel]) {
        
        dataSource = model
        collectionView.reloadData()
        
        line.removeFromSuperview()
    }
}
