//
//  NewMeOrderListTabCell.swift
//  healthAndBeautyUser
//
//  Created by 丿番茄 on 2017/11/7.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewMeOrderListTabCell: UITableViewCell {
    
    //商品详情
    private var _goodsDetailModel : NewGoodsDetailModel?
    var goodsDetailModel : NewGoodsDetailModel? {
        didSet {
            self.didSetGoodsDetailModel(goodsDetailModel!)
            _goodsDetailModel = goodsDetailModel
        }
    }
    
    private func didSetGoodsDetailModel(_ model: NewGoodsDetailModel) {
        
        head.kf.setImage(with: StringToUTF_8InUrl(str: model.thumbnail))
        head.contentMode = .scaleAspectFill
        viewRadius(head, 3.0, 0.5, lineColor)
        
        title.text = "【\(model.goodName)】\(model.goodChildName)"
        
        label1.isHidden = true
        count.text = "x\(model.num)"
        label2.isHidden = false
        label2.text = "商品单价："

        label2_2.isHidden = false
        label2_2.text = "￥ \(model.goodPrice)"
        label2_2.textColor = UIColor.red
        label4.isHidden = true
    }
    
    //商品列表
    private var _goodsListModel : NewGoodsOrderListModel?
    var goodsListModel : NewGoodsOrderListModel? {
        didSet {
            self.didSetGoodsListModel(goodsListModel!)
            _goodsListModel = goodsListModel
        }
    }
    
    private func didSetGoodsListModel(_ model: NewGoodsOrderListModel) {
        
        head.kf.setImage(with: StringToUTF_8InUrl(str: model.list.thumbnail))
        head.contentMode = .scaleAspectFill
        viewRadius(head, 3.0, 0.5, lineColor)
        
        title.text = "【\(model.list.goodName)】\(model.list.goodChildName)"
        
        label1.isHidden = true
        count.text = "x\(model.list.num)"
        label2.isHidden = false
        label2.text = "商品单价："
        label2_2.isHidden = false
        label2_2.text = "￥ \(model.list.goodPrice)"
        label2_2.textColor = UIColor.red
        label4.isHidden = true
    }
    
    //项目详情使用
    var type = NSInteger()
    private var _detailModel : NewOrderDetail?
    var detailModel : NewOrderDetail? {
        didSet {
            self.didSetDetailModel(detailModel!)
            _detailModel = detailModel
        }
    }
    
    private func didSetDetailModel(_ model: NewOrderDetail) {
        
        head.kf.setImage(with: StringToUTF_8InUrl(str: model.thumbnail))
        head.contentMode = .scaleAspectFill
        viewRadius(head, 3.0, 0.5, lineColor)
        
        title.text = "【\(model.productName)】\(model.productChildName)"
        
        if type == 0 || type == 1 {
            label1.isHidden = true
            count.text = "x\(model.num)"
            label2.isHidden = false
            label2.text = "预约金单价："
            label2_2.isHidden = false
            label2_2.text = "￥ \(model.reservationPrice)"
            label2_2.textColor = UIColor.red
            label4.isHidden = false
            label4.text = "到院再付：￥ \(model.retainage)"
        }else if type == 5 {
            label1.isHidden = true
            label2.isHidden = true
            label2_2.isHidden = true
            label4.isHidden = true
        }else {
            label1.isHidden = true
            count.text = "x\(model.num)"
            label2.isHidden = false
            label2.text = "订单总价："
            label2_2.isHidden = false
            label2_2.text = "￥ \((model.reservationPrice + model.retainage) * Float(model.num))"
            label2_2.textColor = UIColor.red
            label4.isHidden = false
            label4.text = "项目类型: \(model.projectName)"
        }
    }
    
    //列表
//    NewMineOrderLIstModel
    private var _model : NewMineOrderLIstModel?
    var model : NewMineOrderLIstModel? {
        didSet {
            self.didSetModel(model!)
            _model = model
        }
    }
    
    private func didSetModel(_ model: NewMineOrderLIstModel) {
        
        head.kf.setImage(with: StringToUTF_8InUrl(str: model.thumbnail))
        head.contentMode = .scaleAspectFill
        viewRadius(head, 3.0, 0.5, lineColor)
        
        title.text = "【\(model.productName)】\(model.productChildName)"
        
        if model.type == 0 {
            //待支付

            label1.isHidden = true
            count.text = "x\(model.num)"
            label2.isHidden = false
            label2_2.isHidden = true
            label2.text = "预约金：\(model.reservationPrice)"
            label4.isHidden = true
        }else if model.type == 1 {
            //待确认
            
            label1.isHidden = true
//            label1.text = "到院再付\(model.num)"
            count.text = "x\(model.num)"
            label2.isHidden = false
            label2.text = "订单状态:"
            label2_2.isHidden = false
            if model.orderStatus == "0" {
                label2_2.text = "待咨询确认"
                label2_2.textColor = getColorWithNotAlphe(0x89E16A)
            }else {
                label2_2.text = "待付尾款"
                label2_2.textColor = UIColor.red
            }
            label4.isHidden = true
        }else if model.type == 3 {
            //已支付
            
            var doctorName = String()
            for doctor in model.doctors {
                doctorName += doctor.doctorName
                if doctor != model.doctors.last {
                    doctorName += ","
                }
            }
            label1.isHidden = false
            label1.text = "项目医生:\(doctorName)"
            count.text = "x\(model.num)"
            label2.isHidden = false
            label2.text = "项目类型:\(model.projectName)"
            label2_2.isHidden = true
            label4.isHidden = false
            label4.text = "预计开始时间:\(model.operationDate)"
        }else if model.type == 4 {
            //已支付
            
            var doctorName = String()
            for doctor in model.doctors {
                doctorName += doctor.doctorName
                if doctor != model.doctors.last {
                    doctorName += ","
                }
            }
            label1.isHidden = true
            count.text = "x\(model.num)"
            label2.isHidden = false
            label2.text = "项目医生:\(doctorName)"
            label4.isHidden = false
            label4.text = "项目类型:\(model.projectName)"
            label2_2.isHidden = true
        }else if model.type == 5 {
            
            label1.isHidden = true
            count.text = "x\(model.num)"
            label2.isHidden = false
            label2.text = "申请时间:\(model.createDate)"
            label4.isHidden = true
            label2_2.isHidden = true
        }
    }
    
    @IBOutlet weak var head: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    //标题下面的文字
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label2_2: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var count: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
