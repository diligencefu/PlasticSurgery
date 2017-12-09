//
//  NewDoctorStarTabCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/9/27.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewDoctorStarTabCell: Wx_baseTableViewCell {
    
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
    
    let store = UILabel()
    var star : WQLStarView? = nil
    let all = UILabel()
    let allIMG = UIImageView()
    let detail = UILabel()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildUI() {
        
        var sizes = CGSize()
        
        store.text = "0"
        store.textColor = getColorWithNotAlphe(0xFF640F)
        store.font = UIFont.systemFont(ofSize: GET_SIZE * 48)
        store.textAlignment = .left
        contentView.addSubview(store)
        sizes = getSizeOnLabel(store)
        _ = store.sd_layout()?
            .topSpaceToView(contentView,GET_SIZE * 20)?
            .leftSpaceToView(contentView,GET_SIZE * 32)?
            .widthIs(sizes.width)?
            .heightIs(GET_SIZE * 35)
        
        star = WQLStarView.init(frame: CGRect.init(x: GET_SIZE * 78,
                                                   y: GET_SIZE * 24,
                                                   width: GET_SIZE * 200,
                                                   height: GET_SIZE * 35),
                                withTotalStar: 5,
                                withTotalPoint: 5.0,
                                starSpace: Int(GET_SIZE * 10))
        star?.starAliment = .center
        star?.commentPoint = 5
        contentView.addSubview(star!)

        allIMG.image = UIImage(named:"00_go_icon_default")
        contentView.addSubview(allIMG)
        _ = allIMG.sd_layout()?
            .centerYEqualToView(store)?
            .rightSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 14)?
            .heightIs(GET_SIZE * 26)
        
        all.text = "查看全部评价"
        all.textColor = lightText
        all.font = UIFont.systemFont(ofSize: GET_SIZE * 32)
        all.textAlignment = .right
        contentView.addSubview(all)
        sizes = getSizeOnLabel(all)
        _ = all.sd_layout()?
            .centerYEqualToView(store)?
            .rightSpaceToView(contentView,GET_SIZE * 74)?
            .widthIs(sizes.width)?
            .heightIs(GET_SIZE * 34)
        
        detail.text = "环境:4.9  专业度:4.0  服务:4.9  效果:4.9"
        detail.textColor = lightText
        detail.font = UIFont.systemFont(ofSize: GET_SIZE * 32)
        detail.textAlignment = .left
        contentView.addSubview(detail)
        sizes = getSizeOnLabel(detail)
        _ = detail.sd_layout()?
            .bottomSpaceToView(contentView,GET_SIZE * 10)?
            .rightSpaceToView(contentView,GET_SIZE * 74)?
            .widthIs(sizes.width)?
            .heightIs(GET_SIZE * 34)
        
        
    }
}

