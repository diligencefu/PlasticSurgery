//
//  newSettingListExitAccountTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/15.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewSettingListExitAccountTableViewCell: Wx_baseTableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func buildUI() {
        
        let quite = UIButton()
        quite.setTitle("退出当前账号", for: .normal)
        quite.backgroundColor = backGroundColor
        quite.setTitleColor(getColorWithNotAlphe(0xF1931A), for: .normal)
        quite.titleLabel?.font = UIFont.systemFont(ofSize: GET_SIZE * 32)
        viewRadius(quite, 5.0, 0.5, UIColor.lightGray)
        contentView.addSubview(quite)
        _ = quite.sd_layout()?
            .bottomSpaceToView(contentView,GET_SIZE * 150)?
            .centerXEqualToView(contentView)?
            .widthIs(GET_SIZE * 650)?
            .heightIs(GET_SIZE * 68)
    }
}
