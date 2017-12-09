//
//  WXSelectTabCell.swift
//  WXselectPopModule
//
//  Created by  on 2017/9/16.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class selectModel : NSObject {
    
    var title = String()
    var id = String()
    var isSelect = Bool()
}

class WXSelectTabCell: UITableViewCell {
    
    var type = selectVar()

    //商品列表类别显示方法
    private var _cModel : NewStoreGoodsClassifies?
    var cModel : NewStoreGoodsClassifies? {
        didSet {
            _cModel = cModel
            self.didSetModel(cModel!)
        }
    }
    
    private func didSetModel(_ model: NewStoreGoodsClassifies) {
        
        title.text = model.goodClsName
        title.textColor = type.unSelectCellTitleColor
        select.isHidden = true
    }
    
    //商品筛选分类别表
    private var _model : selectModel?
    var model : selectModel? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    
    private func didSetModel(_ model: selectModel) {
        
        title.text = model.title
        if model.isSelect {
            title.textColor = orangeText
            select.isHidden = true
        }else {
            title.textColor = type.unSelectCellTitleColor
            select.isHidden = true
        }
    }
    
    let title = UILabel()
    let select = UIImageView()
    let line = UIView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        buildUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildUI() {
        
        title.font = type.cellFont
        title.frame = CGRect.init(x: GET_SIZE * 24,
                                  y: 0,
                                  width: WIDTH - 300,
                                  height: contentView.frame.size.height)
        contentView.addSubview(title)
        
        select.image = type.selectImage
        select.frame = CGRect.init(x: WIDTH - GET_SIZE * 36 * 2,
                                  y: (contentView.frame.size.height - GET_SIZE * 36) / 2,
                                  width: GET_SIZE * 36,
                                  height: GET_SIZE * 36)
        contentView.addSubview(select)
        
        line.frame = CGRect.init(x: 0,
                                 y: contentView.frame.size.height - 0.5,
                                 width: WIDTH,
                                 height: 0.5)
        contentView.addSubview(line)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            title.textColor = orangeText
        }else {
            title.textColor = type.unSelectCellTitleColor
        }
    }
}
