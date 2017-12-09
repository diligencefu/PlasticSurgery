//
//  NewNote_ThreePictrueTabCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/9/25.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewNote_ThreePictrueTabCell: UITableViewCell {

    private var _model : [String]?
    var model : [String]? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    
    private func didSetModel(_ model: [String]) {
        
        for index in 0 ..< model.count {
            
            let img = contentView.viewWithTag(900+index) as! UIImageView
            img.contentMode = .scaleAspectFill
            img.layer.masksToBounds = true
            img.kf.setImage(with: URL.init(string: model[index]))
            
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(click(_:)))
            img.addGestureRecognizer(tap)
            img.isUserInteractionEnabled = true
            
            tmp.append(img)
        }
    }
    
    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    
    var tmp = [UIImageView]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @objc private func click(_ tap: UITapGestureRecognizer) {
        
        var itemArr = [KSPhotoItem]()
        
        for index in 0..<tmp.count {
            
            let watchIMGItem = KSPhotoItem.init(sourceView: tmp[index], image: tmp[index].image)
            itemArr.append(watchIMGItem!)
        }
        
        let watchIMGView = KSPhotoBrowser.init(photoItems: itemArr,
                                               selectedIndex: UInt((tap.view?.tag)! - 900))
        watchIMGView?.dismissalStyle = .scale
        watchIMGView?.backgroundStyle = .blurPhoto
        watchIMGView?.loadingStyle = .indeterminate
        watchIMGView?.pageindicatorStyle = .text
        watchIMGView?.bounces = false
        watchIMGView?.show(from: viewController()!)
    }
}
