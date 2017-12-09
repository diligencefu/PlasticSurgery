//
//  NewDiscountBookTabCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/10/27.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewDiscountBookTabCell: UITableViewCell {
    
    var index = IndexPath()
    
    var currentID = String()
    //商城模块确认订单页面选择优惠券部分
    private var _selectBookModel : NewSelectBookListModel?
    var selectBookModel : NewSelectBookListModel? {
        didSet {
            _selectBookModel = selectBookModel
            self.didSetSelectBookModel(selectBookModel!)
        }
    }
    
    private func didSetSelectBookModel(_ model: NewSelectBookListModel) {
        
//        //更换背景
        rightImg.image = UIImage(named:"manjian_image_23_120_default")
        centerTopImage.image = UIImage(named:"manjian_image_253_30_default")
        centerBottomImage.image = UIImage(named:"manjian_image_253_90_default")
        leftTopImage.image = UIImage(named:"manjian_image_124_30_default")
        leftBottomImage.image = UIImage(named:"manjian_image_124_90_default")
        
        use.setTitle(model.state, for: .normal)
        use.backgroundColor = tabbarColor
        
        viewRadius(use, 5.0, 0, UIColor.white)
        
        count.text = "x \(model.receiveNum - model.userNum)"
        if model.counponKind == "1" {
            type.text = "预约金优惠券"
        }else {
            type.text = "尾款优惠券"
        }
        time.text = "\(model.counponStartDate)-\(model.couponEndDate)"
        price.text = "￥ \(model.counponAmount)"
        detail.text = model.counponExplain
        
        if model.counponUsingRange == "1" {
            content.text = "所有项目可用"
        }else {
            content.text = "使用说明：仅限于\(model.projectNames)可用"
        }
    }
    
    //获取优惠券部分
    private var _getBookModel : NewMineBookCenterModel?
    var getBookModel : NewMineBookCenterModel? {
        didSet {
            _getBookModel = getBookModel
            self.didSetGetBookModel(getBookModel!)
        }
    }
    
    private func didSetGetBookModel(_ model: NewMineBookCenterModel) {
        
        isCenter = true

        use.setTitle("领取", for: .normal)
        use.backgroundColor = getColorWithNotAlphe(0xDB31D1)
        rightImg.image = UIImage(named:"manjian_image_23_120_default")
        centerTopImage.image = UIImage(named:"manjian_image_253_30_default")
        centerBottomImage.image = UIImage(named:"manjian_image_253_90_default")
        leftTopImage.image = UIImage(named:"manjian_image_124_30_default")
        leftBottomImage.image = UIImage(named:"manjian_image_124_90_default")
        viewRadius(use, 5.0, 0, UIColor.white)
        use.isUserInteractionEnabled = true

        count.text = "限领 \(model.collarNum)"
        if model.counponKind == "1" {
            type.text = "预约金优惠券"
        }else {
            type.text = "尾款优惠券"
        }
        time.text = "\(model.counponStartDate)-\(model.couponEndDate)"
        price.text = "￥ \(model.counponAmount)"
        detail.text = model.counponExplain
        
        if model.counponUsingRange == "1" {
            content.text = "所有项目可用"
        }else {
            content.text = "使用说明：仅限于\(model.projectNames)可用"
        }
    }
    
    //我的优惠券部分
    private var _model : NewMineBookModel?
    var model : NewMineBookModel? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    
    private func didSetModel(_ model: NewMineBookModel) {
        
        isCenter = false
        //更换背景
        if model.status == "1" || model.status == "2" {
            
            if model.status == "1" {
                
                use.setTitle("待使用", for: .normal)
                use.backgroundColor = getColorWithNotAlphe(0xDB31D1)
                use.isUserInteractionEnabled = true
            }else {
                
                use.setTitle("暂时不可用", for: .normal)
                use.backgroundColor = getColorWithNotAlphe(0xD7D7D7)
                use.isUserInteractionEnabled = false
            }
            rightImg.image = UIImage(named:"manjian_image_23_120_default")
            centerTopImage.image = UIImage(named:"manjian_image_253_30_default")
            centerBottomImage.image = UIImage(named:"manjian_image_253_90_default")
            leftTopImage.image = UIImage(named:"manjian_image_124_30_default")
            leftBottomImage.image = UIImage(named:"manjian_image_124_90_default")
        }else {
            use.setTitle("已失效", for: .normal)
            use.backgroundColor = getColorWithNotAlphe(0xD7D7D7)
            use.isUserInteractionEnabled = false

            rightImg.image = UIImage(named:"bukeyong_image_23_120_default")
            centerTopImage.image = UIImage(named:"bukeyong_image_253_30_default")
            centerBottomImage.image = UIImage(named:"bukeyong_image_253_90_default")
            leftTopImage.image = UIImage(named:"bukeyong_image_124_30_default")
            leftBottomImage.image = UIImage(named:"bukeyong_image_124_90_default")
        }
        viewRadius(use, 5.0, 0, UIColor.white)
        
        count.text = "x \(model.receiveNum - model.userNum)"
        if model.counponKind == "1" {
            type.text = "预约金优惠券"
        }else {
            type.text = "尾款优惠券"
        }
        time.text = "\(model.counponStartDate)-\(model.couponEndDate)"
        price.text = "￥ \(model.counponAmount)"
        detail.text = model.counponExplain
        
        if model.counponUsingRange == "1" {
            content.text = "所有项目可用"
        }else {
            content.text = "使用说明：仅限于\(model.projectNames)可用"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private var isCenter = Bool()
    
    @IBOutlet weak var rightImg: UIImageView!
    @IBOutlet weak var centerTopImage: UIImageView!
    @IBOutlet weak var centerBottomImage: UIImageView!
    @IBOutlet weak var leftTopImage: UIImageView!
    @IBOutlet weak var leftBottomImage: UIImageView!
    
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var count: UILabel!
    
    @IBOutlet weak var use: UIButton!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func click(_ sender: UIButton) {
        
        if isCenter {
            
            delog("领券中心")
            getBook()
        }else {
            
            delog("我的优惠券")
        }
    }
    
    private func getBook() {
        
        var up = ["id":_getBookModel!.id]
            as [String: Any]
        
        if Defaults.hasKey("SESSIONID") {
            up["mobileCode"] = Defaults["mobileCode"].stringValue
            up["SESSIONID"] = Defaults["SESSIONID"].stringValue
        }
        SVPWillShow("载入中...")
        delog(up)
        
        Net.share.postRequest(urlString: receiveCoupon_40_joggle, params: up, success: { (datas) in
            let json = JSON(datas)
            delog(json)
            SVPHide()
            if json["code"].int == 1 {
                
                SVPwillSuccessShowAndHide("领取优惠券成功")
//                if self._getBookModel!.collarNum != 1 {
//
//                    self._getBookModel!.collarNum -= 1
//                    self.count.text = "限领 \(self._getBookModel!.collarNum)"
//                }else {
                    let viewController = self.viewController()! as! NewMineBookAddViewController
                    viewController.buildData()
//                }
            }else {
                SVPwillShowAndHide(json["message"].string!)
            }
        }) { (error) in
            delog(error)
            SVPwillShowAndHide("请检查您的网路")
        }
    }
}
