//
//  Wx_titleCollectionViewCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/21.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class Wx_titleCollectionViewCell: UICollectionViewCell {
    
    private var _model : Wx_twoTableModel?
    var model : Wx_twoTableModel? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    
    private func didSetModel(_ model: Wx_twoTableModel) {
        
        
        
        title.text = model.name
        let size = getSizeOnLabel(title)
        _ = title.sd_layout()?
            .centerXEqualToView(contentView)?
            .centerYEqualToView(contentView)?
            .widthIs(size.width)?
            .heightIs(size.height)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    let title = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = Wx_CollectionText
        viewRadius(contentView, 4.0, 1, Wx_CollectionText)
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildUI() {
        
        title.backgroundColor = Wx_CollectionText
        title.textColor = Wx_lightText
        title.font = UIFont.systemFont(ofSize: TEXT24)
        title.textAlignment = .center
        contentView.addSubview(title)
    }
}
