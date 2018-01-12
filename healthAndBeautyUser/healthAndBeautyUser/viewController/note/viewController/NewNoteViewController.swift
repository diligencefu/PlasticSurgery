//
//  newNoteViewController.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/11.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON
import DZNEmptyDataSet
import MJRefresh

class NewNoteViewController: Wx_baseViewController {

    lazy var tableView : UITableView = {
        
        let table = UITableView()
        table.backgroundColor = backGroundColor
        table.delegate = self
        table.dataSource = self
        table.tableFooterView = UIView()
        table.separatorStyle = .none
        table.emptyDataSetSource = self
        table.emptyDataSetDelegate = self
        
        table.register(NewNoteListTableViewCell.self,
                       forCellReuseIdentifier: "NewNoteListTableViewCell")
        
        let back = UIView.init(frame: CGRect.init(x: 0,
                                                  y: 0,
                                                  width: WIDTH,
                                                  height: HEIGHT-64-49))
        let imageView = UIImageView.init(image: UIImage(named:"full_icon_default"))
        _ = imageView.sd_layout()?
            .centerXEqualToView(back)?
            .centerYEqualToView(back)?
            .widthIs(GET_SIZE * 500)?
            .heightIs(GET_SIZE * 312)
        back.addSubview(imageView)
        table.backgroundView = back
        table.backgroundView?.clipsToBounds = true
        table.backgroundView?.isHidden = true
        return table
    }()
    
    var dataSource : [NewNoteListModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createNaviController(title: "日记本",
                             leftBtn: nil,
                             rightBtn: buildRightBtnWithIMG(UIImage(named:"Establish_icon_default")!))
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

    override func rightClick() {
        
        if Defaults.hasKey("SESSIONID") {
            let nib = NewNoteCreateBooksViewController.init(nibName: "NewNoteCreateBooksViewController",
                                                            bundle: nil)
            navigationController?.pushViewController(nib, animated: true)
        }else {
            SVPwillShowAndHide("请登录")
            let login = NewLoginLocationViewController.init(nibName: "NewLoginLocationViewController", bundle: nil)
            let loginVC = Wx_baseNaviViewController.init(rootViewController: login)
            self.present(loginVC, animated: true, completion: nil)
            return
        }
    }
    
    private func buildUI() {
        
        view.addSubview(tableView)
        _ = tableView.sd_layout()?
            .topSpaceToView(naviView,0)?
            .leftSpaceToView(view,0)?
            .rightSpaceToView(view,0)?
            .bottomSpaceToView(view,49)
        
        weak var weakSelf = self
        tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            weakSelf!.buildData()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    private func buildData() {
        
        var up : [String: Any] = [:]
        
        if Defaults.hasKey("SESSIONID") {
            up["mobileCode"] = Defaults["mobileCode"].stringValue
            up["SESSIONID"] = Defaults["SESSIONID"].stringValue
        }else {
            SVPwillShowAndHide("请登录")
            let login = NewLoginLocationViewController.init(nibName: "NewLoginLocationViewController", bundle: nil)
            let loginVC = Wx_baseNaviViewController.init(rootViewController: login)
            self.present(loginVC, animated: true, completion: nil)
            return
        }
        
        delog(up)
        SVPWillShow("载入中...")
        
        Net.share.getRequest(urlString: CBBDiaryListJoggle, params: up, success: { (datas) in
            let json = JSON(datas)
            delog(json)
            SVPHide()
            if json["code"].int == 1 {
                
                self.dataSource.removeAll()
                let data = json["data"]
                for (_, subJson):(String, JSON) in data["diarys"] {
                    
                    let model = NewNoteListModel()
                    model.id = subJson["id"].string!
                    model.title = subJson["title"].string!
                    model.count = subJson["count"].int!
                    model.isAllowWrite = subJson["isAllowWrite"].bool!
                    self.dataSource.append(model)
                }
                self.endRefresh()
                self.tableView.reloadData()
            }else {
                SVPwillShowAndHide(json["message"].string!)
            }
        }) { (error) in
            delog(error)
        }
    }
    
    private func endRefresh() {
        tableView.mj_header.endRefreshing()
    }
}

// MARK: - UITableViewDelegate
extension NewNoteViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if dataSource[indexPath.row].isAllowWrite {
            
            let tmp = NewNoteCreateViewController.init(nibName: "NewNoteCreateViewController", bundle: nil)
            tmp.noteId = dataSource[indexPath.row].id
            navigationController?.pushViewController(tmp, animated: true)
        }else {
            SVPwillShowAndHide("这个日记本当前无法写日记")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return GET_SIZE * 132
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:NewNoteListTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "NewNoteListTableViewCell") as? NewNoteListTableViewCell
        if nil == cell {
            cell! = NewNoteListTableViewCell.init(style: .default, reuseIdentifier: "NewNoteListTableViewCell")
        }
        cell?.selectionStyle = .none
        cell?.model = dataSource[indexPath.row]
        return cell!
    }
}

// MARK: - UITableViewDataSource
extension NewNoteViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
}

// MARK: -
extension NewNoteViewController: DZNEmptyDataSetSource,DZNEmptyDataSetDelegate {
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        
        return UIImage(named:"no-data_icon")
    }
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        
        let titles = "没有数据"
        let attributs = [NSFontAttributeName:UIFont.systemFont(ofSize: 16),
                         NSForegroundColorAttributeName:darkText]
        return NSAttributedString.init(string: titles, attributes: attributs)
    }
    
}
