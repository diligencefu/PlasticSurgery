//
//  Wx_bottomGotoView.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/9/4.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class Wx_bottomGotoView: UIView {

    typealias swiftBlock = (_ type:String) -> Void
    var willClick : swiftBlock? = nil
    func callBackBlock(block: @escaping (_ type:String) -> Void ) {
        willClick = block
    }
    
    var heights = Float()
    var widths = Float()
    var mainColor = UIColor()
    var leftWidth = Float()

    var price = String()
    
    func reBuildUI() {
        
        var sizes = CGSize()
        
        _ = controllerBtn.sd_layout()?
            .bottomSpaceToView(self,GET_SIZE * 150)?
            .leftSpaceToView(self,CGFloat(widths))?
            .rightSpaceToView(self,0)?
            .heightIs(CGFloat(heights))
        
        detail.text = "合计:"
        sizes = getSizeOnLabel(detail)
        _ = detail.sd_layout()?
            .centerYEqualToView(self)?
            .leftSpaceToView(self,GET_SIZE * 24)?
            .widthIs(sizes.width)?
            .heightIs(CGFloat(heights))
        
        priceLab.text = "￥ \(price)元"
        sizes = getSizeOnLabel(priceLab)
        _ = priceLab.sd_layout()?
            .centerYEqualToView(self)?
            .leftSpaceToView(detail,3)?
            .widthIs(sizes.width)?
            .heightIs(CGFloat(heights))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var line = UIView()
    private var detail = UILabel()
    private var priceLab = UILabel()
    private var controllerBtn = UIButton()
    
    private func buildUI() {
        
        line.backgroundColor = lineColor
        self.addSubview(line)
        _ = line.sd_layout()?
            .topSpaceToView(self,0)?
            .leftSpaceToView(self,0)?
            .widthIs(CGFloat(widths))?
            .heightIs(0.5)

        controllerBtn.setTitle("结算", for: .normal)
        controllerBtn.backgroundColor = backGroundColor
        controllerBtn.setTitleColor(tabbarColor, for: .normal)
        controllerBtn.titleLabel?.font = UIFont.systemFont(ofSize: GET_SIZE * 32)
        controllerBtn.addTarget(self, action: #selector(clickGo), for: .touchUpInside)
        self.addSubview(controllerBtn)
        
        
        detail.textColor = darkText
        detail.font = UIFont.systemFont(ofSize: GET_SIZE * 32)
        detail.textAlignment = .left
        self.addSubview(detail)

        
        priceLab.textColor = redText
        priceLab.font = UIFont.systemFont(ofSize: GET_SIZE * 36)
        priceLab.textAlignment = .left
        self.addSubview(priceLab)
    }
    
    @objc private func clickGo() {
        
        if willClick != nil {
            willClick!("goto")
        }
    }
}
