//
//  newSettingsViewController.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/17.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewSettingsViewController: Wx_baseViewController {
    
    lazy var tableView : UITableView = {
        let table = UITableView()
        table.backgroundColor = backGroundColor
        table.delegate = self
        table.dataSource = self
        table.tableFooterView = UIView.init()
        table.separatorStyle = .none
        
        table.register(NewSettingListTableViewCell.self, forCellReuseIdentifier: "NewSettingListTableViewCell")
        table.register(NewSettingListExitAccountTableViewCell.self, forCellReuseIdentifier: "NewSettingListExitAccountTableViewCell")
        
        return table
    }()
    
    var dateSource : [[NewSettingListModel]] = [[]]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createNaviController(title: "设置", leftBtn: buildLeftBtn(), rightBtn: nil)
        buildUI()
    }
    
    private func buildUI() {
        
        view.addSubview(tableView)
        _ = tableView.sd_layout()?
            .topSpaceToView(naviView,0)?
            .leftSpaceToView(view,0)?
            .rightSpaceToView(view,0)?
            .bottomSpaceToView(view,0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        buildData()
    }
    
    func buildData() {
        
        dateSource.removeAll()
        
        let model1_1 = NewSettingListModel()
        model1_1.title = "修改密码"
        let model1_2 = NewSettingListModel()
        model1_2.title = "支付密码"
        dateSource.append([model1_1,model1_2])
        
        let model2_1 = NewSettingListModel()
        model2_1.title = "意见反馈"
        let model2_2 = NewSettingListModel()
        model2_2.title = "相关协议"
        dateSource.append([model2_1,model2_2])
        
        let model3_1 = NewSettingListModel()
        model3_1.title = "关于我们"
        let model3_2 = NewSettingListModel()
        model3_2.title = "清除缓存"
        model3_2.detail = "\(fileSizeOfCache()) M"
        let model3_3 = NewSettingListModel()
        model3_3.title = "当前版本"
        let infoDic = Bundle.main.infoDictionary
        model3_3.detail = (infoDic!["CFBundleShortVersionString"] as! String?)!
        dateSource.append([model3_1,model3_2,model3_3])
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate
extension NewSettingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 3 && indexPath.section == 2 {
            return GET_SIZE * 450
        }
        return 49
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 2 && indexPath.row == 3 {
            
            var cell:NewSettingListExitAccountTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "NewSettingListExitAccountTableViewCell") as? NewSettingListExitAccountTableViewCell
            if nil == cell {
                cell! = NewSettingListExitAccountTableViewCell.init(style: .default, reuseIdentifier: "NewSettingListExitAccountTableViewCell")
            }
            cell?.selectionStyle = .none
            return cell!
        }else {
            
            var cell:NewSettingListTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "NewSettingListTableViewCell") as? NewSettingListTableViewCell
            if nil == cell {
                cell! = NewSettingListTableViewCell.init(style: .default, reuseIdentifier: "NewSettingListTableViewCell")
            }
            cell?.selectionStyle = .none
            cell?.model = dateSource[indexPath.section][indexPath.row]
            return cell!
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let foot = UIView()
        foot.backgroundColor = lineColor
        return foot
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 2 {
            return 0
        }
        return 10
    }
}

// MARK: - UITableViewDataSource
extension NewSettingsViewController: UITableViewDataSource {
    
    //MARK : -  代理方法
    func numberOfSections(in tableView: UITableView) -> Int {
        return dateSource.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {
            return dateSource[section].count + 1
        }
        return dateSource[section].count
    }
}