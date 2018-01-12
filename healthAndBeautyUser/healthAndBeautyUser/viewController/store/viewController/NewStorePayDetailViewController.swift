//
//  NewStorePayDetailViewController.swift
//  healthAndBeautyUser
//
//  Created by 丿番茄 on 2017/11/2.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON
import IQKeyboardManagerSwift

class NewStorePayDetailViewController: Wx_baseViewController {

    //是否是尾款支付
    var isPayFinalMoney = Bool()
    
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var alipay: UIView!
    @IBOutlet weak var alipaySelect: UIImageView!
    
    @IBOutlet weak var weichatPay: UIView!
    @IBOutlet weak var weichatPaySelect: UIImageView!
    
    @IBOutlet weak var appPay: UIView!
    @IBOutlet weak var appPaySelect: UIImageView!
    
    @IBOutlet weak var require: UIButton!
    @IBOutlet weak var meMoney: UILabel!
    @IBOutlet weak var residueTime: UILabel!
    
    //支付区域
    //透明背景
    @IBOutlet weak var alphaView: UIView!
    //支付区域
    @IBOutlet weak var payView: UIView!
    //密码输入区域
    @IBOutlet weak var passwordView: UIView!
    //支付方式 余额支付或组合支付
    @IBOutlet weak var payWhat: UILabel!
    //余额支付价格
    @IBOutlet weak var appPayHow: UILabel!
    
    //首选支付方式
    var currentType : String = "0"
    //次要支付方式
    var secondType : String = "0"
    var isMoneyNoteEnough = Bool()
    
    var orderId = String()

    var myPrice = Float()
    var myMoney = Float()
    
    var textField : JJCPayCodeTextField? = nil

