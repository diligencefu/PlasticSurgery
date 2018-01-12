//
//  NewMain_freeTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/21.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewMain_freeTableViewCell: NewsStoreProjectListTableViewCell {
    
//    private var _model : NewMineMessageModel?
//    var model : NewMineMessageModel? {
//        didSet {
//            _model = model
//            self.didSetModel(model!)
//        }
//    }
//    private func didSetModel(_ model: NewMineMessageModel) {
//        
//    }
    
    let ADModel = FYHSowMainADModel()
    
    
    let buyIMG = UIImageView()
    let buy = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func buildUI() {
        
        //返券
        contentView.addSubview(buyIMG)
        _ = buyIMG.sd_layout()?
            .topSpaceToView(storeIMG,GET_SIZE * 18)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 20)?
            .heightIs(GET_SIZE * 20)
        
        buy.textColor = UIColor.black
        buy.font = UIFont.systemFont(ofSize: GET_SIZE * 20)
        contentView.addSubview(buy)
        _ = buy.sd_layout()?
            .centerYEqualToView(buyIMG)?
            .leftSpaceToView(buyIMG,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 400)?
            .heightIs(GET_SIZE * 21)
    }
    override func buildModel() {
        super.buildModel()
        buyIMG.image = UIImage(named:"delete")
        buy.text = "会员购买后可返款,分12期返还"
    }
}

