//
//  NewDoctorMainPageViewController.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/9/27.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON

class doctorPage: NSObject {
    
    var isFollow = Bool()
    
    var doctorName = String()
    var headImage = String()
    var id = String()
    var projectNames = String()
    var bespoke = Int()
    var doctorPrensent = String()
    var cases = Int()
    var currentPosition = String()
    var sex = String()
    
    var images = [String]()
}

class NewDoctorMainPageViewController: Wx_baseViewController {
    
    var doctorID = String()
    
    lazy var tableView : UITableView = {
        let table = UITableView()
        table.backgroundColor = backGroundColor
        table.delegate = self
        table.dataSource = self
        table.tableFooterView = UIView.init()
        table.separatorStyle = .none
        
        table.register(UINib.init(nibName: "NewNote_ThreePictrueTabCell",
                                  bundle: nil),
                       forCellReuseIdentifier: "NewNote_ThreePictrueTabCelldoctorPage")
        table.register(UINib.init(nibName: "NewDoctorDetailTableViewCell",
                                  bundle: nil),
                       forCellReuseIdentifier: "NewDoctorDetailTableViewCell")
        
        table.register(UINib.init(nibName: "NewDoctorMessageTabCell",
                                  bundle: nil),
                       forCellReuseIdentifier: "NewDoctorMessageTabCell")
        
        table.register(UINib.init(nibName: "NewDoctorSelectTabCell",
                                  bundle: nil),
                       forCellReuseIdentifier: "NewDoctorSelectTabCell")
        return table
    }()
    
    var dateSource = doctorPage()
    var isLoad = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createNaviController(title: "医生主页",
                             leftBtn: buildLeftBtn(),
                             rightBtn: buildRightBtnWithIMG(UIImage(named:"share_icon_default")!))
        
        buildUI()
        buildData()
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
    
    private func buildData() {
        
        var up = ["id":doctorID]
            as [String: Any]

        if Defaults.hasKey("SESSIONID") {
            up["mobileCode"] = Defaults["mobileCode"].stringValue
            up["SESSIONID"] = Defaults["SESSIONID"].stringValue
        }
        
        SVPWillShow("载入中...")
        delog(up)

        Net.share.getRequest(urlString: CBBDoctorInfoJoggle, params: up, success: { (datas) in
            let json = JSON(datas)
            delog(json)
            SVPHide()
            if json["code"].int == 1 {
                
                let data = json["data"]
                let doctorInfo = data["doctorInfo"]
                
                self.dateSource.isFollow = data["isFollow"].bool!
                self.dateSource.doctorName = doctorInfo["doctorName"].string!
                self.dateSource.headImage = doctorInfo["headImage"].string!
                self.dateSource.id = doctorInfo["id"].string!
                self.dateSource.projectNames = doctorInfo["projectNames"].string!
                self.dateSource.bespoke = doctorInfo["bespoke"].int!
                self.dateSource.doctorPrensent = doctorInfo["doctorPrensent"].string!
                self.dateSource.cases = doctorInfo["cases"].int!
                self.dateSource.currentPosition = doctorInfo["currentPosition"].string!
                self.dateSource.sex = doctorInfo["sex"].string!
                if doctorInfo["images"].arrayObject != nil {
                    self.dateSource.images = doctorInfo["images"].arrayObject! as! [String]
                }
                self.isLoad = true
                self.tableView.reloadData()
            }else {
                SVPwillShowAndHide(json["message"].string!)
            }
        }) { (error) in
            delog(error)
            SVPwillShowAndHide("请检查您的网路")
        }
    }
}

// MARK: - UITableViewDelegate
extension NewDoctorMainPageViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return GET_SIZE * 544
        }else if indexPath.section == 1 {
            return 184
        }else {
            return GET_SIZE * 285
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell : NewDoctorMessageTabCell = tableView.dequeueReusableCell(withIdentifier: "NewDoctorMessageTabCell", for: indexPath) as! NewDoctorMessageTabCell
            cell.selectionStyle = .none
            cell.model = dateSource
            return cell
        }
        
        if indexPath.section == 1 {
            let cell : NewDoctorDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "NewDoctorDetailTableViewCell", for: indexPath) as! NewDoctorDetailTableViewCell
            cell.selectionStyle = .none
            cell.model = dateSource
            return cell
        }
        
        let cell : NewNote_ThreePictrueTabCell = tableView.dequeueReusableCell(withIdentifier: "NewNote_ThreePictrueTabCelldoctorPage", for: indexPath) as! NewNote_ThreePictrueTabCell
        cell.selectionStyle = .none
        cell.model = dateSource.images
        cell.detail.text = "医生相册"
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        footer.backgroundColor = lineColor
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 10
        }
        return 0
    }
}

// MARK: - UITableViewDataSource
extension NewDoctorMainPageViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if !isLoad {
            return 0
        }
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
}

