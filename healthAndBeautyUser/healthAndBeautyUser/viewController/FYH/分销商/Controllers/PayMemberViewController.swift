//
//  PayMemberViewController.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/6.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PayMemberViewController: Wx_baseViewController,UITableViewDelegate,UITableViewDataSource ,HBAlertPasswordViewDelegate{
    
    var mainTableView = UITableView()
    var mainTableArr = NSMutableArray()
    
    let identyfierTable  = "identyfierTable"
    let identyfierTable1  = "identyfierTable1"
    let identyfierTable2  = "identyfierTable2"

    let images = ["01_alipay_head_default","03_wechat_head_default","02_Balancepay_head_default"]
    let ways = ["支付宝支付","微信支付","余额支付"]

    var orderId = ""
    var model = FYHPayModel()
    
    var selectWay = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestData()
        configSubViews()
    }
    
    func requestData() {
        
        let params = [
            "mobileCode" : Defaults["mobileCode"].stringValue,
            "SESSIONID" : Defaults["SESSIONID"].stringValue,
            "id" : orderId
        ]
        Alamofire.request(pay_Data,
                          method: .get, parameters: params,
                          encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                            deBugPrint(item: response.result)
                            switch response.result {
                            case .success:
                                if let j = response.result.value {
                                    //SwiftyJSON解析数据
                                    let JSOnDictory = JSON(j)
                                    let datas =  JSOnDictory["data"]
                                    let code =  JSOnDictory["code"].stringValue
                                    if code == "0" {
                                        setToast(str: "请求失败1")
                                    }else{
                                        self.model  = FYHPayModel.setValueForFYHPayModel(json: datas)
                                        self.mainTableView.reloadData()
                                    }
                                    SVPHide()
                                }
                                break
                            case .failure(let error):
                                deBugPrint(item: error)
                                setToast(str: "请求失败")
                                SVPHide()
                            }
        }
        
    }
    
    
    func configSubViews() {
        
        createNaviController(title: "支付订单", leftBtn: buildLeftBtn(), rightBtn: nil)
        
        mainTableView = UITableView.init(frame: CGRect(x: 0, y: 64, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT - 64 ), style: .plain)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.estimatedRowHeight = 143 * kSCREEN_SCALE;
        mainTableView.register(UINib(nibName: "PayHeadCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
        mainTableView.register(UINib(nibName: "PayWayCell", bundle: nil), forCellReuseIdentifier: identyfierTable1)
        mainTableView.tableFooterView = UIView()
        self.view.addSubview(mainTableView)
        mainTableView.backgroundColor = kSetRGBColor(r: 239, g: 239, b: 244)
        
        
//        footView
        let footView = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 150))
        footView.backgroundColor = UIColor.clear
        let certainPay = UIButton.init(frame: CGRect(x: 60 * kSCREEN_SCALE, y: (150-86*kSCREEN_SCALE)/2, width: kSCREEN_WIDTH - 120 * kSCREEN_SCALE, height: 86 * kSCREEN_SCALE))
        certainPay.layer.cornerRadius = 10 * kSCREEN_SCALE
        certainPay.clipsToBounds = true
        certainPay.backgroundColor = kSetRGBColor(r: 255, g: 93, b: 94)
        certainPay.setTitle("确定支付", for: .normal)
        certainPay.setTitleColor(kSetRGBColor(r: 255, g: 255, b: 255), for: .normal)
        certainPay.addTarget(self, action: #selector(certainPayAction(sender:)), for: .touchUpInside)
        footView.addSubview(certainPay)
        mainTableView.tableFooterView = footView
        
    }
    
    
    @objc func certainPayAction(sender:UIButton) {
//        sender.isEnabled = false
        if selectWay == 0 {
            toAliPay()
        }else if selectWay == 1 {
            toWeichat(Float(model.price)!)
        }else if selectWay == 2 {
             toApp()
        }else if selectWay == 10 {
            setToast(str: "请选择支付方式")
            return
        }
        
    }

    
    //MARK:  ******代理 ：UITableViewDataSource,UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if  section == 0 {
            if model.balance != nil {
                return 1
            }
            return 0
        }
        if model.balance != nil {
            return 3
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell : PayHeadCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! PayHeadCell
            cell.setValuesWithModel(model: model)
            cell.selectionStyle = .none
            return cell

        }else{
            let cell : PayWayCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable1, for: indexPath) as! PayWayCell
            
            var select = false
            var balance = ""
            if selectWay == indexPath.row {
                select = true
            }
            
            if Float(model.balance)! > Float(model.price)! {
                balance = model.balance
            }else{
                balance = "余额不足"
            }
            
            if indexPath.row != 2 {
                balance = ""
            }
            
            cell.PayWayCellSetValues(image: images[indexPath.row], title: ways[indexPath.row], balance1: balance, select: select)
            cell.selectionStyle = .none
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if model.balance != nil {
            if Float(model.balance)! < Float(model.price)! && indexPath.row == 2{
                setToast(str: "余额不足")
                return
            }
            selectWay = indexPath.row
        }
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        return 10
    }
    
    
    //   MARK: 立即购买
    func buyNowAction(idNum:String) {
        let params = [
            "mobileCode" : Defaults["mobileCode"].stringValue,
            "SESSIONID" : Defaults["SESSIONID"].stringValue,
            "id" : idNum
        ]
        Alamofire.request(buy_api,
                          method: .get, parameters: params,
                          encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                            deBugPrint(item: response.result)
                            switch response.result {
                            case .success:
                                if let j = response.result.value {
                                    //SwiftyJSON解析数据
                                    let JSOnDictory = JSON(j)
                                    let datas =  JSOnDictory["data"]["orderMemberId"].stringValue
                                    let code =  JSOnDictory["code"].stringValue
                                    if code == "0" {
                                        setToast(str: "请求失败1")
                                    }else{
                                        if datas != "" {
                                            let pay = NewStorePayDetailViewController.init(nibName: "NewStorePayDetailViewController", bundle: nil)
                                            pay.orderId = datas
                                            self.navigationController?.pushViewController(pay, animated: true)
                                            
                                        }
                                    }
                                }
                                break
                            case .failure(let error):
                                deBugPrint(item: error)
                                setToast(str: "请求失败2")
                            }
        }
        
    }
    
    
    // MARK: - 支付宝支付
    private func toAliPay() {
        
        //判断是否设置过密码
        let up = ["mobileCode":Defaults["mobileCode"].stringValue,
                  "SESSIONID":Defaults["SESSIONID"].stringValue,
                  "id":orderId]
            as [String: Any]
        
        delog(up)
        SVPWillShow("载入中...")
        
        Net.share.postRequest(urlString: pay_ByAlipay, params: up, success: { (datas) in
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

    
    
//    支付
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
                let passwd = HBAlertPasswordView.init(frame: self.view.bounds)
                passwd.delegate = self

                //                passwd.balance.text = label
                passwd.titleLabel.text = "请支付"+self.model.price+"元"
                self.view.addSubview(passwd)
            }
        }) { (error) in
            delog(error)
        }
    }
    
    //    HBAlertPasswordViewDelegate 密码弹框代理
    func sureAction(with alertPasswordView: HBAlertPasswordView!, password: String!) {
        alertPasswordView.removeFromSuperview()
        checkPassword(password)
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
        let str = pay_ByBalance
        Net.share.postRequest(urlString: str, params: up, success: { (datas) in
            let json = JSON(datas)
            SVPHide()
            delog(json)
            if json["code"].int == 1 {
                let success = NewPaySuccessOrFailedViewController.init(nibName: "NewPaySuccessOrFailedViewController", bundle: nil)
                success.isSuccess = true
                self.navigationController?.pushViewController(success, animated: true)
            }else {
                
            }
        }) { (error) in
            delog(error)
        }
    }
    
    private func AliPayPaySuccess(_ model: aliPayModel) {
        
        //支付成功
        let up = ["mobileCode":Defaults["mobileCode"].stringValue,
                  "SESSIONID":Defaults["SESSIONID"].stringValue,
                  "out_trade_no":model.out_trade_no,
                  "trade_no":model.trade_no]
            as [String: Any]
        
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

    
    
    
}

