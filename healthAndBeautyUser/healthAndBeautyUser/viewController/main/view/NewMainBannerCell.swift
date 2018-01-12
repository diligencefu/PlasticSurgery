//
//  NewMainBannerCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/19.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewMainBannerCell: Wx_baseTableViewCell {
    var chooseAction:((String,String)->())?  //声明闭包

    func buildDataWithImages(images:[FYHSowMainADModel]) {
        
        var imageArr = [String]()
        var imageArr2 = [String]()
        var imageArr3 = [String]()
        for model in images {
            imageArr.append(model.infoBanner.imgUrl)
            imageArr2.append(model.infoBanner.linkUrl)
            imageArr3.append(model.infoBanner.name)
        }
        let model = NSMutableArray.init(array: imageArr)
        banner.removeFromSuperview()
        banner = ADView.init(frame:CGRect.init(x: 0, y: 0, width: WIDTH, height: GET_SIZE * 528),
                             andImageURLArray: model,
                             andIsRunning: true)
        banner.block = {
            delog($0)
            if self.chooseAction != nil {
//                for model in images {
//                    if model.id == "" {
//                    }
//                }
                self.chooseAction!(imageArr2[Int($0!)!-1],imageArr3[Int($0!)!-1])
            }
        }
        contentView.addSubview(banner)
    }

    func buildData() {
        
        let model = NSMutableArray.init(array: ["02_banner_link_default",
                                                "02_banner_link_default",
                                                "02_banner_link_default",
                                                "02_banner_link_default"])
        banner.removeFromSuperview()
        banner = ADView.init(frame:CGRect.init(x: 0, y: 0, width: WIDTH, height: GET_SIZE * 528),
                             andImageNameArray: model,
                             andIsRunning: true)
        banner.block = {
            delog($0)
            if self.chooseAction != nil {
                self.chooseAction!("","")
            }
        }
        contentView.addSubview(banner)
    }
    
    private var _model : NewMineMessageModel?
    var model : NewMineMessageModel? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    
    private func didSetModel(_ model: NewMineMessageModel) {
        
        
    }
    
    var banner = ADView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
