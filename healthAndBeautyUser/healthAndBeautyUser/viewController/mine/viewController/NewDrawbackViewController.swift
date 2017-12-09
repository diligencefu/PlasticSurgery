//
//  NewDrawbackViewController.swift
//  healthAndBeautyUser
//
//  Created by 丿番茄 on 2017/11/9.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewDrawbackViewController: Wx_baseViewController {

    var dataSource = [NewOrderDetail]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createNaviController(title: "申请退款", leftBtn: buildLeftBtn(), rightBtn: nil)
        buildUI()
    }
    
    private func buildUI() {
        
        drawback.layer.cornerRadius = 5.0
        
        icon.kf.setImage(with: StringToUTF_8InUrl(str: dataSource[0].thumbnail))
        viewRadius(icon, 5.0, 0.5, lineColor)
        icon.contentMode = .scaleAspectFill
        
        productName.text = "【\(dataSource[0].productName)】\(dataSource[0].productChildName)"
        price.text = "￥ \(dataSource[0].prepaidPrice)"
    }
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var doctorName: UILabel!
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var tv: UITextView!
    
    @IBOutlet weak var drawback: UIButton!
    
    @IBAction func click(_ sender: UIButton) {
        
        tv.resignFirstResponder()
        
        let up = ["mobileCode":Defaults["mobileCode"].stringValue,
                  "SESSIONID":Defaults["SESSIONID"].stringValue,
                  "id":dataSource[0].id,
                  "applyReason":tv.text!]
            as [String: Any]
        
        SVPWillShow("加载中...")
        //待支付
        delog(up)
        
        Net.share.postRequest(urlString: refundProductOrder_50_joggle, params: up, success: { (datas) in
            let json = JSON(datas)
            SVPHide()
            delog(json)
            if json["code"].int == 1 {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }) { (error) in
            delog(error)
        }
    }
}

extension NewDrawbackViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "请输入退款原因" {
            textView.text = ""
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" || textView.text == " " || textView.text == "  " {
            textView.text = "请输入退款原因"
        }
    }
}