    var wherCome = 10
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if isPayFinalMoney {
            createNaviController(title: "支付订单", leftBtn: buildLeftBtn(), rightBtn: nil)
        }else {
            createNaviController(title: "支付订单", leftBtn: buildLeftBtn(), rightBtn: buildRightBtnWithName("取消订单"))
        }
        buildUI()
        buildData()
        buildCenter()
    }
    
    
    override func pop() {
        
//        guard let nav = self.navigationController else { return }
//        var is_contain = false
//        for c in nav.childViewControllers.reversed() {
//            if c is NewShoppingCarViewController {
//                is_contain = true
//                break
//            }
//        }
        
        let alert = UIAlertController.init(title: "提示", message: "支付尚未完成，退出后可到“我的订单”中完成付款！", preferredStyle: .alert)
        
        let action1 = UIAlertAction.init(title: "确定退出", style: .destructive) { (alertAction) in
            self.popAction()
        }
        let action2 = UIAlertAction.init(title: "取消", style: .cancel) { (alertAction) in
            return
        }
        
        alert.addAction(action1)
        alert.addAction(action2)
        
        self.present(alert, animated: true, completion: nil)

        
        
//        需要进行细节判断
        
        
    }
    
    func popAction(){
        for VC in (self.navigationController?.childViewControllers)! {
            
            if VC.isKind(of: NewShoppingCarViewController.self){
                wherCome = 0
                self.navigationController?.popToViewController(VC, animated: true)
                return
            }
        }
        
        if wherCome == 10 {
            for VC in (self.navigationController?.childViewControllers)! {
                
                if VC.isKind(of: NewStoresDetailViewController.self){
                    wherCome = 1
                    self.navigationController?.popToViewController(VC, animated: true)
                    return
                }
            }
        }
        
        if wherCome == 10 {
            self.navigationController?.popViewController(animated: true)
        }

    }
    
    
    
    //MARK: - 通知中心
    func buildCenter() {
        
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(paySuccess(sender:)), name: NSNotification.Name(rawValue: "paySuccess"), object: nil)
    }
    
    func paySuccess(sender:Notification) {
        
        let model = sender.object as! aliPayModel
        AliPayPaySuccess(model)
    }
    
    //
    private func buildUI() {
        
        let tap1 = UITapGestureRecognizer.init(target: self, action: #selector(tapClick(_:)))
        alipay.addGestureRecognizer(tap1)
        
        let tap2 = UITapGestureRecognizer.init(target: self, action: #selector(tapClick(_:)))
        weichatPay.addGestureRecognizer(tap2)
        
        let tap3 = UITapGestureRecognizer.init(target: self, action: #selector(tapClick(_:)))
        appPay.addGestureRecognizer(tap3)
        
        require.layer.cornerRadius = 5.0
        
        let tapAlphaView = UITapGestureRecognizer.init(target: self, action: #selector(hideView))
        alphaView.addGestureRecognizer(tapAlphaView)
        
        view.bringSubview(toFront: alphaView)
        view.bringSubview(toFront: payView)
        payView.alpha = 0
        payView.layer.cornerRadius = 5.0
        payView.layer.masksToBounds = true
        
        //密码支付区域
        textField = JJCPayCodeTextField.init(frame: CGRect.init(x: 0, y: 0, width: WIDTH-64, height: 44), textFieldType: .spaceBorder)
        textField!.isChangeTextFieldNum = true
        textField!.textFieldNum = 6
        textField!.borderSpace = ((WIDTH-64)-(6*44))/5
        textField!.borderColor = lineColor
        textField!.backgroundColor = getColorWithNotAlphe(0xF0F0F0)
        passwordView.addSubview(textField!)
        weak var weakSelf = self
        textField!.finishedBlock = { type in
            
            delog(type!)
            weakSelf!.checkPassword(type!)
        }
    }
    override func rightClick() {
        
        let up = ["mobileCode":Defaults["mobileCode"].stringValue,
                  "SESSIONID":Defaults["SESSIONID"].stringValue,
                  "id":orderId]
            as [String: Any]
        
        delog(up)
        SVPWillShow("载入中...")
        
        Net.share.getRequest(urlString: cancleOrder_27_joggle, params: up, success: { (datas) in
            let json = JSON(datas)
            delog(json)
            SVPHide()
            if json["code"].int == 1 {
                self.navigationController?.popViewController(animated: true)
            }
        }) { (error) in
            delog(error)
        }
    }
    
    private func buildData() {
        
        let up = ["mobileCode":Defaults["mobileCode"].stringValue,
                  "SESSIONID":Defaults["SESSIONID"].stringValue,
                  "id":orderId]
            as [String: Any]
        
        
        delog(up)
        SVPWillShow("载入中...")
        
        Net.share.getRequest(urlString: (isPayFinalMoney ? payRetainage_46_joggle : pay_26_joggle), params: up, success: { (datas) in
            let json = JSON(datas)
            delog(json)
            SVPHide()
            if json["code"].int == 1 {
                self.meMoney.text = "账户余额：￥\(json["data"]["balance"].float!)"
                self.price.text = "\(json["data"]["price"].float!)"
                if !self.isPayFinalMoney {
                    self.time(json["data"]["overTime"].int32!)
                }else {
                    self.residueTime.isHidden = true
                }
                self.myMoney = json["data"]["balance"].float!
                self.myPrice = json["data"]["price"].float!
                self.appPayHow.text = "\(json["data"]["price"].float!)"
            }
        }) { (error) in
            delog(error)
        }
    }
    
    private func time(_ s: Int32) {
        
        var second = s
        let timer = DispatchSource.makeTimerSource(queue:DispatchQueue.global())
        timer.scheduleRepeating(deadline: .now(), interval: .seconds(1))
        timer.setEventHandler(handler: {
            second -= 1
            if second <= 0 {
                timer.cancel()
                SVPwillShowAndHide("支付超时")
                self.navigationController?.popViewController(animated: true)
            }
            DispatchQueue.main.async {
                
                let hour = ("\(second/3600)"=="0") ? "" : "\(second/3600):"
                let min = ("\((second%3600)/60)"=="0") ? "" : "\((second%3600)/60):"
                let sec = "\(second%60)"
                self.residueTime.text = "订单剩余支付时间："+hour+min+sec
            }
        })
        timer.resume()
    }
    
    @objc private func tapClick(_ sender: UITapGestureRecognizer) {
        
        switch sender.view! {
        case alipay:
            
            if isMoneyNoteEnough {
                
                secondType = "1"
                alipaySelect.image = UIImage(named:"selector_selector_pressed")
                weichatPaySelect.image = UIImage(named:"selector_selector_default")
                return
            }
            //支付宝
            currentType = "1"
            alipaySelect.image = UIImage(named:"selector_selector_pressed")
            weichatPaySelect.image = UIImage(named:"selector_selector_default")
            appPaySelect.image = UIImage(named:"selector_selector_default")
            break
        case weichatPay:
            
            if isMoneyNoteEnough {
                
                secondType = "2"
                alipaySelect.image = UIImage(named:"selector_selector_default")
                weichatPaySelect.image = UIImage(named:"selector_selector_pressed")
                return
            }
            currentType = "2"
            alipaySelect.image = UIImage(named:"selector_selector_default")
            weichatPaySelect.image = UIImage(named:"selector_selector_pressed")
            appPaySelect.image = UIImage(named:"selector_selector_default")
            //微信
            break
        case appPay:
            
            //联合支付的时候 首先消耗账号余额

            if isMoneyNoteEnough {
                
                //变更优先支付方式
                currentType = secondType
                secondType = "0"
                isMoneyNoteEnough = !isMoneyNoteEnough
                appPaySelect.image = UIImage(named:"selector_selector_default")
                return
            }
            if myMoney < myPrice {
                secondType = currentType
                currentType = "3"
                isMoneyNoteEnough = true
                appPaySelect.image = UIImage(named:"selector_selector_pressed")
                return
            }
            currentType = "3"
            alipaySelect.image = UIImage(named:"selector_selector_default")
            weichatPaySelect.image = UIImage(named:"selector_selector_default")
            appPaySelect.image = UIImage(named:"selector_selector_pressed")

            //余额支付
            break
        default:
            break
        }
    }
    
    @IBAction func click(_ sender: UIButton) {
        
        
        
        if currentType == "0" {
            SVPwillShowAndHide("请选择支付方式")
        }
        delog("currentType -->   \(currentType)")
        delog("secondType  -->   \(secondType)")
        
        if currentType == "3"{
            if secondType == "0" {
                if self.myMoney >= myPrice {
                    toApp()
                }else{
                    SVPwillShowAndHide("您的余额不足")
                }
            }else if secondType == "1" {
                //如果优先使用余额支付 不够的地方再使用支付宝的话
                toAliPay(true)
            }else {
                toWeichat(myPrice-myMoney)
            }
        }else {
            if currentType == "1" {
                toAliPay(false)
            }else {
                toWeichat(myPrice)
            }
        }
    }
    // MARK: - 支付宝支付
    private func toAliPay(_ idUseBalance: Bool) {
        
        //判断是否设置过密码
        var up = ["mobileCode":Defaults["mobileCode"].stringValue,
                  "SESSIONID":Defaults["SESSIONID"].stringValue,
                  "id":orderId]
            as [String: Any]
        
        if idUseBalance {
            up["balance"] = myMoney
        }
        
        delog(up)
        SVPWillShow("载入中...")
        
        Net.share.postRequest(urlString: payByAlipay_31_joggle, params: up, success: { (datas) in
            let json = JSON(datas)
            SVPHide()
            delog(json)
            if json["code"].int == 1 {
                
               self.gotoAliPay(json["data"]["apliyOrderInfo"].string!)
            }else {
                SVPwillShowAndHide(json["message"].string!)
            }
        }) { (error) in
            delog(error)
        }
    }
    
    private func gotoAliPay(_ orderInfo: String) {
        
        let aliPayManager = AlipaySDK.defaultService()
        aliPayManager?.payOrder(orderInfo, fromScheme: "healthAndBeautyUserWithRongXingRuanJian", callback: { (resultDic) in
            if resultDic?["resultStatus"]! as! String == "9000" ||
                resultDic?["resultStatus"]! as! String == "8000" {
                //跳转到评分界面
                delog("支付成功")
                let result = (resultDic?[AnyHashable("result")]! as! String)
                let json = JSON.init(parseJSON: result)
                let model = aliPayModel()
                model.out_trade_no = json["alipay_trade_app_pay_response"]["out_trade_no"].string!
                model.trade_no = json["alipay_trade_app_pay_response"]["trade_no"].string!
                self.AliPayPaySuccess(model)
            }
        })
    }
    
    private func toWeichat(_ price: Float) {
        delog(price)
    }
    
    private func toApp() {
        
        //判断是否设置过密码
        let up = ["mobileCode":Defaults["mobileCode"].stringValue,
                  "SESSIONID":Defaults["SESSIONID"].stringValue]
            as [String: Any]
        
        delog(up)
        SVPWillShow("载入中...")
        
        Net.share.postRequest(urlString: checkBalance_28_joggle, params: up, success: { (datas) in
            let json = JSON(datas)
            SVPHide()
            delog(json)
            if json["code"].int == 3 {
                
                SVPwillShowAndHide("您没有设置支付密码，正在前往支付密码设置页面")
                let reSet = NewSetPasswordViewController.init(nibName: "NewSetPasswordViewController", bundle: nil)
                reSet.firstSet = true
                self.navigationController?.pushViewController(reSet, animated: true)
            }else if json["code"].int == 1 {
                self.ShowView()
            }
        }) { (error) in
            delog(error)
        }
    }
    
    private func checkPassword(_ password: String) {
        
        //判断密码是否正确
        let up = ["mobileCode":Defaults["mobileCode"].stringValue,
                  "SESSIONID":Defaults["SESSIONID"].stringValue,
                  "pwd":password]
            as [String: Any]
        
        delog(up)
        SVPWillShow("载入中...")
        
        Net.share.postRequest(urlString: checkPayPwd_29_joggle, params: up, success: { (datas) in
            let json = JSON(datas)
            delog(json)
            if json["code"].int == 1 {
                self.paySuccess()
            }else {
                SVPHide()
                SVPwillShowAndHide("密码错误")
                self.textField?.clearKeyCode()
                self.textField!.textField.becomeFirstResponder()
            }
        }) { (error) in
            delog(error)
        }
    }
    
    private func paySuccess() {
        
        //支付成功
        let up = ["mobileCode":Defaults["mobileCode"].stringValue,
                  "SESSIONID":Defaults["SESSIONID"].stringValue,
                  "id":orderId]
            as [String: Any]
        
        delog(up)
        let str = isPayFinalMoney ? payRetainageByBalance_49_joggle : payByBalance_30_joggle
        Net.share.postRequest(urlString: str, params: up, success: { (datas) in
            let json = JSON(datas)
            SVPHide()
            delog(json)
            if json["code"].int == 1 {
                let success = NewPaySuccessOrFailedViewController.init(nibName: "NewPaySuccessOrFailedViewController", bundle: nil)
                success.isSuccess = true
                self.navigationController?.pushViewController(success, animated: true)
            }else {
                self.hideView()
                self.textField?.clearKeyCode()
                self.textField!.textField.becomeFirstResponder()
            }
        }) { (error) in
            delog(error)
        }
    }
    
    private func AliPayPaySuccess(_ model: aliPayModel) {
        
        //支付成功
        var up = ["mobileCode":Defaults["mobileCode"].stringValue,
                  "SESSIONID":Defaults["SESSIONID"].stringValue,
                  "out_trade_no":model.out_trade_no,
                  "trade_no":model.trade_no]
            as [String: Any]
        
        if currentType == "3" && secondType == "1" {
            up["balance"] = myMoney
        }
        delog(up)
        
        Net.share.postRequest(urlString: synchronization_33_joggle, params: up, success: { (datas) in
            let json = JSON(datas)
            SVPHide()
            delog(json)
            if json["code"].int == 1 {
                let success = NewPaySuccessOrFailedViewController.init(nibName: "NewPaySuccessOrFailedViewController", bundle: nil)
                success.isSuccess = true
                self.navigationController?.pushViewController(success, animated: true)
            }
        }) { (error) in
            delog(error)
        }
    }
    
    private func ShowView() {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.alphaView.alpha = 0.3
            self.payView.alpha = 1
            var frame = self.payView.frame
            frame.origin.y = 150
            self.payView.frame = frame
        }) { (_) in
            self.textField!.textField.becomeFirstResponder()
        }
    }
    
    @objc private func hideView() {
        
        textField!.textField.resignFirstResponder()
        
        UIView.animate(withDuration: 0.35, animations: {
            self.alphaView.alpha = 0
            self.payView.alpha = 0
        }) { (_) in
        }
    }
}
