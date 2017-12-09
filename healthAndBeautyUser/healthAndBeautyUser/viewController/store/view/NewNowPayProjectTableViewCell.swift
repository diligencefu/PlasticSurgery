//
//  NewNowPayProjectTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 丿番茄 on 2017/11/24.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewNowPayProjectTableViewCell: UITableViewCell {

    var index = IndexPath()
    
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
        doctorName.text = model.doctorName
        price.text = "￥ \(model.payPrice)"
        count.text = "x\(model.num)"
        
        let tap1 = UITapGestureRecognizer.init(target: self, action: #selector(click(_:)))
        view_1.addGestureRecognizer(tap1)
        
        let tap2 = UITapGestureRecognizer.init(target: self, action: #selector(click(_:)))
        view_2.addGestureRecognizer(tap2)
        
        for index in selectAppointmentDataSource {
            if index.counponId == model.book1 {
                book1.text = "已优惠\(index.counponAmount)"
                money1.text = "预约金小计：￥\(model.payPrice * Float(model.num) - index.counponAmount)"
            }
        }
        if model.book1.count == 0 {
            book1.text = "点击使用优惠券"
            money1.text = "预约金小计：￥\(model.payPrice * Float(model.num))"
        }
        
        for index in selectFinalDataSource {
            if index.counponId == model.book2 {
                book2.text = "已优惠\(index.counponAmount)"
                money2.text = "尾款小计：￥\(model.retainage * Float(model.num) - index.counponAmount)"
            }
        }
        if model.book2.count == 0 {
            book2.text = "点击使用优惠券"
            money2.text = "尾款小计：￥\(model.retainage * Float(model.num))"
        }
    }
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var doctorName: UILabel!
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var sub: UIButton!
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var add: UIButton!
    
    //预约金小计以及预约金优惠券
    @IBOutlet weak var view_1: UIView!
    @IBOutlet weak var money1: UILabel!
    @IBOutlet weak var book1: UILabel!
    
    //尾款小计以及预约金优惠券
    @IBOutlet weak var view_2: UIView!
    @IBOutlet weak var money2: UILabel!
    @IBOutlet weak var book2: UILabel!
    //会员折扣
    @IBOutlet weak var vipSail: UILabel!
    
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
            
            break
        case add:
            
            break
        default:
            break
        }
    }
}
