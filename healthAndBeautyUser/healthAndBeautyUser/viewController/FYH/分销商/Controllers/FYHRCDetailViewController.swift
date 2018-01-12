//
//  FYHRCDetailViewController.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/8.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FYHRCDetailViewController: Base2ViewController {

    let titles = ["未返现金额:","每期返现:","期数:","开始时间:","返现日:","返现状态:"]
    var contents = [String]()
    
    var mainModel = FYHRCDetailModel()
    var id = ""
    
    //0:会员返现详情，1:已完成的免费整形订单返现详情:
    var type = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configSubViews() {
        setupTitleViewSectionStyle(titleStr: "返现详情")
        
        mainTableView = UITableView.init(frame: CGRect(x: 0,
                                                       y: CGFloat(navHeight),
                                                       width: kSCREEN_WIDTH,
                                                       height: kSCREEN_HEIGHT - 64 ),
                                         style: .grouped)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.estimatedRowHeight = 80
        mainTableView.register(UINib(nibName: "FYHReturnCashCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
        mainTableView.register(UINib(nibName: "FYHRCDetailCell", bundle: nil), forCellReuseIdentifier: identyfierTable1)
        self.view.addSubview(mainTableView)
        
    }
    override func addHeaderRefresh() {
        
    }
    override func requestData() {
        
        let params = [
            "mobileCode" : Defaults["mobileCode"].stringValue,
            "SESSIONID" : Defaults["SESSIONID"].stringValue,
            "id":id
        ]
        SVPWillShow("加载中...")

        var url = user_VipCashBack
        
        if type == 1 {
            url = user_OrderCashBack
        }
        
        Alamofire.request(url,
                          method: .get, parameters: params,
                          encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                            deBugPrint(item: response.result)
                            switch response.result {
                            case .success:
                                if let j = response.result.value {
                                    //SwiftyJSON解析数据
                                    let JSOnDictory = JSON(j)
                                    var data = JSON()
                                    var dataDetail = JSON()
                                    
                                    if self.type == 0 {
                                        data = JSOnDictory["data"]["vipCashBack"]
                                        dataDetail = JSOnDictory["data"]["vipDetaileds"]
                                    }else if self.type == 1 {
                                        data = JSOnDictory["data"]["orderCashBack"]
                                        dataDetail = JSOnDictory["data"]["orderDetaileds"]
                                    }
                                    
                                    let code =  JSOnDictory["code"].stringValue
                                    if code == "0" {
                                        setToast(str: "请求失败")
                                    }else{
                                        
                                        self.mainModel = FYHRCDetailModel.setValueForFYHRCDetailModel(json: data)
                                        self.mainTableArr.addObjects(from: FYHRCDetailModel2.setValueForFYHRCDetailModel2(data: dataDetail))

                                        self.contents.append("￥"+self.mainModel.surplus)
                                        self.contents.append("￥"+self.mainModel.eachAmount)
                                        self.contents.append(self.mainModel.periods+"/"+String(self.mainTableArr.count))
                                        self.contents.append(self.mainModel.enableDate)
                                        
                                        if self.mainModel.cashbackType == "1" {
                                            self.contents.append("每周"+self.mainModel.cashbackDay)
                                        }else{
                                            self.contents.append("每月"+self.mainModel.cashbackDay+"号")
                                        }
                                        
                                        if self.mainModel.cashbackStatus == "1" {
                                            self.contents.append("进行中")
                                        }else{
                                            self.contents.append("已结束")
                                        }

                                        self.contents.append("￥"+self.mainModel.surplus)
                                        SVPHide()
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
        
        if section == 0 {
            if mainModel.cashback == nil{
                return 0
            }
            return 6
        }
        return mainTableArr.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell : FYHRCDetailCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable1, for: indexPath) as! FYHRCDetailCell
            cell.FYHRCDetailCellSetValues(title: titles[indexPath.row], content: contents[indexPath.row])
            return cell
        }else{
            
            let model = mainTableArr[indexPath.row] as! FYHRCDetailModel2
            let cell : FYHReturnCashCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! FYHReturnCashCell
            cell.FYHReturnCashCellSetValuesDetail(model:model)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let label = UILabel.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 19 * kSCREEN_SCALE))
        label.backgroundColor = UIColor.blue
        label.text = " 返现明细"
        return label
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 19 * kSCREEN_SCALE))
        view.backgroundColor = kSetRGBColor(r: 239, g: 239, b: 244)
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        
        return 19
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    

}
