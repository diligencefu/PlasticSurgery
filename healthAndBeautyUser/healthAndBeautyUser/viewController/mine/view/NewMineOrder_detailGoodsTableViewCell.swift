//
//  NewMineOrder_detailGoodsTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/26.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewMineOrder_detailGoodsTableViewCell: Wx_baseTableViewCell {
    
    private var _model : String?
    var model : String? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    
    private func didSetModel(_ model: String) {
        
        icon.image = UIImage(named:"banner_240")
        title.text = "【德国原装进口玻尿酸】 5Wml 驻颜魔法，德国品质，完美容颜只为你 德玛西亚"
        location.text = "武汉协和医院美容分院"
        payed.text = "小计 ￥ 518"
    }
    
    let icon = UIImageView()
    let title = UILabel()
    let location = UILabel()
    let payed = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildUI() {
        
        contentView.addSubview(icon)
        _ = icon.sd_layout()?
            .centerYEqualToView(contentView)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 175)?
            .heightIs(GET_SIZE * 175)
        
        title.textColor = UIColor.black
        title.font = UIFont.systemFont(ofSize: GET_SIZE * 32)
        title.textAlignment = .left
        title.numberOfLines = 0
        title.lineBreakMode = .byCharWrapping
        contentView.addSubview(title)
        _ = title.sd_layout()?
            .topEqualToView(icon)?
            .leftSpaceToView(icon,GET_SIZE * 24)?
            .rightSpaceToView(contentView,GET_SIZE * 24)?
            .heightIs(GET_SIZE * 90)
        
        location.textColor = UIColor.black
        location.font = UIFont.systemFont(ofSize: GET_SIZE * 22)
        contentView.addSubview(location)
        _ = location.sd_layout()?
            .topSpaceToView(title,0)?
            .leftSpaceToView(icon,GET_SIZE * 24)?
            .widthIs(WIDTH/3)?
            .heightIs(GET_SIZE * 24)
        
        payed.textColor = UIColor.black
        payed.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        payed.textAlignment = .left
        contentView.addSubview(payed)
        _ = payed.sd_layout()?
            .bottomEqualToView(icon)?
            .leftSpaceToView(icon,GET_SIZE * 24)?
            .widthIs(WIDTH/4)?
            .heightIs(GET_SIZE * 30)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
}
