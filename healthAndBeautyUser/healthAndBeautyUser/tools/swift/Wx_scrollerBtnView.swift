//
//  wx_scrollerBtnView.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/16.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class Wx_scrollerBtnView: UIView {
    
    var index = -1
    
    typealias swiftBlock = (_ message:String) -> Void
    var willClick : swiftBlock? = nil
    func callBackBlock(block: @escaping ( _ message:String) -> Void ) {
        willClick = block
    }
    
    private let currentView = UIView()
    
    var btnArray = [String]()
    var currentBtn = -1
    var btnColor = UIColor()
    var scrollerViewColor = UIColor()
    var scrollerViewHeight = CGFloat()
    
    var isShowBottomView = true
    
    private var btnSource = [UIButton]()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildUI() {
        
        _ = self.subviews.map {
            $0.removeFromSuperview()
        }
        
        backgroundColor = backGroundColor
        
        addSubview(currentView)
        currentView.backgroundColor = scrollerViewColor

        for index in 0..<btnArray.count {
            
            let btn = UIButton()
            btn.setTitle(btnArray[index], for: .normal)
            btn.backgroundColor = backGroundColor
            btn.setTitleColor(btnColor, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: GET_SIZE * 32)
            btn.tag = 456 + index
            btn.addTarget(self, action: #selector(click(_:)), for: .touchUpInside)
            addSubview(btn)
            let size = getSize(btn.titleLabel!)
            _ = btn.sd_layout()?
                .topSpaceToView(self,0)?
                .leftSpaceToView(self,CGFloat(Int(self.width) / btnArray.count * index))?
                .widthIs(self.width / CGFloat(btnArray.count))?
                .heightIs(self.height - scrollerViewHeight)
            btnSource.append(btn)
            
            if currentBtn == index && isShowBottomView {
                
                btn.setTitleColor(getColorWithNotAlphe(0xF1931A), for: .normal)
                _ = currentView.sd_layout()?
                    .centerXEqualToView(btn)?
                    .topSpaceToView(btn,0)?
                    .widthIs(size.width)?
                    .heightIs(scrollerViewHeight)
            }else {
                btn.setTitleColor(btnColor, for: .normal)
            }
            
            if !isShowBottomView {
                
                let img = UIImageView()
                img.image = UIImage(named:"Selected")
                btn.addSubview(img)
                _ = img.sd_layout()?
                    .centerYEqualToView(btn)?
                    .leftSpaceToView(btn.titleLabel,GET_SIZE * 15)?
                    .widthIs(GET_SIZE * 25)?
                    .heightIs(GET_SIZE * 25)
            }
        }
        
        if currentBtn == -1 && isShowBottomView {
            let btn = btnSource[0]
            let size = getSize(btn.titleLabel!)
            _ = currentView.sd_layout()?
                .centerXEqualToView(btn)?
                .topSpaceToView(btn,0)?
                .widthIs(size.width)?
                .heightIs(scrollerViewHeight)
        }
        
        let line = UIView()
        line.backgroundColor = lineColor
        self.addSubview(line)
        _ = line.sd_layout()?
            .bottomSpaceToView(self,0)?
            .leftSpaceToView(self,0)?
            .widthIs(self.width)?
            .heightIs(0.5)
    }
    
    @objc private func click(_ click: UIButton) {
        
        index = click.tag - 456
        currentBtn = click.tag - 456
        for btn in btnSource {
            btn.setTitleColor(btnColor, for: .normal)
        }
        
        UIView.animate(withDuration: 0.25, animations: {
            
            click.setTitleColor(getColorWithNotAlphe(0xF1931A), for: .normal)
            self.currentView.centerX = click.centerX
        }, completion: nil)
        
        if nil != willClick {
            willClick!(btnArray[click.tag-456])
        }
    }
    
    private func getSize(_ labelStr: UILabel) -> CGSize {
        
        let content = labelStr.text! as NSString
        let attributes = [NSFontAttributeName: labelStr.font]
        // 返回结果的rect
        var size = CGRect()
        //得到结果
        size = content.boundingRect(with: CGSize(width: WIDTH,
                                                 height: CGFloat(MAXFLOAT)),
                                    options: .usesLineFragmentOrigin,
                                    attributes: attributes,
                                    context: nil )
        return size.size
    }
}
