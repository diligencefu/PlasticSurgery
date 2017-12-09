//
//  NewLocationNillTabCell.swift
//  healthAndBeautyUser
//
//  Created by 丿番茄 on 2017/11/2.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewLocationNillTabCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let add = NewAddLocationViewController.init(nibName: "NewAddLocationViewController", bundle: nil)
        add.isAdd = true
        viewController()?.navigationController?.pushViewController(add, animated: true)
    }
}
