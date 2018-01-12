//
//  FYHBsRecordViewController.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/11.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FYHBsRecordViewController: Base2ViewController {
    
    var isRecharge = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addFooterRefresh()
    }
    
    override func configSubViews() {
        
        if isRecharge {
            setupTitleViewSectionStyle(titleStr: "充值记录")
        }else{
            setupTitleViewSectionStyle(titleStr: "提现记录")
        }

        mainTableView = UITableView.init(frame: CGRect(x: 0,
                                                       y: CGFloat(navHeight),
                                                       width: kSCREEN_WIDTH,
                                                       height: kSCREEN_HEIGHT - 64 ),
                                         style: .grouped)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.estimatedRowHeight = 80
        mainTableView.register(UINib(nibName: "FYHAccountRecordCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
        self.view.addSubview(mainTableView)
    }
    
    
    override func refreshHeaderAction() {
        currentPage = 1
        requestData()
    }
    
    
    override func refreshFooterAction() {
        currentPage = currentPage+1
        requestData()
    }
    
    
    override func requestData() {
        
        let params = [
            "mobileCode" : Defaults["mobileCode"].stringValue,
            "SESSIONID" : Defaults["SESSIONID"].stringValue,
            "pageNO":String(currentPage)
        ]
        SVPWillShow("加载中...")
        
        var urlStr = present_RecordList
        
        if isRecharge {
            urlStr = recharge_List
        }
        
        Alamofire.request(urlStr,
                          method: .get,
                          parameters: params,
                          encoding: URLEncoding.default,
                          headers: nil).responseJSON {
                            (response) in
                            deBugPrint(item: response.result)
                            switch response.result {
                            case .success:
                                if let j = response.result.value {
                                    //SwiftyJSON解析数据
                                    let JSOnDictory = JSON(j)
                                    let data =  JSOnDictory["data"]["presentRecordList"].arrayValue
                                    let code =  JSOnDictory["code"].stringValue
                                    if code == "0" {
                                        setToast(str: "请求失败")
                                    }else{
                                        self.totalPage = JSOnDictory["data"]["totalPage"].stringValue
                                        if self.currentPage == 1 {
                                            self.mainTableArr.removeAllObjects()
                                            self.mainTableView.mj_header.endRefreshing()
                                            if self.currentPage == Int(self.totalPage) {
                                                self.mainTableView.mj_footer.endRefreshingWithNoMoreData()
                                            }else{
                                                self.mainTableView.mj_footer.resetNoMoreData()
                                            }
                                        }else{
                                            if self.currentPage == Int(self.totalPage) {
                                                self.mainTableView.mj_footer.endRefreshingWithNoMoreData()
                                            }else{
                                                self.mainTableView.mj_footer.endRefreshing()
                                            }
                                        }
                                        
                                        for index in 0..<data.count {
                                            let model = FYHWRecordModel.setValueForFYHWRecordModel(json: data[index])
                                            self.mainTableArr.add(model)
                                        }
                                        SVPHide()
                                        self.mainTableView.reloadData()
                                    }
                                }
                                break
                            case .failure(let error):
                                deBugPrint(item: error)
                                SVPwillShowAndHide("加载失败")
                                setToast(str: "请求失败")
                            }
        }
        
    }
    
    
    //    ******************代理 ： UITableViewDataSource,UITableViewDelegate  ************
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return mainTableArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = mainTableArr[indexPath.section] as! FYHWRecordModel
        
        let cell : FYHAccountRecordCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! FYHAccountRecordCell
        cell.FYHAccountRecordCellSetValuesWithdraw(model: model)
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
        if section == 0 {
            return 0.001
        }
        
        return 19 * kSCREEN_SCALE
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01 * kSCREEN_SCALE
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let model = mainTableArr[indexPath.section] as! FYHWRecordModel
            let params1 = [
                "mobileCode" : Defaults["mobileCode"].stringValue,
                "SESSIONID" : Defaults["SESSIONID"].stringValue,
                "id":model.id
                ] as [String:String]
            SVPWillShow("加载中...")
            Alamofire.request(del_PresentRecord,
                              method: .post,
                              parameters: params1,
                              encoding: URLEncoding.default,
                              headers: nil).responseJSON {
                                (response) in
                                deBugPrint(item: response.result)
                                switch response.result {
                                case .success:
                                    if let j = response.result.value {
                                        //SwiftyJSON解析数据
                                        let JSOnDictory = JSON(j)
                                        let code =  JSOnDictory["code"].stringValue
                                        if code == "0" {
                                            setToast(str: "删除失败")
                                        }else{
                                            tableView.mj_header.beginRefreshing()
                                            setToast(str: "删除成功")
                                        }
                                    }
                                    break
                                case .failure(let error):
                                    deBugPrint(item: error)
                                    setToast(str: "删除失败")
                                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        
        return "删除记录"
    }
    
}
