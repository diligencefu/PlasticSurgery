//
//  NewRequireGoodsTabCell.swift
//  healthAndBeautyUser
//
//  Created by 丿番茄 on 2017/11/1.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewRequireGoodsTabCell: UITableViewCell {
    
    var index = IndexPath()
    var isPayNow = Bool()
    
    //点击事件
    typealias swiftBlock = (_ count: NSInteger) -> Void
    var willClick : swiftBlock? = nil
    func callBackBlock(block: @escaping (_ count: NSInteger) -> Void ) {
        willClick = block
    }
    
    private var _model : NewStoreShopCarModel?
    var model : NewStoreShopCarModel? {
        didSet {
            self.didSetModel(model!)
            _model = model
        }
    }
    
    private func didSetModel(_ model: NewStoreShopCarModel) {
        
        icon.kf.setImage(with: StringToUTF_8InUrl(str: model.thumbnail))
        viewRadius(icon, 5.0, 0.5, lineColor)
        icon.contentMode = .scaleAspectFill
        
        title.text = "【\(model.goodName)】\(model.goodChildName)"
        if model.other == "1" {
            post.text = "包邮"
        }else {
            post.text = "邮费(\(model.otherPrice))"
        }
        price.text = "￥ \(model.payPrice)"
        count.text = "x\(model.num)"
        
        if isPayNow {
            controllerView.isHidden = false
            viewRadius(controllerView, 5.0, 0.5, lineColor)
            viewRadius(num, 0, 0.5, lineColor)
            post.isHidden = true
        }else {
            controllerView.isHidden = true
        }
    }
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var post: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var count: UILabel!
    
    @IBOutlet weak var controllerView: UIView!
    @IBOutlet weak var sub: UIButton!
    @IBOutlet weak var add: UIButton!
    @IBOutlet weak var num: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func click(_ sender: UIButton) {
        switch sender {
        case sub:
            if Int(num.text!)! <= 1 {
                return
            }
            let count = Int(num.text!)! - 1
            num.text = "\(count)"
            break
        case add:
            let count = Int(num.text!)! + 1
            num.text = "\(count)"
            break
        default:
            break
        }
        RequireOrderDataSource[index.row].currentGoodsCount = Int(num.text!)!
        if willClick != nil {
            willClick!(Int(num.text!)!)
        }
    }
}
