//
//  FYHWithdrawViewController.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/9.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FYHWithdrawViewController: Base2ViewController {
    var titles = [["真实姓名:","支付宝账号:"],["提现金额:",""]]
    var mainModel = FYHWithdrawModel()
    var withdrawalType = ""
    var certainBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configSubViews() {
        setupTitleViewSectionStyle(titleStr: "提现")
        btnTitle = "提现须知"
        
        if withdrawalType == "2" {
            titles = [["真实姓名:","微信号:"],["提现金额:",""]]
        }
        
        mainTableView = UITableView.init(frame: CGRect(x: 0,
                                                       y: CGFloat(navHeight),
                                                       width: kSCREEN_WIDTH,
                                                       height: kSCREEN_HEIGHT - 64 ),
                                         style: .grouped)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.estimatedRowHeight = 80
        mainTableView.register(UINib(nibName: "FYHRechargeCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
        self.view.addSubview(mainTableView)
        //        footView
        let footView = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 150))
        footView.backgroundColor = UIColor.clear
        certainBtn = UIButton.init(frame: CGRect(x: 60 * kSCREEN_SCALE, y: (150-86*kSCREEN_SCALE)/2, width: kSCREEN_WIDTH - 120 * kSCREEN_SCALE, height: 86 * kSCREEN_SCALE))
        certainBtn.layer.cornerRadius = 10 * kSCREEN_SCALE
        certainBtn.clipsToBounds = true
        certainBtn.setTitle("提现", for: .normal)
        self.certainBtn.isEnabled = false
        self.certainBtn.setTitleColor(kSetRGBColor(r: 117, g: 117, b: 117), for: .normal)
        self.certainBtn.backgroundColor = kSetRGBColor(r: 222, g: 222, b: 222)
        certainBtn.addTarget(self, action: #selector(certainPayAction(sender:)), for: .touchUpInside)
        footView.addSubview(certainBtn)
        mainTableView.tableFooterView = footView
    }
    
    
    override func addHeaderRefresh() {
        
    }
    
    override func rightAction(sender: UIButton) {
        let tipVC = FYHWithdrawTipVC()
        tipVC.mainModel = mainModel
        self.navigationController?.pushViewController(tipVC, animated: true)
    }

    
    @objc func certainPayAction(sender:UIButton) {
        
        let cell3 = mainTableView.cellForRow(at: IndexPath.init(row: 0, section: 1)) as! FYHRechargeCell

        let str = "您选择提现:"+cell3.content.text!+"元，加上手续费"+String(Float(cell3.content.text!)!*Float(mainModel.withdrawDiscount!)!)+"元，实际扣款:"+String(Float(cell3.content.text!)!+Float(cell3.content.text!)!*Float(mainModel.withdrawDiscount!)!)+"元。"
        
        let alert = UIAlertController.init(title: "提示", message: str, preferredStyle: .alert)
        
        let action1 = UIAlertAction.init(title: "确定提现", style: .default) { (alertAction) in
            self.withdrawAction()
        }
        let action2 = UIAlertAction.init(title: "取消", style: .destructive, handler: nil)
        
        alert.addAction(action1)
        alert.addAction(action2)
        
        self.present(alert, animated: true, completion: nil)
    }

    func withdrawAction() {
        
        let cell1 = mainTableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! FYHRechargeCell
        let cell2 = mainTableView.cellForRow(at: IndexPath.init(row: 1, section: 0)) as! FYHRechargeCell
        let cell3 = mainTableView.cellForRow(at: IndexPath.init(row: 0, section: 1)) as! FYHRechargeCell
        
        let params = [
            "mobileCode" : Defaults["mobileCode"].stringValue,
            "SESSIONID" : Defaults["SESSIONID"].stringValue,
            "name":cell1.content.text!,
            "account":cell2.content.text!,
            "amount":cell3.content.text!,
            "withdrawalType":withdrawalType,
            ]
        Alamofire.request(withdraw_ByAlipay,
                          method: .post, parameters: params,
                          encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                            deBugPrint(item: response.result)
                            switch response.result {
                            case .success:
                                if let j = response.result.value {
                                    //SwiftyJSON解析数据
                                    let JSOnDictory = JSON(j)
                                    let code =  JSOnDictory["code"].stringValue
                                    if code == "0" {
                                        setToast(str: "提现失败")
                                    }else if code == "1"{
                                        setToast(str: "提现成功")
                                        self.requestData()
                                    }
                                }
                                break
                            case .failure(let error):
                                deBugPrint(item: error)
                                setToast(str: "提现失败")
                            }
        }
    }
    
    

    override func requestData() {
        
        let params = [
            "mobileCode" : Defaults["mobileCode"].stringValue,
            "SESSIONID" : Defaults["SESSIONID"].stringValue
        ]
        SVPWillShow("加载中...")
        Alamofire.request(withdraw_Info,
                          method: .get, parameters: params,
                          encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                            deBugPrint(item: response.result)
                            switch response.result {
                            case .success:
                                if let j = response.result.value {
                                    //SwiftyJSON解析数据
                                    let JSOnDictory = JSON(j)
                                    let data =  JSOnDictory["data"]
                                    let code =  JSOnDictory["code"].stringValue
                                    if code == "0" {
                                        setToast(str: "请求失败")
                                    }else{
                                        
                                        self.mainModel = FYHWithdrawModel.setValueForFYHWithdrawModel(json: data)
                                        self.titles[1][1] = "可提现金额:￥"+self.mainModel.cashBalance
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
    
    
    //    ******************代理 ： UITableViewDataSource,UITableViewDelegate  ************
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles[section].count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return titles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : FYHRechargeCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! FYHRechargeCell
        
        var index = 0
        
        if indexPath.section == 0 {
            index = indexPath.row+1
        }else{
            index = indexPath.row+3
        }
        
        if mainModel.cashBalance == nil {
            titles[1][1] = "可提现金额:￥"+"0"
        }
        
        cell.FYHRechargeCellSetValues(title: titles[indexPath.section][indexPath.row],index:index,model:mainModel)
        cell.selectionStyle = .none
        cell.textDidChangedBlock = {
            
            
            let cell1 = tableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! FYHRechargeCell
            let cell2 = tableView.cellForRow(at: IndexPath.init(row: 0, section: 1)) as! FYHRechargeCell
            let cell3 = tableView.cellForRow(at: IndexPath.init(row: 1, section: 0)) as! FYHRechargeCell

            if cell1.content.text!.count > 0 && cell2.content.text!.count > 0 && cell3.content.text!.count > 0{
                
                self.certainBtn.isEnabled = true
                self.certainBtn.setTitleColor(kSetRGBColor(r: 255, g: 255, b: 255), for: .normal)
                self.certainBtn.backgroundColor = kSetRGBColor(r: 255, g: 93, b: 94)
            }else{
                
                self.certainBtn.isEnabled = false
                self.certainBtn.setTitleColor(kSetRGBColor(r: 117, g: 117, b: 117), for: .normal)
                self.certainBtn.backgroundColor = kSetRGBColor(r: 222, g: 222, b: 222)
            }
            
            if !$0 {
                self.titles[1][1] = $1
                tableView.reloadRows(at: [IndexPath.init(row: 1, section: 1)], with: .none)
                
                self.certainBtn.isEnabled = false
                self.certainBtn.setTitleColor(kSetRGBColor(r: 117, g: 117, b: 117), for: .normal)
                self.certainBtn.backgroundColor = kSetRGBColor(r: 222, g: 222, b: 222)
            }else{
                
                self.titles[1][1] = "可提现金额:￥"+self.mainModel.cashBalance
                tableView.reloadRows(at: [IndexPath.init(row: 1, section: 1)], with: .none)
            }

        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 19 * kSCREEN_SCALE))
        view.backgroundColor = UIColor.blue
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 19 * kSCREEN_SCALE))
        view.backgroundColor = kSetRGBColor(r: 239, g: 239, b: 244)
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 19 * kSCREEN_SCALE
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01 * kSCREEN_SCALE
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
