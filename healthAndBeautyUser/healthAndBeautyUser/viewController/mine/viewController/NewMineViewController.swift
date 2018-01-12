
//
//  newMineViewController.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/11.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON
import MJRefresh

class NewMineViewController: Wx_baseViewController {
    
    lazy var tableView : UITableView = {
        let table = UITableView()
        table.backgroundColor = backGroundColor
        table.delegate = self
        table.dataSource = self
        table.tableFooterView = UIView.init()
        table.separatorStyle = .none
        
        table.register(NewMineList_MeTableViewCell.self,
                       forCellReuseIdentifier: "NewMineList_MeTableViewCell")
        table.register(NewMineList_MessageOrOrderTableViewCell.self,
                       forCellReuseIdentifier: "NewMineList_MessageOrOrderTableViewCell")
        table.register(NewMineList_otherTableViewCell.self,
                       forCellReuseIdentifier: "NewMineList_otherTableViewCell")
        table.register(NewSettingListTableViewCell.self,
                       forCellReuseIdentifier: "NewSettingListTableViewCell")
        table.register(UINib.init(nibName: "FYHShowIntegralGoodsListCell", bundle: nil),
                       forCellReuseIdentifier: "FYHShowIntegralGoodsListCell")
        return table
    }()
    
    
    var dataSource = [NSMutableArray]()
    var meModel = NewMainModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildUI()
        buildData()
        
        
        //  接收登录成功的通知
        NotificationCenter.default.addObserver(self, selector: #selector(receiveNitification(nitofication:)), name: NSNotification.Name(rawValue: SuccessRefreshNotificationCenter_Login), object: nil)

        //  接收退出登录的通知
        NotificationCenter.default.addObserver(self, selector: #selector(receiveNitification(nitofication:)), name: NSNotification.Name(rawValue: SuccessRefreshNotificationCenter_LoginOut), object: nil)
    }
    
    @objc func receiveNitification(nitofication:Notification) {
        self.tableView.mj_header.beginRefreshing()
    }

    private func buildUI() {
        
        view.backgroundColor = backGroundColor
        
        view.addSubview(tableView)
        _ = tableView.sd_layout()?
            .topSpaceToView(view,0)?
            .leftSpaceToView(view,0)?
            .rightSpaceToView(view,0)?
            .bottomSpaceToView(view,(HEIGHT == 812 ? (49 + 34) : 49))
        weak var weakSelf = self
        tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            
            weakSelf?.buildData()
        })
    }
    
    
    //停止刷新
    func endRefresh() {
        tableView.mj_header.endRefreshing()
    }
    
    
    private func buildNoUserData() {
        
        meModel = NewMainModel()
        meModel.nickName = "未登录"
        meModel.gender = "1"
        
        dataSource.removeAll()
        
        let model1 = String()
        dataSource.append([model1])
        
        let model2 = String()
        let model3 = String()
        dataSource.append([model2])
        dataSource.append([model3])
        
        let modelJF = String()
        dataSource.append([modelJF])

        let model4 = String()
        let model5 = String()
        dataSource.append([model4,model5])
        
        let model5_1 = NewSettingListModel()
        model5_1.title = "收藏"
        let model6 = NewSettingListModel()
        model6.title = "优惠券"
        let model7 = NewSettingListModel()
        model7.title = "特权产品"
        let model8 = NewSettingListModel()
        model8.title = "消费记录"
        let model9 = NewSettingListModel()
        model9.title = "客服电话"
        dataSource.append([model5_1,model6,model7,model8,model9])
        
        tableView.reloadData()
        endRefresh()
    }
    
    
    private func buildData() {
        
        var up : [String: Any] = [:]
        
        if Defaults.hasKey("SESSIONID") {
            up["mobileCode"] = Defaults["mobileCode"].stringValue
            up["SESSIONID"] = Defaults["SESSIONID"].stringValue
        }else {
            buildNoUserData()
            endRefresh()
            return
        }
        
        SVPWillShow("载入中...")
        delog(up)
        
        Net.share.getRequest(urlString: getInfoJoggle, params: up, success: { (datas) in
            let json = JSON(datas)
            delog(json)
            SVPHide()
            if json["code"].int == 1 {
                let data = json["data"]
                let personalInfo = data["personalInfo"]
                self.meModel.nickName = personalInfo["nickName"].string!
                self.meModel.photo = personalInfo["photo"].string!
                self.meModel.gender = personalInfo["gender"].string!
                self.meModel.age = "\(personalInfo["age"].int!)"
                self.meModel.follow = "\(personalInfo["follow"].int!)"
                self.meModel.fans = "\(personalInfo["fans"].int!)"
                self.meModel.article = "\(personalInfo["article"].int!)"
                self.meModel.id = personalInfo["id"].string!
                self.dataSource.removeAll()
                
                let model1 = String()
                self.dataSource.append([model1])
                
                let model2 = String()
                let model3 = String()
                self.dataSource.append([model2])
                self.dataSource.append([model3])
                
                let modelJF = String()
                self.dataSource.append([modelJF])

                let model4 = String()
                let model5 = String()
                self.dataSource.append([model4,model5])
                
                let model5_1 = NewSettingListModel()
                model5_1.title = "收藏"
                let model6 = NewSettingListModel()
                model6.title = "优惠券"
                let model7 = NewSettingListModel()
                model7.title = "特权产品"
                let model8 = NewSettingListModel()
                model8.title = "消费记录"
                let model9 = NewSettingListModel()
                model9.title = "客服电话"
                self.dataSource.append([model5_1,model6,model7,model8,model9])
                self.tableView.reloadData()
                self.endRefresh()
            }else {
                SVPwillShowAndHide(json["message"].string!)
                self.buildNoUserData()
            }
        }) { (error) in
            delog(error)
            SVPwillShowAndHide("请检查您的网路")
        }
    }
}

