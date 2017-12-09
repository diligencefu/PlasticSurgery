//
//  NewStoreShopCarHeadView.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/9/4.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewStoreShopCarHeadView: UITableViewHeaderFooterView {

    var projectDateSource : [NewStoreShopCarModel] = []
    var productDateSource : [NewStoreShopCarModel] = []
    
    private var _isProject : Bool?
    var isProject : Bool? {
        didSet {
            _isProject = isProject
            self.didSetModel(isProject!)
        }
    }

    private func didSetModel(_ isProject: Bool) {
        
        var isAllSelect : Bool = true

        if isProject {
            
            type.text = "项目"
            //便利数据组所有数据 如果有一个数据没有被选中 那么该header也不会被选中
            for sub in projectDateSource {
                if !sub.isSelect {
                    isAllSelect = false
                    break
                }
            }
        }else {
            type.text = "产品"
            
            for sub in productDateSource {
                if !sub.isSelect {
                    isAllSelect = false
                    break
                }
            }
        }
        if isAllSelect {
            isSelect = true
            clickIMG.image = UIImage(named:"02_selector_selector_pressed")
        }else {
            isSelect = false
            clickIMG.image = UIImage(named:"01_selector_selector_default")
        }
    }
    
    var section = Int()
    
    let clickIMG = UIImageView()
    let type = UILabel()
    let line = UIView()

    private var isSelect = false
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildUI() {
        
        backgroundColor = UIColor.white
        
        clickIMG.image = UIImage(named:"01_selector_selector_default")
        contentView.addSubview(clickIMG)
        _ = clickIMG.sd_layout()?
            .centerYEqualToView(contentView)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 72)?
            .heightIs(GET_SIZE * 72)
        
        type.textColor = darkText
        type.font = UIFont.systemFont(ofSize: GET_SIZE * 30)
        type.textAlignment = .center
        contentView.addSubview(type)
        _ = type.sd_layout()?
            .centerYEqualToView(contentView)?
            .leftSpaceToView(clickIMG,GET_SIZE * 24)?
            .widthIs(WIDTH/7)?
            .heightIs(GET_SIZE * 38)
        
        line.backgroundColor = lineColor
        contentView.addSubview(line)
        _ = line.sd_layout()?
            .bottomSpaceToView(contentView,0)?
            .leftSpaceToView(contentView,0)?
            .widthIs(WIDTH)?
            .heightIs(0.5)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        if _isProject! {
            
            for sub in projectDateSource {
                if isSelect {
                    sub.isSelect = false
                }else{
                    sub.isSelect = true
                }
            }
        }else {
            
            for sub in productDateSource {
                if isSelect {
                    sub.isSelect = false
                }else{
                    sub.isSelect = true
                }
            }
        }
        let view = viewController() as! NewShoppingCarViewController
        view.rebuildBottomData()
    }
}
