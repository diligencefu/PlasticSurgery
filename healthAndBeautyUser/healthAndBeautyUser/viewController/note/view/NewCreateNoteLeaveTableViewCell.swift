//
//  NewCreateNoteLeaveTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/10/8.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewCreateNoteLeaveTableViewCell: Wx_baseTableViewCell {
    
    private var _model : swelling_pain_car?
    var model : swelling_pain_car? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    private func didSetModel(_ model: swelling_pain_car) {
        
        switch model {
        case .pain:
            titles.text = "疼痛感"
            break
        case .scar:
            titles.text = "疤痕度"
            break
        case .swelling:
            titles.text = "肿胀度"
            break
        default:
            break
        }
        
        let sizes = getSizeOnLabel(titles)
        _ = titles.sd_layout()?
            .centerYEqualToView(contentView)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(sizes.width)?
            .heightIs(sizes.height)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildUI()
    }
    
    let titles = UILabel()
    let detail = UILabel()
    var controller = XHStarRateView()
    let line = UIView()
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildUI() {
        
        titles.textColor = darkText
        titles.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        titles.textAlignment = .left
        contentView.addSubview(titles)
        
        weak var weakSelf = self
        controller = XHStarRateView.init(frame: CGRect.init(x: WIDTH-135,
                                                            y: 0,
                                                            width: 125,
                                                            height: GET_SIZE * 88),
                                         finish: { (value) in
            delog(value)
            weakSelf?.detail.text = "\(Int(value))"
            _ = weakSelf?.detail.sd_layout()?
                .centerYEqualToView(weakSelf?.contentView)?
                .rightSpaceToView(weakSelf?.controller,GET_SIZE * 24)?
                .widthIs(WIDTH/4)?
                .heightIs(GET_SIZE * 30)
            let controller = weakSelf?.viewController() as! NewNoteCreateViewController
                                            
            if weakSelf?._model == .pain {
                controller.pain = Int(value)
            }else if weakSelf?._model == .scar {
                controller.scar = Int(value)
            }else if weakSelf?._model == .swelling {
                controller.swelling = Int(value)
            }
        })
        controller.isAnimation = true
        contentView.addSubview(controller)
        
        detail.textColor = redText
        detail.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        detail.textAlignment = .right
        contentView.addSubview(detail)
        
        line.backgroundColor = lineColor
        contentView.addSubview(line)
        _ = line.sd_layout()?
            .bottomSpaceToView(contentView,0)?
            .leftSpaceToView(contentView,0)?
            .widthIs(WIDTH)?
            .heightIs(0.5)
    }
}
