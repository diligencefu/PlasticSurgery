//
//  NewRequireListTabCell.swift
//  healthAndBeautyUser
//
//  Created by 丿番茄 on 2017/10/31.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewRequireListTabCell: UITableViewCell {
    
    //点击事件
    typealias swiftBlock = (_ count: NSInteger) -> Void
    var willClick : swiftBlock? = nil
    func callBackBlock(block: @escaping (_ count: NSInteger) -> Void ) {
        willClick = block
    }
    
    var index = IndexPath()
    var isPayNow = Bool()
    
    //VIP等级
    var vipLv = String()
    var discount = Float()
    
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
        doctor.text = model.doctorName
        price.text = "￥ \(model.payPrice)"
        count.text = "x\(model.num)"
        
        let tap1 = UITapGestureRecognizer.init(target: self, action: #selector(click(_:)))
        view1.addGestureRecognizer(tap1)
        
        let tap2 = UITapGestureRecognizer.init(target: self, action: #selector(click(_:)))
        view2.addGestureRecognizer(tap2)
        
        for index in selectAppointmentDataSource {
            if index.counponId == model.book1 {
                book1.text = "已优惠\(index.counponAmount)"
                price1.text = "预约金小计：￥\(model.payPrice * Float((isPayNow ? model.currentGoodsCount : model.num)) - index.counponAmount)"
            }
        }
        if model.book1.count == 0 {
            book1.text = "点击使用优惠券"
            price1.text = "预约金小计：￥\(model.payPrice * Float((isPayNow ? model.currentGoodsCount : model.num)))"
        }

        for index in selectFinalDataSource {
            if index.counponId == model.book2 {
                book2.text = "已优惠\(index.counponAmount)"
                if discount == 1 {
                    price2.text = "尾款小计：￥\(model.retainage * Float((isPayNow ? model.currentGoodsCount : model.num)) - index.counponAmount)"
                }else {
                    price2.text = "尾款小计：￥\(model.retainage * Float((isPayNow ? model.currentGoodsCount : model.num)) * discount - index.counponAmount)"
                }
            }
        }
        if model.book2.count == 0 {
            book2.text = "点击使用优惠券"
            if discount == 1 {
                price2.text = "尾款小计：￥\(model.retainage * Float((isPayNow ? model.currentGoodsCount : model.num)))"
            }else {
                price2.text = "尾款小计：￥\(model.retainage * Float((isPayNow ? model.currentGoodsCount : model.num)) * discount)"
            }
        }
        
        if isPayNow {
            controllerView.isHidden = false
            viewRadius(controllerView, 5.0, 0.5, lineColor)
            viewRadius(num, 0, 0.5, lineColor)
        }else {
            controllerView.isHidden = true
        }
        
        if discount == 1 {
            currentSall.text = "您当前为普通会员，无法享受折扣"
        }else {
            if (discount*10).truncatingRemainder(dividingBy: 1) != 0{
                currentSall.text = "您当前为\(vipLv)，可享受\(Int(discount*10))折扣优惠"
            }
            currentSall.text = "您当前为\(vipLv)，可享受\(discount)折扣优惠"
        }
        
    }
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var doctor: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var count: UILabel!
    
    
    //预约金小计及点击事件
    @IBOutlet weak var price1: UILabel!
    @IBOutlet weak var book1: UILabel!
    @IBOutlet weak var view1: UIView!

    //尾款小计及点击事件
    @IBOutlet weak var price2: UILabel!
    @IBOutlet weak var book2: UILabel!
    @IBOutlet weak var view2: UIView!

    @IBOutlet weak var currentSall: UILabel!
    
    @IBOutlet weak var sub: UIButton!
    @IBOutlet weak var add: UIButton!
    @IBOutlet weak var num: UILabel!
    @IBOutlet weak var controllerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @objc private func click(_ sender: UITapGestureRecognizer) {
        
        let select = NewSelectDiscountsBookViewController()
        if sender.view == view1 {
            select.type = "1"
        }else {
            select.type = "2"
        }
        select.index = index
        select.isPayNow = isPayNow
        select.currentModel = _model!
        viewController()?.navigationController?.pushViewController(select, animated: true)
    }
    
    @IBAction func touchUp(_ sender: UIButton) {
        
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
