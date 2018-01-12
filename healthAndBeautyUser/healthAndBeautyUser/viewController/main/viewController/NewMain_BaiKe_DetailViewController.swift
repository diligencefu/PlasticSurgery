//
//  NewMain_BaiKe_DetailViewController.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/9/22.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewMain_BaiKe_DetailViewController: Wx_baseViewController {
    
    var id = String()
    var name = String()
    private var page = 1
    
    lazy var tableView : UITableView = {
        let table = UITableView()
        table.backgroundColor = backGroundColor
        table.delegate = self
        table.dataSource = self
        table.tableFooterView = UIView.init()
        table.separatorStyle = .none
        
        table.register(UINib.init(nibName: "NewMain_BaiKeTabCell", bundle: nil),
                       forCellReuseIdentifier: "NewMain_BaiKeTabCell")
        table.register(NewMainCaseListTableViewCell.self,
                       forCellReuseIdentifier: "NewMainCaseListTableViewCell")
        table.register(NewMineNoteListTableViewCell.self,
                       forCellReuseIdentifier: "NewMineNoteListTableViewCell")
        
        return table
    }()
    
    var projectSource : [NewMain_ProjectListModel] = []
    var noteSource : [NewMain_NoteListModel] = []
    let baiKeDetail = NewMain_BaiKe_detailModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createNaviController(title: name, leftBtn: buildLeftBtn(), rightBtn: nil)
        
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
        
        var up = ["id": id,
                  "mobileCode":Defaults["mobileCode"].string!,
                  "page":page]
            as [String : Any]
        
        if Defaults.hasKey("SESSIONID") {
            up["SESSIONID"] = Defaults["SESSIONID"].string!
        }
        
        SVPWillShow("载入中...")
        delog(up)
        
        Net.share.getRequest(urlString: getprojectJoggle, params: up, success: { (datas) in
            let json = JSON(datas)
            delog(json)
            SVPHide()
            if json["code"].int == 1 {
                
                let data = json["data"]
                //百科详情相关
                let projectDetails = data["projectDetails"]
                self.baiKeDetail.id = projectDetails["id"].stringValue
                self.baiKeDetail.projectName = projectDetails["projectName"].string!
                self.baiKeDetail.projectAlias = projectDetails["projectAlias"].string!
                self.baiKeDetail.projectPresent = projectDetails["projectPresent"].string!
                self.baiKeDetail.projectType = projectDetails["projectType"].string!
                self.baiKeDetail.minPrice = projectDetails["minPrice"].string!
                self.baiKeDetail.maxPrice = projectDetails["maxPrice"].string!
                self.baiKeDetail.recoveryCycle = projectDetails["recoveryCycle"].string!
                self.baiKeDetail.treatmentCount = projectDetails["treatmentCount"].string!
                
                for (_ , subJson) : (String , JSON) in data["product"] {
                    let model = NewMain_ProjectListModel()
                    model.id = subJson["id"].string!
                    model.productName = subJson["productName"].string!
                    model.productChildName = subJson["productChildName"].string!
                    model.thumbnail = subJson["thumbnail"].string!
                    model.reservationPrice = subJson["reservationPrice"].float!
                    model.salaPrice = subJson["salaPrice"].float!
                    model.disPrice = subJson["disPrice"].float!
                    model.reservationCount = "\(subJson["reservationCount"].int!)"
                    model.doctorNames = subJson["doctorNames"].string!
                    self.projectSource.append(model)
                }
                for (_ , subJson) : (String , JSON) in data["articleList"] {
                    let model = NewMain_NoteListModel()
                    model.id = subJson["id"].string!
                    model.preopImages = subJson["preopImages"].string!
                    model.allowFollow = subJson["allowFollow"].bool!
                    model.follow = subJson["follow"].bool!
                    model.personald = subJson["article"]["diary"]["personal"]["id"].string!
                    let personal = subJson["personal"]
                        model.nickName = personal["nickName"].string!
                        model.photo = personal["photo"].string!
                        model.gender = personal["gender"].string!
                    let article = subJson["article"]
                        model.aId = article["id"].string!
                        model.content = article["content"].string!
                        model.images = article["images"].string!
                        model.createDate = article["createDate"].string!
                        model.comments = article["comments"].string!
                        model.thumbs = article["thumbs"].string!
                        model.hits = article["hits"].string!
                    self.noteSource.append(model)
                }
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

extension NewMain_BaiKe_DetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 1 {
            
            let detail = NewStoresDetailViewController.init(nibName: "NewStoresDetailViewController", bundle: nil)
            detail.isProject = true
            detail.id = projectSource[indexPath.row].id
            navigationController?.pushViewController(detail, animated: true)
        }
        
        if indexPath.section == 2 {
            
            let detail = NewNote_DetailVC()
            detail.id = noteSource[indexPath.row].id
            navigationController?.pushViewController(detail, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            let size = getSizeOnString(baiKeDetail.projectPresent, 14)
            return 190 + size.height
        }else if indexPath.section == 1 {
            return GET_SIZE * 248
        }else {
            return GET_SIZE * 640
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell : NewMain_BaiKeTabCell = tableView.dequeueReusableCell(withIdentifier: "NewMain_BaiKeTabCell", for: indexPath) as! NewMain_BaiKeTabCell
            cell.selectionStyle = .none
            cell.model = baiKeDetail
            return cell
        }else if indexPath.section == 1 {
            
            var cell:NewMainCaseListTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "NewMainCaseListTableViewCell") as? NewMainCaseListTableViewCell
            if nil == cell {
                cell! = NewMainCaseListTableViewCell.init(style: .default, reuseIdentifier: "NewMainCaseListTableViewCell")
            }
            cell?.selectionStyle = .none
            cell?.model = projectSource[indexPath.row]
            return cell!
        }else {
            
            var cell:NewMineNoteListTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "NewMineNoteListTableViewCell") as? NewMineNoteListTableViewCell
            if nil == cell {
                cell! = NewMineNoteListTableViewCell.init(style: .default, reuseIdentifier: "NewMineNoteListTableViewCell")
            }
            cell?.selectionStyle = .none
            cell?.model = noteSource[indexPath.row]
            return cell!
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 2 {
            return UIView()
        }
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            return UIView()
        }
        let head = UIView()
        head.backgroundColor = backGroundColor
        head.frame = CGRect.init(x: 0, y: 0, width: WIDTH, height: 44)
        
        let icon = UIImageView()
        
        let title = UILabel()
        title.textColor = darkText
        title.font = UIFont.systemFont(ofSize: TEXT32)
        
        if section == 1 {
            icon.image = UIImage(named:"project_icon_default")
            title.text = "相关项目"
        }else {
            icon.image = UIImage(named:"DiaryBook_icon_default")
            title.text = "相关日记"
        }
        head.addSubview(icon)
        _ = icon.sd_layout()?
            .centerYEqualToView(head)?
            .leftSpaceToView(head,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 36)?
            .heightIs(GET_SIZE * 36)
        
        head.addSubview(title)
        _ = title.sd_layout()?
            .centerYEqualToView(head)?
            .leftSpaceToView(icon,GET_SIZE * 18)?
            .widthIs(WIDTH/2)?
            .heightIs(GET_SIZE * 36)
        return head
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 44
    }
}

// MARK: - UITableViewDataSource

extension NewMain_BaiKe_DetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if projectSource.count == 0 && noteSource.count == 0 {
            return 1
        }
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        if section == 1 {
            return projectSource.count
        }
        if section == 2 {
            return noteSource.count
        }
        return 0
    }
}

