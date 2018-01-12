//
//  NewShoppingCarTabCell.swift
//  healthAndBeautyUser
//
//  Created by 丿番茄 on 2017/10/30.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewShoppingCarTabCell: UITableViewCell {

    var dataSource = [NewStoreShopCarModel]()
    var indexPath = IndexPath()
    
    private var _model : NewStoreShopCarModel?
    var model : NewStoreShopCarModel? {
        didSet {
            self.didSetModel(model!)
            _model = model
        }
    }
    
    private func didSetModel(_ model: NewStoreShopCarModel) {
        
        icon.kf.setImage(with: StringToUTF_8InUrl(str: model.thumbnail))
        icon.contentMode = .scaleAspectFill
        viewRadius(icon, 5.0, 0.5, lineColor)
        
        title.text = "【\(model.goodName)】 \(model.goodChildName)"
        doctor.text = model.doctorName
        
        price.text = "￥ \(model.payPrice)"
        if model.goodType == "1" {
            firstPrice.text = "预约金小计：￥ \(model.payPrice * Float(model.num))"
        }else {
            firstPrice.text = "金额小计：￥ \(model.payPrice * Float(model.num))"
        }
        
        count.text = "\(model.num)"
        num = model.num
        viewRadius(backView, 5.0, 0.5, getColorWithNotAlphe(0xDCDCDC))
        viewRadius(count, 0, 0.5, getColorWithNotAlphe(0xDCDCDC))
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(touchSelf))
        bacl.addGestureRecognizer(tap)
        
        if model.isSelect {
            selectBtn.isSelected = true
        }else {
            selectBtn.isSelected = false
        }
        
        if model.num == 1 {
            self.sub.setTitleColor(getColorWithNotAlphe(0x757575), for: .normal)
            self.sub.isUserInteractionEnabled = false
        }else {
            self.sub.setTitleColor(getColorWithNotAlphe(0xFF5D5E), for: .normal)
            self.sub.isUserInteractionEnabled = true
        }
    }
    
    @objc private func touchSelf() {
        
        dataSource[indexPath.row].isSelect = !selectBtn.isSelected
        let view = viewController() as! NewShoppingCarViewController
        view.rebuildBottomData()
    }
    
    @IBOutlet weak var bacl: UIView!
    
    @IBOutlet weak var selectBtn: UIButton!
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var doctor: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var firstPrice: UILabel!
    
    @IBOutlet weak var count: UILabel!
    
    @IBOutlet weak var sub: UIButton!
    @IBOutlet weak var add: UIButton!
    @IBOutlet weak var backView: UIView!
    private var num: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func selectBtnClick(_ sender: UIButton) {
        
        touchSelf()
    }
    
    @IBAction func numCount(_ sender: UIButton) {
        
        switch sender.tag {
            
        case 200:
            shoppingCarController("-1")
            
            break
        case 201:
            shoppingCarController("+1")
            
            break
        default:
            break
        }
    }
    
    private func shoppingCarController(_ controller: String) {
        
        //加入购物车操作
        var up = ["type" : _model!.goodType,
                  "id": _model!.id,
                  "num": controller]
            as [String: Any]
        
        if Defaults.hasKey("SESSIONID") {
            up["mobileCode"] = Defaults["mobileCode"].stringValue
            up["SESSIONID"] = Defaults["SESSIONID"].stringValue
        }else {
            SVPwillShowAndHide("请登录后重新操作")
            let login = NewLoginLocationViewController.init(nibName: "NewLoginLocationViewController", bundle: nil)
            let loginVC = Wx_baseNaviViewController.init(rootViewController: login)
            viewController()?.present(loginVC, animated: true, completion: nil)
            return
        }
        
        SVPWillShow("载入中...")
        delog(up)
        
        Net.share.postRequest(urlString: addShopCar_16_joggle, params: up, success: { (datas) in
            
            let json = JSON(datas)
            delog(json)
            SVPHide()
            if json["code"].int == 1 {
                if controller == "-1" {
                    self.num -= 1
                    self.dataSource[self.indexPath.row].num -= 1
                }else {
                    self.num += 1
                    self.dataSource[self.indexPath.row].num += 1
                }
                DispatchQueue.main.async {
                    let view = self.viewController() as! NewShoppingCarViewController
                    if self._model!.isSelect {
                        view.rebuildBottomData()
                    }else {
                        view.tableView.reloadData()
                    }
                }
            }else {
                SVPwillShowAndHide(json["message"].string!)
            }
        }) { (error) in
            delog(error)
            SVPwillShowAndHide("请检查您的网路")
        }
    }
}