// MARK: - UITableViewDelegate
extension NewMineViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return GET_SIZE * 400 + (HEIGHT == 812 ? 44 : 20)
        case 1,2,3:
            return GET_SIZE * 220
        case 4:
            return GET_SIZE * 125
        case 5:
            return GET_SIZE * 88
        default:
            break
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            var cell:NewMineList_MeTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "NewMineList_MeTableViewCell") as? NewMineList_MeTableViewCell
            if nil == cell {
                cell! = NewMineList_MeTableViewCell.init(style: .default, reuseIdentifier: "NewMineList_MeTableViewCell")
            }
            cell?.selectionStyle = .none
            cell?.buildData()
            cell?.model = meModel
            return cell!
        case 1:
            var cell:NewMineList_MessageOrOrderTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "NewMineList_MessageOrOrderTableViewCell") as? NewMineList_MessageOrOrderTableViewCell
            if nil == cell {
                cell! = NewMineList_MessageOrOrderTableViewCell.init(style: .default, reuseIdentifier: "NewMineList_MessageOrOrderTableViewCell")
            }
            cell?.selectionStyle = .none
            cell?.isMessage = false
            cell?.buildData()
            return cell!
        case 2,3:
            
            let cell : FYHShowIntegralGoodsListCell = tableView.dequeueReusableCell(withIdentifier: "FYHShowIntegralGoodsListCell", for: indexPath) as! FYHShowIntegralGoodsListCell
            
            if indexPath.section == 2 {
                cell.layoutForMainList(isMessage: true)
            }else{
                cell.layoutForMainList(isMessage: false)
            }
            cell.selectionStyle = .none
            return cell
        case 4:
            var cell:NewMineList_otherTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "NewMineList_otherTableViewCell") as? NewMineList_otherTableViewCell
            if nil == cell {
                cell! = NewMineList_otherTableViewCell.init(style: .default, reuseIdentifier: "NewMineList_otherTableViewCell")
            }
            
            cell?.chooseAction = {
                
                if !Defaults.hasKey("SESSIONID") {
                    SVPwillShowAndHide("请先登录")
                    return
                }
                switch $0 {
                case "400":
                    let tmp = FYHIntegralStoreViewController1()
                    self.navigationController?.pushViewController(tmp, animated: true)

                    break
                case "401":
                    
                    let tmp = FYHMissionCenterViewController()
                    self.navigationController?.pushViewController(tmp, animated: true)
                    break
                case "402":
                    self.navigationController?.pushViewController(FYHDistributorViewController(), animated: true)
                    break
                case "403":
                    self.navigationController?.pushViewController(MemberViewController(), animated: true)
                    break
                default:
                    break
                }
            }
            cell?.selectionStyle = .none
            cell?.model = "\(indexPath.row)"
            return cell!
        case 5:
            var cell:NewSettingListTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "NewSettingListTableViewCell") as? NewSettingListTableViewCell
            if nil == cell {
                cell! = NewSettingListTableViewCell.init(style: .default, reuseIdentifier: "NewSettingListTableViewCell")
            }
            cell?.selectionStyle = .none
            cell?.model = dataSource[indexPath.section][indexPath.row] as? NewSettingListModel
            return cell!
        default:
            break
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView.init()
        view.backgroundColor = getColorWithNotAlphe(0xEEEEEE)
        return view
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == dataSource.count - 1 || section == 0 || section == dataSource.count - 2 {
            return 0
        }
        return 10
    }
}

// MARK: - UITableViewDataSource
extension NewMineViewController: UITableViewDataSource {
    
    //MARK : -  代理方法
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].count
    }
}
