//
//  NewNoteBookDetailViewController.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/9/20.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewNoteBookDetailViewController: Wx_baseViewController {
    
    var id = String()
    var isAllowWrite = Bool()
    
    lazy var tableView : UITableView = {
        let table = UITableView()
        table.backgroundColor = backGroundColor
        table.delegate = self
        table.dataSource = self
        table.tableFooterView = UIView.init()
        table.separatorStyle = .none
        
        table.register(NewNoteBookDetailListTabCell.self, forCellReuseIdentifier: "NewNoteBookDetailListTabCell")
        
        return table
    }()
    var dateSource : [NewNoteEnterListModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createNaviController(title: "日记列表", leftBtn: buildLeftBtn(), rightBtn: nil)
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
            .bottomSpaceToView(view,49)
        
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.white
        view.addSubview(bottomView)
        _ = bottomView.sd_layout()?
            .bottomSpaceToView(view,0)?
            .leftSpaceToView(view,0)?
            .rightSpaceToView(view,0)?
            .heightIs(49)
        
        let line = UIView()
        line.backgroundColor = getColorWithNotAlphe(0xD7D7D7)
        bottomView.addSubview(line)
        _ = line.sd_layout()?
            .topSpaceToView(bottomView,0)?
            .leftSpaceToView(bottomView,0)?
            .rightSpaceToView(bottomView,0)?
            .heightIs(0.5)
        
        let writeNote = UIButton()
        writeNote.setTitle("写日记", for: .normal)
        writeNote.backgroundColor = tabbarColor
        writeNote.setTitleColor(UIColor.white, for: .normal)
        writeNote.titleLabel?.font = UIFont.systemFont(ofSize: GET_SIZE * 36)
        viewRadius(writeNote, 5.0, 0.5, tabbarColor)
        writeNote.addTarget(self, action: #selector(clickWrieNote), for: .touchUpInside)
        bottomView.addSubview(writeNote)
        _ = writeNote.sd_layout()?
            .centerYEqualToView(bottomView)?
            .centerXEqualToView(bottomView)?
            .widthIs(GET_SIZE * 700)?
            .heightIs(GET_SIZE * 72)
    }
    
    private func buildData() {
        
        let up = ["mobileCode":Defaults["mobileCode"].stringValue,
                  "SESSIONID":Defaults["SESSIONID"].stringValue,
                  "id":id]
            as [String: Any]
        delog(up)
        
        SVPWillShow("载入中...")
        
        Net.share.getRequest(urlString: CBBDiaryOrdersJoggle, params: up, success: { (datas) in
            let json = JSON(datas)
            delog(json)
            SVPHide()
            if json["code"].int == 1 {
                self.dateSource.removeAll()
                let data = json["data"]
                for (_, subJson):(String, JSON) in data["MyDiary"] {

                    let model = NewNoteEnterListModel()
                    model.id = subJson["id"].string!
                    model.project_name = subJson["project_name"].string!
                    model.create_date = subJson["create_date"].string!
                    model.gender = subJson["gender"].string!
                    model.thumbs = subJson["thumbs"].int!
                    model.comments = subJson["comments"].int!
                    model.preop_images = subJson["preop_images"].string!
                    model.nick_name = subJson["nick_name"].string!
                    model.project_alias = subJson["project_alias"].string!
                    model.hits = subJson["hits"].int!
                    model.images = subJson["images"].string!
                    model.photo.append(subJson["photo"].string!)
                    model.content = subJson["content"].string!
                    self.dateSource.append(model)
                }
                self.tableView.reloadData()
            }
        }) { (error) in
            delog(error)
        }
    }
    
    @objc private func clickWrieNote() {
        
        let tmp = NewNoteCreateViewController.init(nibName: "NewNoteCreateViewController", bundle: nil)
//        tmp.order_no = order_no
        tmp.noteId = id
//        tmp.countDay = countDay
        navigationController?.pushViewController(tmp, animated: true)
    }
}

// MARK: - UITableViewDelegate

extension NewNoteBookDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let enter = NewNote_DetailEnterVC()
//        enter.id = id
        enter.isMe = true
        enter.articlesId = dateSource[indexPath.row].id
        navigationController?.pushViewController(enter, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return GET_SIZE * 640
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:NewNoteBookDetailListTabCell? = tableView.dequeueReusableCell(withIdentifier: "NewNoteBookDetailListTabCell") as? NewNoteBookDetailListTabCell
        if nil == cell {
            cell! = NewNoteBookDetailListTabCell.init(style: .default, reuseIdentifier: "NewNoteBookDetailListTabCell")
        }
        cell?.selectionStyle = .none
        cell?.noteModel = dateSource[indexPath.row]
        return cell!
    }
}

// MARK: - UITableViewDataSource
extension NewNoteBookDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dateSource.count
    }
}
