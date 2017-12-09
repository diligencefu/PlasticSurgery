//
//  Wx_CollectionViewHeader.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/21.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class Wx_CollectionViewHeader: UICollectionReusableView {

    let title = UILabel()
    let line = UIView()

    func setTitle(_ str: String) {
        
        title.text = str
        title.textColor = Wx_defaultText
        title.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        self.addSubview(title)
        _ = title.sd_layout()?
            .centerYEqualToView(self)?
            .leftSpaceToView(self,GET_SIZE * 24)?
            .widthIs(Wx_rightWidth)?
            .heightIs(GET_SIZE * 32)
        
        line.backgroundColor = lineColor
        self.addSubview(line)
        _ = line.sd_layout()?
            .topSpaceToView(self,0)?
            .leftSpaceToView(self,GET_SIZE * 24)?
            .rightSpaceToView(self,0)?
            .heightIs(0.5)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = Wx_selectBackColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
