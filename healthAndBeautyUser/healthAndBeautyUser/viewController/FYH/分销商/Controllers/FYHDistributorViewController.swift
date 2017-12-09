//
//  FYHDistributorViewController.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/5.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FYHDistributorViewController: Wx_baseViewController,UITableViewDelegate,UITableViewDataSource {

    var mainTableView = UITableView()
    var headView = DistributorHeadView()
    
    let identyfierTable  = "identyfierTable"
    let identyfierTable1 = "identyfierTable1"
    let identyfierTable2 = "identyfierTable2"

    let images = ["total-amount","already-consumed","already-consumed","nv_icon_default","cash"]
    let title1 = ["总金额","个人消耗","团队消耗","未消耗","可提现"]
    let title2 = ["会员中心","邀请好友","我的推荐","星级奖励"]
    let title3 = ["分销明细","会费返现"]

    var distriModel = DistributorModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configSubViews()
        requestData()
    }
    
    
    func requestData() {
        
        let params = [
            "mobileCode" : Defaults["mobileCode"].stringValue,
            "SESSIONID" : Defaults["SESSIONID"].stringValue
            ]
        SVPWillShow("加载中...")
        Alamofire.request(user_Info,
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
                                        
                                        self.distriModel  = DistributorModel.setValueForDistributorModel(json: data)
                                        self.headView.setValuesWithModel(model:self.distriModel)
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
        
        createNaviController(title: "", leftBtn: buildLeftBtn(), rightBtn: nil)

        mainTableView = UITableView.init(frame: CGRect(x: 0, y: 64, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT - 64 ), style: .plain)
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.estimatedRowHeight = 143 * kSCREEN_SCALE;
        mainTableView.register(UINib(nibName: "DistributorCell1", bundle: nil), forCellReuseIdentifier: identyfierTable)
        mainTableView.register(UINib(nibName: "DistributorCell2", bundle: nil), forCellReuseIdentifier: identyfierTable1)
        mainTableView.register(UINib(nibName: "DistributorCell3", bundle: nil), forCellReuseIdentifier: identyfierTable2)
        mainTableView.tableFooterView = UIView()
        self.view.addSubview(mainTableView)
        mainTableView.backgroundColor = kSetRGBColor(r: 239, g: 239, b: 244)
//        mainTableView.bounces = false
//        headView
        headView = UINib(nibName:"DistributorHeadView",bundle:nil).instantiate(withOwner: self, options: nil).first as! DistributorHeadView
        headView.frame =  CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 162)
        mainTableView.tableHeaderView = headView
    }
    
    
    //MARK:  ******代理 ：UITableViewDataSource,UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return title1.count+1
        }
        
        if section == 1 {
            return title2.count
        }

        return title3.count
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if distriModel.balance != nil {
            return 3
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            if indexPath.row == 5 {
                
                let cell : DistributorCell2 = tableView.dequeueReusableCell(withIdentifier: identyfierTable1, for: indexPath) as! DistributorCell2
                var flag = false
                if distriModel.isCash == "1" {
                    flag = true
                }
                cell.setValueWithwithdrawBtn(canWithdraw: flag)
                return cell
            }
            
            let cell : DistributorCell1 = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! DistributorCell1
            
            var flag = false
            if indexPath.row == 0{
                flag = true
            }
            
            var money = ""
            
            if indexPath.row == 0 {
                money = distriModel.balance
            }
            
            if indexPath.row == 1 {
                money = distriModel.personalConsumption
            }
            
            if indexPath.row == 2 {
                money = distriModel.teamConsumption
            }
            
            if indexPath.row == 3 {
                money = distriModel.surplus
            }
            if indexPath.row == 4 {
                money = distriModel.cashBalance
            }

            cell.DistributorCell1SetValues(image: images[indexPath.row], title1: title1[indexPath.row], count: money, flag: flag)
            return cell
        }else{
            
            let cell : DistributorCell3 = tableView.dequeueReusableCell(withIdentifier: identyfierTable2, for: indexPath) as! DistributorCell3
            
            if indexPath.section == 1 {
                cell.setTitle(title: title2[indexPath.row])
            }else{
                cell.setTitle(title: title3[indexPath.row])
            }
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            
        }
        if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                self.navigationController?.pushViewController(MemberViewController(), animated: true)
                break
            case 1:
                self.navigationController?.pushViewController(MemberViewController(), animated: true)
                break
            case 2:
                self.navigationController?.pushViewController(FYHRecommendViewController(), animated: true)
                break
            case 3:
                self.navigationController?.pushViewController(FYHRewardViewController(), animated: true)
                break
            default:
                break
            }
        }
        if indexPath.section == 2 {
            if indexPath.row == 0 {
                self.navigationController?.pushViewController(FYHDistributionViewController(), animated: true)
            }

            if indexPath.row == 1 {
                self.navigationController?.pushViewController(FYHRCViewController(), animated: true)
            }
        }

        
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



}
