//
//  newMineOrderListTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/17.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewMineOrderListTableViewCell: Wx_baseTableViewCell {
    
    private var _model : newMineMessageModel?
    var model : newMineMessageModel? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    private func didSetModel(_ model: newSettingListModel) {
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func buildUI() {
        
}
