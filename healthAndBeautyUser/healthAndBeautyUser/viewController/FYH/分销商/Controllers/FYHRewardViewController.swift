//
//  FYHRewardViewController.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/9.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FYHRewardViewController: Base2ViewController {
    
    let teamArr = NSMutableArray()
    let personalArr = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configSubViews() {
        setupTitleViewSectionStyle(titleStr: "星级奖励")
        
        mainTableView = UITableView.init(frame: CGRect(x: 0,
                                                       y: CGFloat(navHeight),
                                                       width: kSCREEN_WIDTH,
                                                       height: kSCREEN_HEIGHT - 64 ),
                                         style: .grouped)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.estimatedRowHeight = 80
        mainTableView.register(UINib(nibName: "FYHRewardCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
        self.view.addSubview(mainTableView)
        
    }
    
    override func requestData() {
        
        let params = [
            "mobileCode" : Defaults["mobileCode"].stringValue,
            "SESSIONID" : Defaults["SESSIONID"].stringValue,
        ]
        SVPWillShow("加载中...")
        Alamofire.request(vip_Stars,
                          method: .get, parameters: params,
                          encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                            deBugPrint(item: response.result)
                            switch response.result {
                            case .success:
                                if let j = response.result.value {
                                    //SwiftyJSON解析数据
                                    let JSOnDictory = JSON(j)
                                    let data1 =  JSOnDictory["data"]["teamVipStars"].arrayValue
                                    let data2 =  JSOnDictory["data"]["personalVipStars"].arrayValue
                                    let code =  JSOnDictory["code"].stringValue
                                    if code == "0" {
                                        setToast(str: "请求失败")
                                    }else{
//                                        团队
                                        for index in 0..<data1.count {
                                            let model = FYHRewardModel.setValueForFYHRewardModel(json: data1[index])
                                            self.teamArr.add(model)
                                        }
//                                        个人
                                        for index in 0..<data2.count {
                                            let model = FYHRewardModel.setValueForFYHRewardModel(json: data2[index])
                                            self.personalArr.add(model)
                                        }
                                        SVPHide()
                                        self.mainTableView.reloadData()
                                    }
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
            return teamArr.count
        }
        return personalArr.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var model = FYHRewardModel()
        if indexPath.section == 0 {
            model = teamArr[indexPath.row] as! FYHRewardModel
        }else{
            model = personalArr[indexPath.row] as! FYHRewardModel
        }
        let cell : FYHRewardCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! FYHRewardCell
        cell.FYHRewardCellSetValues(model: model, title1: String(indexPath.row+1))
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 19 * kSCREEN_SCALE+20))
        view.backgroundColor = UIColor.blue
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 44+10))
        view.backgroundColor = kSetRGBColor(r: 239, g: 239, b: 244)
        
        let label = UILabel.init(frame: CGRect(x: 0, y: 19 * kSCREEN_SCALE, width: kSCREEN_WIDTH, height: 44))
        label.backgroundColor = kSetRGBColor(r: 255, g: 255, b: 255)
        label.textColor = kGaryColor(num: 69)
        label.font = kFont40
        if section == 0 {
            label.text = "  团队星级奖励说明"
        }else{
            label.text = "  个人星级奖励说明"
        }
        view.addSubview(label)
        
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if section == 0 {
//            return 30
//        }
        
        return 44+10
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

}
