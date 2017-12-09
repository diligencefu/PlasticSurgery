//
//  NewMineJobViewController.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/29.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewMineJobViewController: Wx_baseViewController {
    
    lazy var tableView : UITableView = {
        let table = UITableView()
        table.backgroundColor = backGroundColor
        table.delegate = self
        table.dataSource = self
        table.tableFooterView = UIView.init()
        table.separatorStyle = .none
        
        table.register(NewMineJob_topTableViewCell.self, forCellReuseIdentifier: "NewMineJob_topTableViewCell")

        table.register(NewMineJob_listTableViewCell.self, forCellReuseIdentifier: "NewMineJob_listTableViewCell")
        
        return table
    }()
    
    var dateSource : [NSString] = []
    
    let segmentController : UISegmentedControl = {
        
        let titleArray = ["未完成","已完成"]
        let segmentController = UISegmentedControl.init(items: titleArray)
        segmentController.frame = CGRect(x:0,y:0,width:118,height:28)
        segmentController.tintColor = UIColor.lightGray
        segmentController.addTarget(self, action: #selector(segmentDidChangeValue(controller:)), for: .valueChanged)
        segmentController.selectedSegmentIndex = 0
        return segmentController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createNaviController(title: "任务中心", leftBtn: buildLeftBtn(), rightBtn: nil)
        buildUI()
    }
    
    private func buildUI() {
        
        view.backgroundColor = backGroundColor
        
        view.addSubview(tableView)
        _ = tableView.sd_layout()?
            .topSpaceToView(naviView,0)?
            .leftSpaceToView(view,0)?
            .rightSpaceToView(view,0)?
            .bottomSpaceToView(view,0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    private func buildData() {
        
    }
    
    func segmentDidChangeValue(controller:UISegmentedControl) {
        
        if controller.selectedSegmentIndex == 0 {
            
        }else {
            
        }
    }
}

// MARK: - UITableViewDelegate
extension NewMineJobViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return GET_SIZE * 230
        }
        return GET_SIZE * 200
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            var cell:NewMineJob_topTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "NewMineJob_topTableViewCell") as? NewMineJob_topTableViewCell
            if nil == cell {
                cell! = NewMineJob_topTableViewCell.init(style: .default, reuseIdentifier: "NewMineJob_topTableViewCell")
            }
            cell?.selectionStyle = .none
            cell?.model = "测试"
            return cell!
        }
        var cell:NewMineJob_listTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "NewMineJob_listTableViewCell") as? NewMineJob_listTableViewCell
        if nil == cell {
            cell! = NewMineJob_listTableViewCell.init(style: .default, reuseIdentifier: "NewMineJob_listTableViewCell")
        }
        cell?.selectionStyle = .none
        cell?.model = "测试"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return UIView()
        }else if section == 1 {
            
            let tmp = UIView()
            tmp.backgroundColor = backGroundColor
            
            tmp.addSubview(segmentController)
            _ = segmentController.sd_layout()?
                .topSpaceToView(tmp,GET_SIZE * 12)?
                .centerXEqualToView(tmp)?
                .widthIs(118)?
                .heightIs(28)
            
            let title = UILabel()
            title.text = "新手任务"
            title.textColor = darkText
            title.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
            title.textAlignment = .left
            tmp.addSubview(title)
            _ = title.sd_layout()?
                .bottomSpaceToView(tmp,0)?
                .leftSpaceToView(tmp,0)?
                .widthIs(GET_SIZE * 120)?
                .heightIs(GET_SIZE * 30)
            
            return tmp
        }else {
            
            let tmp = UIView()
            tmp.backgroundColor = backGroundColor
            
            let title = UILabel()
            if section == 2 {
                title.text = "累计任务"
            }else {
                title.text = "晋升任务"
            }
            title.textColor = darkText
            title.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
            title.textAlignment = .left
            tmp.addSubview(title)
            _ = title.sd_layout()?
                .bottomSpaceToView(tmp,0)?
                .leftSpaceToView(tmp,0)?
                .widthIs(GET_SIZE * 120)?
                .topSpaceToView(tmp,0)
            
            return tmp
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }else if section == 1 {
            
            return GET_SIZE * 170
        }else {
            
            return GET_SIZE * 50
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view = UIView.init()
        view.backgroundColor = getColorWithNotAlphe(0xEEEEEE)
        return view
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 10
    }
}

// MARK: - UITableViewDataSource
extension NewMineJobViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return 3
    }
}
