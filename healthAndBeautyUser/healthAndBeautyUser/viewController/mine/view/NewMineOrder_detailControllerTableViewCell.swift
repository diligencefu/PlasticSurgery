//
//  NewMineOrder_detailControllerTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/26.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewMineOrder_detailControllerTableViewCell: Wx_baseTableViewCell {
    
    private var _model : String?
    var model : String? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    
    private func didSetModel(_ model: String) {
        
        title.text = "武汉雍和直发"
        other.setImage(UIImage(named:"Selected"), for: .normal)
    }
    
    let icon = UIImageView()
    let title = UILabel()
    let other = UIButton()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildUI() {
        
        icon.image = UIImage(named:"Selected")
        contentView.addSubview(icon)
        _ = icon.sd_layout()?
            .centerYEqualToView(contentView)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(10)?
            .heightIs(10)
        
        title.textColor = UIColor.black
        title.font = UIFont.systemFont(ofSize: GET_SIZE * 32)
        title.textAlignment = .left
        contentView.addSubview(title)
        _ = title.sd_layout()?
            .centerYEqualToView(contentView)?
            .leftSpaceToView(icon,GET_SIZE * 24)?
            .widthIs(WIDTH/2)?
            .heightIs(32)
        
        contentView.addSubview(other)
        other.addTarget(self, action: #selector(click), for: .touchUpInside)
        _ = other.sd_layout()?
            .centerYEqualToView(contentView)?
            .rightSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 44)?
            .heightIs(GET_SIZE * 44)
        
        let line = UIView()
        line.backgroundColor = lineColor
        contentView.addSubview(line)
        _ = line.sd_layout()?
            .bottomSpaceToView(contentView,0)?
            .leftSpaceToView(contentView,0)?
            .widthIs(WIDTH)?
            .heightIs(0.5)
    }
    
    @objc private func click() {
        
    }
}

