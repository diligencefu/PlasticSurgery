//
//  NewLocationListTabCell.swift
//  healthAndBeautyUser
//
//  Created by 丿番茄 on 2017/11/1.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON

var NewLocationListTabCellDeleteId = String()

class NewLocationListTabCell: UITableViewCell {

    //点击事件
    typealias swiftBlock = () -> Void
    var willClick : swiftBlock? = nil
    func callBackBlock(block: @escaping () -> Void ) {
        willClick = block
    }
    
    private var _model : NewStoreLocationModel?
    var model : NewStoreLocationModel? {
        didSet {
            self.didSetModel(model!)
            _model = model
        }
    }
    
    private func didSetModel(_ model: NewStoreLocationModel) {
        
        name.text = model.realName
        phone.text = model.tel
        address.text = "收货地址：\(model.area)\(model.street)"
        
        if model.isDefaultAddress == "1" {
            
            defauleBtn.setImage(UIImage(named:"gx"), for: .normal)
            defauleBtn.setTitle("默认地址", for: .normal)
            defauleBtn.setTitleColor(tabbarColor, for: .normal)
        }else {
            
            defauleBtn.setImage(UIImage(named:"ty"), for: .normal)
            defauleBtn.setTitle("设为默认", for: .normal)
            defauleBtn.setTitleColor(darkText, for: .normal)
        }
    }
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phone: UILabel!
    
    @IBOutlet weak var address: UILabel!
    
    @IBOutlet weak var defauleBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func click(_ sender: UIButton) {
        
        switch sender.tag {
        case 800:
            //设为默认
            setDefault()
            break
        case 801:
            //编辑
            let edit = NewAddLocationViewController.init(nibName: "NewAddLocationViewController", bundle: nil)
            edit.isAdd = false
            edit.model = _model!
            viewController()?.navigationController?.pushViewController(edit, animated: true)
            break
        case 802:
            //删除
            NewLocationListTabCellDeleteId = _model!.id
            let viewCntroller = viewController() as! NewPostLocationViewController
            viewCntroller.buildAlter("提示", "是否确定删除该地址", "确定")
            break
        default:
            break
        }
    }
    
    private func setDefault() {
        
        if _model!.isDefaultAddress == "1" {
            return
        }
        
        let up = ["SESSIONID": Defaults["SESSIONID"].stringValue,
                  "mobileCode": Defaults["mobileCode"].stringValue,
                  "realName": _model!.realName,
                  "tel": _model!.tel,
                  "area": _model!.area,
                  "street": _model!.street,
                  "isDefaultAddress": "1",
                  "id": _model!.id]
            as [String : Any]
        
        SVPWillShow("载入中...")
        delog(up)
        
        Net.share.postRequest(urlString: saveDeliveryAddress_22_joggle, params: up, success: { (datas) in
            let json = JSON(datas)
            delog(json)
            SVPHide()
            if json["code"].int == 1 {
                
                if self.willClick != nil {
                    self.willClick!()
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
