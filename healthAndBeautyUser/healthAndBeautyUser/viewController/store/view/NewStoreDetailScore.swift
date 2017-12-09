//
//  NewStoreDetailScore.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/18.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewStoreDetailScore: Wx_baseTableViewCell {
    
    private var _model : NewStoreDetailModel?
    var model : NewStoreDetailModel? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    private func didSetModel(_ model: NewStoreDetailModel) {
        
        _ = totalScore.sd_layout()?
            .topSpaceToView(contentView,GET_SIZE * 24)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(WIDTH/2)?
            .heightIs(GET_SIZE * 40)
        
    }
    
    let totalScore = UILabel()
    let backStar = UIImageView()
    let star = UIImageView()
    let noteCount = UILabel()
    let environment = UILabel()
    let specal = UILabel()
    let service = UILabel()
    let result = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func buildUI() {
        
        totalScore.textColor = getColorWithNotAlphe(0xF1931A)
        totalScore.font = UIFont.systemFont(ofSize: TEXT36)
        contentView.addSubview(totalScore)
        
        backStar.backgroundColor = getColorWithNotAlphe(0xF1931A)
        contentView.addSubview(backStar)
        _ = backStar.sd_layout()?
            .centerYEqualToView(totalScore)?
            .leftSpaceToView(totalScore,5)?
            .widthIs(WIDTH)?
            .heightIs(0.5)
        
        star.image = UIImage(named:"")
        contentView.addSubview(star)
        _ = star.sd_layout()?
            .centerYEqualToView(totalScore)?
            .leftSpaceToView(totalScore,5)?
            .widthIs(WIDTH)?
            .heightIs(0.5)
        
        noteCount.textColor = UIColor.black
        noteCount.font = UIFont.systemFont(ofSize: TEXT24)
        contentView.addSubview(noteCount)
        _ = noteCount.sd_layout()?
            .centerYEqualToView(totalScore)?
            .rightSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(WIDTH/2)?
            .heightIs(GET_SIZE * 30)
        
        environment.textColor = UIColor.black
        environment.font = UIFont.systemFont(ofSize: TEXT24)
        contentView.addSubview(environment)
        _ = environment.sd_layout()?
            .topSpaceToView(totalScore,GET_SIZE * 16)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(WIDTH/2)?
            .heightIs(GET_SIZE * 30)
        
        specal.textColor = UIColor.black
        specal.font = UIFont.systemFont(ofSize: TEXT24)
        contentView.addSubview(specal)
        _ = specal.sd_layout()?
            .topSpaceToView(totalScore,GET_SIZE * 16)?
            .leftSpaceToView(environment,GET_SIZE * 24)?
            .widthIs(WIDTH/2)?
            .heightIs(GET_SIZE * 30)
        
        service.textColor = UIColor.black
        service.font = UIFont.systemFont(ofSize: TEXT24)
        contentView.addSubview(service)
        _ = service.sd_layout()?
            .topSpaceToView(totalScore,GET_SIZE * 16)?
            .leftSpaceToView(specal,GET_SIZE * 24)?
            .widthIs(WIDTH/2)?
            .heightIs(GET_SIZE * 30)
        
        result.textColor = UIColor.black
        result.font = UIFont.systemFont(ofSize: TEXT24)
        contentView.addSubview(result)
        _ = result.sd_layout()?
            .topSpaceToView(totalScore,GET_SIZE * 16)?
            .leftSpaceToView(service,GET_SIZE * 24)?
            .widthIs(WIDTH/2)?
            .heightIs(GET_SIZE * 30)
    }
}
