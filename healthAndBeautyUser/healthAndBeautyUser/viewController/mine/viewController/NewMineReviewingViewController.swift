//
//  NewMineReviewingViewController.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/10/26.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewMineReviewingViewController: Wx_baseViewController {
    
    //是否是审核中
    var isReviewing = Bool()
    //
    var id = String()
    //是否加载完数据
    var isLoad = Bool()
    
    lazy var tableView : UITableView = {
        
        let table = UITableView()
        table.backgroundColor = backGroundColor
        table.delegate = self
        table.dataSource = self
        table.tableFooterView = UIView.init()
        table.separatorStyle = .none
        
        table.register(UINib.init(nibName: "NewReviewHeadTabCell", bundle: nil),
                       forCellReuseIdentifier: "NewReviewHeadTabCell")
        table.register(UINib.init(nibName: "NewReviewDetailTabCell", bundle: nil),
                       forCellReuseIdentifier: "NewReviewDetailTabCell")
        table.register(NewReviewingNoteAndPicTabCell.self,
                       forCellReuseIdentifier: "NewReviewingNoteAndPicTabCell")
        
        return table
    }()
    
    var dateSource = NewReviewingModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isReviewing {
            createNaviController(title: "日记详情", leftBtn: buildLeftBtn(), rightBtn: nil)
        }else {
            createNaviController(title: "日记详情", leftBtn: buildLeftBtn(), rightBtn: buildRightBtnWithName("修改日记"))
        }
        buildUI()
        buildData()
    }
    
    override func rightClick() {
        
        let tmp = NewNoteCreateViewController.init(nibName: "NewNoteCreateViewController", bundle: nil)
        tmp.isReBuils = true
        tmp.diaryTitle = dateSource.diaryTitle
        tmp.titles = dateSource.title
        tmp.noteId = dateSource.id
        navigationController?.pushViewController(tmp, animated: true)
    }
    
    override func alertController() {
        
        var up = ["id" : id]
            as [String: Any]
        
        if Defaults.hasKey("SESSIONID") {
            up["mobileCode"] = Defaults["mobileCode"].stringValue
            up["SESSIONID"] = Defaults["SESSIONID"].stringValue
        }
        SVPWillShow("载入中...")
        delog(up)
        
        Net.share.postRequest(urlString: CBBDeleteDiaryJoggle, params: up, success: { (datas) in
            let json = JSON(datas)
            delog(json)
            SVPHide()
            if json["code"].int == 1 {
                
                self.navigationController?.popViewController(animated: true)
            }else {
                
                SVPwillShowAndHide(json["message"].string!)
            }
        }) { (error) in
            delog(error)
            SVPwillShowAndHide("请检查您的网路")
        }
    }
    
    private func buildUI() {
        
        view.addSubview(tableView)
        _ = tableView.sd_layout()?
            .topSpaceToView(naviView,0)?
            .leftSpaceToView(view,0)?
            .rightSpaceToView(view,0)?
            .bottomSpaceToView(view,0)
    }
    
    private func buildData() {
        
        var up = ["id" : id]
            as [String: Any]
        
        if Defaults.hasKey("SESSIONID") {
            up["mobileCode"] = Defaults["mobileCode"].stringValue
            up["SESSIONID"] = Defaults["SESSIONID"].stringValue
        }
        SVPWillShow("载入中...")
        delog(up)
        
        Net.share.getRequest(urlString: CBBGetDiaryJoggle, params: up, success: { (datas) in
            let json = JSON(datas)
            delog(json)
            SVPHide()
            if json["code"].int == 1 {
                
                let data = json["data"]
                
                self.dateSource.id = data["id"].string!
                self.dateSource.content = data["content"].string!
                self.dateSource.auditState = data["auditState"].string!
                self.dateSource.title = data["title"].string!
                self.dateSource.diaryTitle = data["diaryTitle"].string!
                self.dateSource.nickName = data["nickName"].string!
                self.dateSource.gender = data["gender"].string!
                self.dateSource.photo = data["photo"].string!
                self.dateSource.images = data["images"].arrayObject! as! [String]
                if !self.isReviewing {
                    self.dateSource.remarks = data["remarks"].string!
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
extension NewMineReviewingViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 59
        }
        
        //审核失败会多一个section
        if !isReviewing && indexPath.section == 1{
            
            let size = getSizeOnString(dateSource.remarks, 14)
            return size.height + 40
        }
        //判断完之后剩下的一个就是文字与图片偏了
        //术后第几天加浏览评论按钮以及分割线的高
        var height = GET_SIZE * 135
        
        //日记内容尺寸
        let size = getSizeOnString(dateSource.content, 14)
        height += size.height
        height += GET_SIZE * 18
        
        // 中文逗号  不是英文逗号
        let imgViewHeight = GET_SIZE * CGFloat(560 * (dateSource.images.count) + 16 * (dateSource.images.count - 1))
        height += imgViewHeight
        
        return height
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell : NewReviewHeadTabCell = tableView.dequeueReusableCell(withIdentifier: "NewReviewHeadTabCell", for: indexPath) as! NewReviewHeadTabCell
            cell.selectionStyle = .none
            cell.model = dateSource
            return cell
        }
        
        //审核失败会多一个section
        if !isReviewing && indexPath.section == 1{
            
            let cell:NewReviewDetailTabCell? = tableView.dequeueReusableCell(withIdentifier: "NewReviewDetailTabCell", for: indexPath) as? NewReviewDetailTabCell
            cell?.selectionStyle = .none
            cell?.model = dateSource
            return cell!
        }
        var cell:NewReviewingNoteAndPicTabCell? = tableView.dequeueReusableCell(withIdentifier: "NewReviewingNoteAndPicTabCell") as? NewReviewingNoteAndPicTabCell
        if nil == cell {
            cell! = NewReviewingNoteAndPicTabCell.init(style: .default, reuseIdentifier: "NewReviewingNoteAndPicTabCell")
        }
        cell?.selectionStyle = .none
        cell?.reviewModel = dateSource
        return cell!
    }
}

// MARK: - UITableViewDataSource
extension NewMineReviewingViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if !isLoad {
            return 0
        }
        if isReviewing {
            return 2
        }else {
            return 3
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}

