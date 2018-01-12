//
//  FYHRechargeOrCashVC.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/9.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FYHRechargeOrCashVC: Base2ViewController {
    
    let images = ["01_alipay_head_default","03_wechat_head_default"]
    let ways = ["支付宝支付","微信支付"]
    
    var orderId = ""
    
    var selectWay = 10
    
    var isRecharge = false
    
    var textField = UITextField()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestData()
        configSubViews()
    }
    
    
    
    override func configSubViews() {
        if !isRecharge {
            setupTitleViewSectionStyle(titleStr: "选择提现方式")
            btnTitle = "提现记录"
        }else{
            setupTitleViewSectionStyle(titleStr: "选择充值方式")
            btnTitle = "充值记录"
        }

        mainTableView = UITableView.init(frame: CGRect(x: 0, y: 64, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT - 64 ), style: .plain)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.estimatedRowHeight = 143 * kSCREEN_SCALE;
        mainTableView.register(UINib(nibName: "PayHeadCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
        mainTableView.register(UINib(nibName: "PayWayCell", bundle: nil), forCellReuseIdentifier: identyfierTable1)
        mainTableView.tableFooterView = UIView()
        self.view.addSubview(mainTableView)
        mainTableView.backgroundColor = kSetRGBColor(r: 239, g: 239, b: 244)
        
        if isRecharge {
            
            //        footView
            let headView = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 60))
            textField = UITextField.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 45))
            textField.placeholder = "请输入充值金额"
            textField.textColor = kGaryColor(num: 117)
            textField.leftViewRect(forBounds: CGRect(x: 0, y: 0, width: 80, height: 45))
            textField.center = headView.center
            textField.backgroundColor = UIColor.white
            textField.leftViewMode = .always
            textField.keyboardType = .numberPad
            let leftBG1 = UIView.init(frame: CGRect(x: 0, y: 0, width: 80, height: 45))
            let leftView = UILabel.init(frame: CGRect(x: 0, y: 0, width: 80, height: 45))
            leftView.textColor = kGaryColor(num: 117)
            leftView.text = " 充值:(元)"
            leftBG1.addSubview(leftView)
            textField.leftView = leftBG1
            headView.addSubview(textField)
            mainTableView.tableHeaderView = headView
            
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
        
    }
    
    
    @objc func certainPayAction(sender:UIButton) {
        
        if textField.text?.count == 0 {
            setToast(str: "请输入金额！")
            return
        }
        
        if selectWay == 10 {
            setToast(str: "请选择充值方式！")
            return
        }
        
        if selectWay == 0 {
            toAliPay()
        }else if selectWay == 1 {
            toWeichat(Float(textField.text!)!)
        }
    }
    
    
    override func rightAction(sender: UIButton) {
        let recordVC = FYHBsRecordViewController()
        recordVC.isRecharge = isRecharge
        self.navigationController?.pushViewController(recordVC, animated: true)
    }
    
    
    //MARK:  ******代理 ：UITableViewDataSource,UITableViewDelegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : PayWayCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable1, for: indexPath) as! PayWayCell
        
        if !isRecharge {
            cell.accessoryType = .disclosureIndicator
            cell.PayWayCellSetValuesRecharge(image: images[indexPath.row], title: ways[indexPath.row])
        }else{
            var select = false
            let balance = ""
            if selectWay == indexPath.row {
                select = true
            }

            cell.PayWayCellSetValues(image: images[indexPath.row], title: ways[indexPath.row], balance1: balance, select: select)
        }
            return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if isRecharge {
            if selectWay == indexPath.row {
                selectWay = 10
            }else{
                selectWay = indexPath.row
            }
            tableView.reloadData()
        }else{
            let withdrawVC = FYHWithdrawViewController()
            withdrawVC.withdrawalType = String(indexPath.row+1)
            self.navigationController?.pushViewController(withdrawVC, animated: true)
        }
    }
    
    
    // MARK: - 支付宝支付
    private func toAliPay() {
        
        //判断是否设置过密码
        let up = ["mobileCode":Defaults["mobileCode"].stringValue,
                  "SESSIONID":Defaults["SESSIONID"].stringValue,
                  "amount":textField.text!]
            as [String: Any]
        
        delog(up)
        SVPWillShow("载入中...")
        
        Net.share.postRequest(urlString: recharge_ByAlipay, params: up, success: { (datas) in
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
