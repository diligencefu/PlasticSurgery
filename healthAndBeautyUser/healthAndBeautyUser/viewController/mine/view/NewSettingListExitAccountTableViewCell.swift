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
        quite.backgroundColor = tabbarColor
        quite.setTitleColor(UIColor.white, for: .normal)
        quite.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        quite.addTarget(self, action: #selector(quiteAccount), for: .touchUpInside)
        viewRadius(quite, 5.0, 0, tabbarColor)
        contentView.addSubview(quite)
        _ = quite.sd_layout()?
            .bottomSpaceToView(contentView,GET_SIZE * 150)?
            .centerXEqualToView(contentView)?
            .widthIs(320)?
            .heightIs(49)
    }
    
    @objc private func quiteAccount() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: SuccessRefreshNotificationCenter_Login), object: self, userInfo: nil)

        delog("退出当前账号")
        Defaults.remove("SESSIONID")
        viewController()?.navigationController?.popToRootViewController(animated: true)
    }
}
