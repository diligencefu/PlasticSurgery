//
//  NewMain_freeViewController.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/21.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewMain_freeViewController: Wx_baseViewController {
    
    lazy var tableView : UITableView = {
        let table = UITableView()
        table.backgroundColor = backGroundColor
        table.delegate = self
        table.dataSource = self
        table.tableFooterView = UIView.init()
        table.separatorStyle = .none
        
        table.register(NewMain_freeTableViewCell.self, forCellReuseIdentifier: "NewMain_freeTableViewCell")
        table.register(NewMainBannerCell.self, forCellReuseIdentifier: "NewMainBannerCell")
        
        return table
    }()
    
    var dateSource : [NSString] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createNaviController(title: "免费整形", leftBtn: buildLeftBtn(), rightBtn: nil)
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
        buildData()
    }
    
    private func buildData() {
        for _ in 0..<10 {
            dateSource.append("null")
        }
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate
extension NewMain_freeViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return GET_SIZE * 400
        }
        return GET_SIZE * 280
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            var cell:NewMainBannerCell? = tableView.dequeueReusableCell(withIdentifier: "NewMainBannerCell") as? NewMainBannerCell
            if nil == cell {
                cell! = NewMainBannerCell.init(style: .default, reuseIdentifier: "NewMainBannerCell")
            }
            cell?.selectionStyle = .none
            cell?.buildData()
            return cell!
        case 1:
            var cell:NewMain_freeTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "NewMain_freeTableViewCell") as? NewMain_freeTableViewCell
            if nil == cell {
                cell! = NewMain_freeTableViewCell.init(style: .default, reuseIdentifier: "NewMain_freeTableViewCell")
            }
            cell?.selectionStyle = .none
            cell?.buildModel()
            return cell!
        default :
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let header = Wx_scrollerBtnView()
            header.frame = CGRect.init(x: 0, y: 0, width: WIDTH, height: 44)
            header.isShowBottomView = false
            header.scrollerViewColor = getColorWithNotAlphe(0xF1931A)
            header.btnColor = UIColor.black
            header.callBackBlock { (type) in
                delog(type)
            }
            header.btnArray = ["全部项目","智能排序","筛选"]
            header.buildUI()
            return header
        }
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 44
        }
        return 0
    }
}

// MARK: - UITableViewDataSource
extension NewMain_freeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return dateSource.count
    }
}
