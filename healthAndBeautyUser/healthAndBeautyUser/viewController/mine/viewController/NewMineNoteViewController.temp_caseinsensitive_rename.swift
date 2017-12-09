//
//  newMineNoteViewController.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/16.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewMineNoteViewController: Wx_baseViewController,UITableViewDataSource,UITableViewDelegate {
    
    lazy var tableView : UITableView = {
        let table = UITableView()
        table.backgroundColor = backGroundColor
        table.delegate = self
        table.dataSource = self
        table.tableFooterView = UIView.init()
        table.separatorStyle = .none
        
        table.register(NewMineNoteListTableViewCell.self, forCellReuseIdentifier: "NewMineNoteListTableViewCell")
        
        return table
    }()
    
    lazy var selectTableView : UITableView = {
        let table = UITableView()
        table.backgroundColor = backGroundColor
        table.delegate = self
        table.dataSource = self
        table.tableFooterView = UIView.init()
        table.separatorStyle = .none
        
        table.register(NewMineNoteListTableViewCell.self, forCellReuseIdentifier: "NewMineNoteListTableViewCell")
        
        return table
    }()
    
    var dateSource : [NSString] = []
    var selectDateSource : [NSString] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        buildNavi()
        buildUI()
    }
    
    private func buildUI() {
        
        view.backgroundColor = backGroundColor
        
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
        return GET_SIZE * 535
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:NewMineNoteListTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "NewMineNoteListTableViewCell") as? NewMineNoteListTableViewCell
        if nil == cell {
            cell! = newMineNoteListTableViewCell.init(style: .default, reuseIdentifier: "NewMineNoteListTableViewCell")
        }
        cell?.selectionStyle = .none
        cell?.buildData()
        return cell!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        
        buildData()
    }
    
    private func buildData() {
        
        dateSource.removeAll()
        for _ in 0..<4 {
            dateSource.append("1111")
        }
        tableView.reloadData()
    }
    
    private func buildNavi() {
        
        self.navigationController?.navigationBar.barTintColor = naviColor
        self.navigationController?.navigationBar.isTranslucent = false
        
        let naviView = UIView()
        naviView.frame = CGRect.init(x: 0, y: 0, width: WIDTH/2, height: 36)
        self.navigationItem.titleView = naviView
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(selectType))
        naviView.addGestureRecognizer(tap)
        
        let timeLab = UILabel()
        timeLab.text = "2017/12/15"
        timeLab.textAlignment = .center
        timeLab.textColor = UIColor.white
        timeLab.font = UIFont.systemFont(ofSize: 16)
        timeLab.frame = CGRect.init(x: 0, y: 0, width: WIDTH/2-10, height: 18)
        naviView.addSubview(timeLab)
        
        let placeLab = UILabel()
        placeLab.text = "激光微整形"
        placeLab.textAlignment = .center
        placeLab.textColor = UIColor.white
        placeLab.font = UIFont.systemFont(ofSize: 16)
        placeLab.frame = CGRect.init(x: 0, y: 18, width: WIDTH/2-10, height: 18)
        naviView.addSubview(placeLab)
        
        let img = UIImageView()
        img.image = UIImage(named:"Open")
        img.frame = CGRect.init(x: WIDTH/2-10, y: (36-5)/2, width: 10, height: 5)
        naviView.addSubview(img)
        
        let leftBtn = UIButton()
        leftBtn.setImage(UIImage(named:"back"), for: .normal)
        leftBtn.addTarget(self, action: #selector(pop), for: .touchUpInside)
        leftBtn.frame = CGRect.init(x: 0, y: 0, width: 21, height: 20)
        let left = UIBarButtonItem.init(customView: leftBtn)
        self.navigationItem.leftBarButtonItem = left
    }
    
    @objc private func selectType() {
        
        if selectDateSource.count == 0 {
            
            view.addSubview(selectTableView)
            _ = selectTableView.sd_layout()?
                .topSpaceToView(view,0)?
                .leftSpaceToView(view,0)?
                .rightSpaceToView(view,0)?
                .bottomSpaceToView(view,0)
            
            for _ in 0 ..< 5 {
                
                selectDateSource.append("nil")
            }
        }
    }
}

