//
//  FYHMissionCenterViewController.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/22.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FYHMissionCenterViewController: Base2ViewController {

    var dailyTastArr = NSMutableArray()
    var totalTastArr = NSMutableArray()

    var infoModel = FYHTaskCenrtInfoModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configSubViews() {
        
        setupTitleViewSectionStyle(titleStr: "任务中心")
        mainTableView = UITableView.init(frame: CGRect(x: 0,
                                                       y: CGFloat(navHeight),
                                                       width: kSCREEN_WIDTH,
                                                       height: kSCREEN_HEIGHT - 64 ),
                                         style: .grouped)
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.estimatedRowHeight = 80
        mainTableView.register(UINib(nibName: "FYHTaskCenterHeadCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
        mainTableView.register(UINib(nibName: "FYHTaskCenterShowCell", bundle: nil), forCellReuseIdentifier: identyfierTable1)
        self.view.addSubview(mainTableView)
    }
    
    
    override func refreshHeaderAction() {
        self.totalTastArr.removeAllObjects()
        self.dailyTastArr.removeAllObjects()
        requestData()
    }
    
    override func requestData() {
        
        let params = [
            "mobileCode" : Defaults["mobileCode"].stringValue,
            "SESSIONID" : Defaults["SESSIONID"].stringValue
        ]
        SVPWillShow("加载中...")
        Alamofire.request(kApi_taskCenter,
                          method: .get, parameters: params,
                          encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
                            deBugPrint(item: response.result)
                            switch response.result {
                            case .success:
                                if let j = response.result.value {
                                    //SwiftyJSON解析数据
                                    let JSOnDictory = JSON(j)
                                    let code = JSOnDictory["code"].intValue
                                    let personal = JSOnDictory["data"]["personal"]
                                    let cumulativeTasks = JSOnDictory["data"]["cumulativeTasks"].arrayValue
                                    let everyTasks = JSOnDictory["data"]["everyTasks"].arrayValue
                                    if code == 1 {
                                        
                                        self.infoModel = FYHTaskCenrtInfoModel.setValueForFYHTaskCenrtInfoModel(json: personal)
                                        
//                                        累计任务
                                        for index in 0..<cumulativeTasks.count {
                                            let json = JSON(cumulativeTasks[index])
                                            let model = FYHTaskCenterShowModel.setValueForFYHTaskCenterShowModel(json: json)
                                            self.totalTastArr.add(model)
                                        }
                                        
//                                        日常任务
                                        for index in 0..<everyTasks.count {
                                            let json = JSON(everyTasks[index])
                                            let model = FYHTaskCenterShowModel.setValueForFYHTaskCenterShowModel(json: json)
                                            self.dailyTastArr.add(model)
                                        }
                                        
                                        self.mainTableView.mj_header.endRefreshing()
                                        SVPHide()
                                        self.mainTableView.reloadData()
                                    }else{
                                        SVPwillShowAndHide("请求失败")
                                    }
                                }
                                break
                            case .failure(let error):
                                deBugPrint(item: error)
                                SVPHide()
                                SVPwillShowAndHide("请求失败")
                                self.mainTableView.mj_header.endRefreshing()
                            }
        }
    }
    
    
    //    ******************代理 ： UITableViewDataSource,UITableViewDelegate  ************
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 1 {
            return dailyTastArr.count
        }
        
        if section == 2 {
            return totalTastArr.count
        }
        if infoModel.age == nil {
            return 0
        }
        return 1
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell : FYHTaskCenterHeadCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! FYHTaskCenterHeadCell
            cell.setValuesForFYHTaskCenterHeadCell(model: infoModel)
            cell.selectionStyle = .none
            return cell
        }else{
            
            var model = FYHTaskCenterShowModel()
            var isDaily = Bool()
            if indexPath.section == 1 {
                isDaily = true
                model = dailyTastArr[indexPath.row] as! FYHTaskCenterShowModel
            }else{
                isDaily = false
                model = totalTastArr[indexPath.row] as! FYHTaskCenterShowModel
            }
            let cell : FYHTaskCenterShowCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable1, for: indexPath) as! FYHTaskCenterShowCell
            cell.setValuesForFYHTaskCenterShowCell(model: model, isDaily: isDaily)
            cell.selectionStyle = .none
            return cell
        }
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
    
}
