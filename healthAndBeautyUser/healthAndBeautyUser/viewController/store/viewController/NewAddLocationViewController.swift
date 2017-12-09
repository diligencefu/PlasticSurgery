//
//  NewAddLocationViewController.swift
//  healthAndBeautyUser
//
//  Created by 丿番茄 on 2017/11/1.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewAddLocationViewController: Wx_baseViewController {

    var isAdd = Bool()
    var model = NewStoreLocationModel()
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phone: UITextField!
    
    @IBOutlet weak var location: UITextView!
    @IBOutlet weak var locationSelect: UIView!
    @IBOutlet weak var area: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createNaviController(title: "新增地址", leftBtn: buildLeftBtn(), rightBtn: buildRightBtnWithName("完成"))
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(selectCity))
        locationSelect.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !isAdd {
            name.text = model.realName
            phone.text = model.tel
            location.text = model.street
            area.text = model.area
        }
    }
    
    @objc private func selectCity() {
        
        BRAddressPickerView.showAddressPicker(withDefaultSelected: nil, isAutoSelect: true) { (type) in
            delog(type)
            let arr = type as! [String]
            self.area.text = arr[0] + arr[1]
        }
    }
    
    override func rightClick() {

        if name.text?.count == 0 {
            SVPwillShowAndHide("请输入收货人姓名")
            return
        }
        if phone.text?.count == 0 {
            SVPwillShowAndHide("请输入联系电话")
            return
        }
        if area.text == "省、市" {
            SVPwillShowAndHide("请输入收货人地区")
            return
        }
        if location.text == "详细地址" || location.text == "" {
            SVPwillShowAndHide("请输入详细地址")
            return
        }
        
        var up = ["SESSIONID": Defaults["SESSIONID"].stringValue,
                  "mobileCode": Defaults["mobileCode"].stringValue,
                  "realName": name.text!,
                  "tel": phone.text!,
                  "area": area.text!,
                  "street": location.text!,
                  "isDefaultAddress": "1"]
            as [String : Any]
        
        if !isAdd {
            up["id"] = model.id
        }
        
        SVPWillShow("载入中...")
        delog(up)
        
        Net.share.postRequest(urlString: saveDeliveryAddress_22_joggle, params: up, success: { (datas) in
            let json = JSON(datas)
            delog(json)
            SVPHide()
            if json["code"].int == 1 {
                if self.isAdd {
                    SVPwillSuccessShowAndHide("新增地址成功")
                }else {
                    SVPwillSuccessShowAndHide("修改地址成功")
                }
                self.navigationController?.popViewController(animated: true)
            }else {
                SVPwillShowAndHide(json["message"].string!)
            }
        }) { (error) in
            delog(error)
            SVPwillShowAndHide("请检查您的网路")
        }
    }
}

extension NewAddLocationViewController: UITextFieldDelegate {
    
    
}

extension NewAddLocationViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.text == "详细地址" {
            textView.text = ""
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text == "" {
            textView.text = "详细地址"
        }
    }
}
