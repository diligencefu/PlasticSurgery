//
//  MemberViewController.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/6.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MemberViewController:Wx_baseViewController,UITableViewDelegate,UITableViewDataSource {
    
    var mainTableView = UITableView()
    var mainTableArr = NSMutableArray()

    let identyfierTable  = "identyfierTable"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestData()
        configSubViews()
    }
    
    func requestData() {
        
        let params = [
            "mobileCode" : Defaults["mobileCode"].stringValue,
            "SESSIONID" : Defaults["SESSIONID"].stringValue
        ]
        SVPWillShow("加载中...")
        Alamofire.request(member_List,
                          method: .get, parameters: params,
                          encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                            deBugPrint(item: response.result)
                            switch response.result {
                            case .success:
                                if let j = response.result.value {
                                    //SwiftyJSON解析数据
                                    let JSOnDictory = JSON(j)
                                    let datas =  JSOnDictory["data"]["memberList"].arrayValue
                                    let code =  JSOnDictory["code"].stringValue
                                    if code == "0" {
                                        setToast(str: "请求失败1")
                                    }else{
                                        
                                        for index in 0..<datas.count {
                                            
                                            let json = datas[index]
                                            let model  = MemberModel.setValueForMemberModel(json: json)
                                            self.mainTableArr.add(model)
                                        }
                                        
                                        self.mainTableView.reloadData()
                                    }
                                    SVPHide()
                                }
                                break
                            case .failure(let error):
                                deBugPrint(item: error)
                                setToast(str: "请求失败2")
                            }
        }
        
    }

    
    func configSubViews() {
        
        createNaviController(title: "会员中心", leftBtn: buildLeftBtn(), rightBtn: nil)
        
        mainTableView = UITableView.init(frame: CGRect(x: 0, y: 64, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT - 64 ), style: .plain)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.estimatedRowHeight = 143 * kSCREEN_SCALE;
        mainTableView.register(UINib(nibName: "MemberCenterCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
        mainTableView.tableFooterView = UIView()
        self.view.addSubview(mainTableView)
        mainTableView.backgroundColor = kSetRGBColor(r: 239, g: 239, b: 244)
    }
    
    
    //MARK:  ******代理 ：UITableViewDataSource,UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainTableArr.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = mainTableArr[indexPath.row] as! MemberModel
        deBugPrint(item: model.memberImage)
        let cell : MemberCenterCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! MemberCenterCell
        cell.MemberCenterCellsetValuesWithModel(model:model)
        cell.buyNowAction = {
            if model.buy != "false" {
                self.addTipView(idNum: model.id)
            }else{
                self.buyNowAction(idNum: model.id)
            }
        }        
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
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
        
        if section != 0{
            return 10
        }
        return 0
    }
    
    func addTipView(idNum:String) {
        let alert = UIAlertController.init(title: "提示", message: "您已经购买过该产品，确定再次购买吗？", preferredStyle: .alert)
        
        let action1 = UIAlertAction.init(title: "确定购买", style: .destructive) { (alertAction) in
            self.buyNowAction(idNum: idNum)
        }
        let action2 = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
        
        alert.addAction(action1)
        alert.addAction(action2)
        
        self.present(alert, animated: true, completion: nil)

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
                                            let pay = PayMemberViewController()
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
    
}
