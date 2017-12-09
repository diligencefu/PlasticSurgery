//
//  NewMeOrderControllerTabCell.swift
//  healthAndBeautyUser
//
//  Created by 丿番茄 on 2017/11/7.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewMeOrderControllerTabCell: UITableViewCell {

    private var _goodsListModel : NewGoodsOrderListModel?
    var goodsListModel : NewGoodsOrderListModel? {
        didSet {
            self.didSetGoodsListModel(goodsListModel!)
            _goodsListModel = goodsListModel
        }
    }
    
    private func didSetGoodsListModel(_ model: NewGoodsOrderListModel) {
        
        if model.type == 0 {
            
            main.text = "商品总价:"
            price.text = "￥ \(model.productTotal)"
            
            talk.isHidden = true
            pay.setTitle("取消支付", for: .normal)
            viewRadius(pay, 5.0, 0.5, lineColor)
            pay.isUserInteractionEnabled = true
            
            pay.isHidden = false
            pay.setTitle("支付", for: .normal)
            pay.layer.cornerRadius = 5.0
            pay.isUserInteractionEnabled = true
            pay.backgroundColor = tabbarColor
        }else if model.type == 1 {
            
            main.text = "商品总价:"
            price.text = "￥ \(model.productTotal)"
            
            talk.isHidden = true
            
            pay.isHidden = false
            pay.setTitle("待发货", for: .normal)
            pay.layer.cornerRadius = 5.0
            pay.isUserInteractionEnabled = false
            pay.backgroundColor = lightText
        }else if model.type == 2 {
            
            main.text = "商品总价:"
            price.text = "￥ \(model.productTotal)"
            
            talk.isHidden = true
            
            pay.isHidden = false
            pay.setTitle("确认收货", for: .normal)
            pay.layer.cornerRadius = 5.0
        }else if model.type == 3 {
            
            main.text = "商品总价:"
            price.text = "￥ \(model.productTotal)"
            
            talk.isHidden = true
            
            pay.isHidden = false
            pay.setTitle("申请退货", for: .normal)
            pay.layer.cornerRadius = 5.0
            pay.backgroundColor = tabbarColor
        }else {
            
            main.text = "商品总价:"
            price.text = "￥ \(model.productTotal)"
            
            talk.isHidden = true
            
            pay.isHidden = false
            if model.handingSchedule == "0" {
                pay.setTitle("待审批", for: .normal)
            }else if model.handingSchedule == "1" {
                pay.setTitle("待确认", for: .normal)
            }else if model.handingSchedule == "2" {
                if model.returnsStatus == "1" {
                    pay.setTitle("退款成功", for: .normal)
                }else {
                    pay.setTitle("退款失败", for: .normal)
                }
            }
            pay.isUserInteractionEnabled = false
            pay.backgroundColor = lightText
            pay.layer.cornerRadius = 5.0
        }
    }
    
    //MARK: - 项目类赋值
    private var _model : NewMineOrderLIstModel?
    var model : NewMineOrderLIstModel? {
        didSet {
            self.didSetModel(model!)
            _model = model
        }
    }
    
    private func didSetModel(_ model: NewMineOrderLIstModel) {
        
        if model.type == 0 {
            
            main.text = "预约金合计:"
            price.text = "￥ \(model.productTotal)"
            
            talk.isHidden = true
            
            pay.isHidden = false
            pay.setTitle("支付预约金", for: .normal)
            pay.layer.cornerRadius = 5.0
            pay.isUserInteractionEnabled = true
        }else if model.type == 1 {
            
            main.text = "到院再付:"
            price.text = "￥ \(model.residualPrice)"
            

            
            if model.orderStatus == "0" {
                
                talk.isHidden = false
                talk.setTitle("咨询", for: .normal)
                talk.layer.cornerRadius = 5.0
                talk.layer.borderColor = lineColor.cgColor
                talk.layer.borderWidth = 0.5
                talk.isUserInteractionEnabled = true
                
                pay.setTitle("退预约款", for: .normal)
                pay.isHidden = false
                pay.layer.cornerRadius = 5.0
                pay.isUserInteractionEnabled = true
            }else {
                
                talk.isHidden = false
                talk.setTitle("退预约款", for: .normal)
                talk.layer.cornerRadius = 5.0
                talk.layer.borderColor = lineColor.cgColor
                talk.layer.borderWidth = 0.5
                talk.isUserInteractionEnabled = true

                pay.setTitle("支付尾款", for: .normal)
                pay.isHidden = false
                pay.layer.cornerRadius = 5.0
                pay.isUserInteractionEnabled = true
            }
        }else if model.type == 3 {
            
            main.text = "已支付:"
            price.text = "￥ \(model.prepaidPrice + model.residualPrice)"
            talk.isHidden = true
            pay.isHidden = false
            pay.setTitle("查看详情", for: .normal)
            pay.layer.cornerRadius = 5.0
            pay.isUserInteractionEnabled = true
        }else if model.type == 4 {
            
            main.text = "订单总额:"
            price.text = "￥ \(model.prepaidPrice + model.residualPrice)"
            talk.isHidden = true
            pay.isHidden = false
            pay.setTitle("写日记", for: .normal)
            pay.layer.cornerRadius = 5.0
            pay.isUserInteractionEnabled = true
        }else if model.type == 5 {
            
            main.text = "退款总额:"
            price.text = "￥ \(model.refundCost)"
            talk.isHidden = true
            pay.isHidden = false
            if model.refundStatus == "0" {
                pay.setTitle("已申请", for: .normal)
            }else if model.refundStatus == "1" {
                pay.setTitle("已退款", for: .normal)
            }else {
                pay.setTitle("退款失败", for: .normal)
            }
            pay.isUserInteractionEnabled = false
            pay.backgroundColor = lightText
            pay.layer.cornerRadius = 5.0
        }
    }
    
    @IBOutlet weak var main: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var talk: UIButton!
    @IBOutlet weak var pay: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func click(_ sender: UIButton) {
//        let view = UIView
        switch sender.tag {
        case 800:
            delog("左边按钮")
            if sender.titleLabel?.text == "退预约款" {
                
                let drawBack = NewDrawbackViewController.init(nibName: "NewDrawbackViewController", bundle: nil)
                let model = NewOrderDetail()
                model.thumbnail = _model!.thumbnail
                model.id = _model!.id
                model.productName = _model!.productName
                model.productChildName = _model!.productChildName
                model.prepaidPrice = _model!.prepaidPrice
                drawBack.dataSource = [model]
                viewController()?.navigationController?.pushViewController(drawBack, animated: true)
            }
            break
        case 801:
            delog("右边按钮")
            if sender.titleLabel?.text == "确认收货" {
                let up = ["mobileCode":Defaults["mobileCode"].stringValue,
                          "SESSIONID":Defaults["SESSIONID"].stringValue,
                          "id":_model!.id]
                    as [String: Any]
                
                SVPWillShow("加载中...")
                delog(up)
                
                Net.share.getRequest(urlString: confirmGoodOrder_58_joggle, params: up, success: { (datas) in
                    let json = JSON(datas)
                    SVPHide()
                    delog(json)
                    if json["code"].int == 1 {
                        SVPwillSuccessShowAndHide("确认收货成功")
                    }
                }) { (error) in
                    delog(error)
                }
            }else if sender.titleLabel?.text == "支付预约金" {
                
                let pay = NewStorePayDetailViewController.init(nibName: "NewStorePayDetailViewController", bundle: nil)
                pay.orderId = _model!.id
                viewController()?.navigationController?.pushViewController(pay, animated: true)
            }else if sender.titleLabel?.text == "支付尾款" {
                
                let pay = NewStorePayDetailViewController.init(nibName: "NewStorePayDetailViewController", bundle: nil)
                pay.orderId = _model!.id
                pay.isPayFinalMoney = true
                viewController()?.navigationController?.pushViewController(pay, animated: true)
            }else if sender.titleLabel?.text == "退预约款" {
                
                let drawBack = NewDrawbackViewController.init(nibName: "NewDrawbackViewController", bundle: nil)
                let model = NewOrderDetail()
                model.thumbnail = _model!.thumbnail
                model.id = _model!.id
                model.productName = _model!.productName
                model.productChildName = _model!.productChildName
                model.prepaidPrice = _model!.prepaidPrice
                drawBack.dataSource = [model]
                viewController()?.navigationController?.pushViewController(drawBack, animated: true)
            }else if sender.titleLabel!.text == "写日记" {
                
                viewController()?.tabBarController?.selectedIndex = 2
                viewController()?.navigationController?.popToRootViewController(animated: true)
            }else if sender.titleLabel!.text == "支付" {
                
                let pay = NewStorePayDetailViewController.init(nibName: "NewStorePayDetailViewController", bundle: nil)
                pay.orderId = _goodsListModel!.id
                viewController()?.navigationController?.pushViewController(pay, animated: true)
            }else if sender.titleLabel!.text == "申请退货" {
                
                let returnGoods = NewReturnGoodViewController()
                returnGoods.id = _goodsListModel!.id
                viewController()?.navigationController?.pushViewController(returnGoods, animated: true)
            }
            break
        default:
            break
        }
    }
}
