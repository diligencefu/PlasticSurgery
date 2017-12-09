//
//  newSettingsViewController.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/17.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewSettingsViewController: Wx_baseViewController,UITableViewDataSource,UITableViewDelegate {
    
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
    
    var dateSource : [NewSettingListModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildNaviAndOnlyBack("设置")
        buildUI()
    }
    
    private func buildUI() {
        
        view.addSubview(tableView)
        _ = tableView.sd_layout()?
            .topSpaceToView(view,0)?
            .leftSpaceToView(view,0)?
            .rightSpaceToView(view,0)?
            .bottomSpaceToView(view,0)
    }

    //MARK : -  代理方法
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dateSource.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == dateSource.count - 1 {
            return GET_SIZE * 450
        }
        return GET_SIZE * 98
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == dateSource.count - 1 {
            
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
            cell?.model = dateSource[indexPath.row]
            return cell!
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        
        buildData()
    }
    
    private func buildData() {
        
        dateSource.removeAll()
        let arr = ["修改密码","意见反馈","投诉","相关协议","关于新医美","清除缓存","当前版本","退出当前账号"]
        for index in arr {
            let model = NewSettingListModel()
            model.title = index
            if index == "清除缓存" {
                model.detail = "\(fileSizeOfCache()) M"
            }
            if index == "当前版本" {
                let infoDic = Bundle.main.infoDictionary
                model.detail = (infoDic!["CFBundleShortVersionString"] as! String?)!
            }
            dateSource.append(model)
        }
        tableView.reloadData()
    }
}
