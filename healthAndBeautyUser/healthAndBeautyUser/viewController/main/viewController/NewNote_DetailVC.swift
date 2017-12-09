//
//  NewNote_DetailVC.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/9/25.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON
import MJRefresh

class NewNote_DetailVC: Wx_baseViewController {
    
    var id = String()
    
    //是否加载完数据   因为数据结构只有一个列表 定死了 全是除了日记列表外全是1 所以必须得强制写1  如果数据没有请求完就自动刷新页面 会崩溃 所以加载完后修改这个值即可
    var isLoadData = false
    
    lazy var tableView : UITableView = {
        let table = UITableView()
        table.backgroundColor = backGroundColor
        table.delegate = self
        table.dataSource = self
        table.tableFooterView = UIView.init()
        table.separatorStyle = .none
        
        table.register(NewNote_MessageTableCell.self, forCellReuseIdentifier: "NewNote_MessageTableCell")
        table.register(NewMain_Note_ListTabCell.self, forCellReuseIdentifier: "NewMain_Note_ListTabCell")
        table.register(NewNote_CaseTabCell.self, forCellReuseIdentifier: "NewNote_CaseTabCell")
        
        table.register(UINib.init(nibName: "NewNote_ThreePictrueTabCell", bundle: nil), forCellReuseIdentifier: "NewNote_ThreePictrueTabCell")
        
        return table
    }()
    
    var dataModel = NewNoteDetail_2Model()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createNaviController(title: "日记",
                             leftBtn: buildLeftBtn(),
                             rightBtn: buildRightBtnWithIMG(UIImage(named:"share_icon_default")!))
        buildUI()
        buildData()
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
        
        Net.share.getRequest(urlString: CBBUserListJoggle, params: up, success: { (datas) in
            let json = JSON(datas)
            delog(json)
            SVPHide()
            if json["code"].int == 1 {
                
                let data = json["data"]
                //个人部分数据
                let personal = data["personal"]
                self.dataModel.personal.id = personal["id"].string!
                self.dataModel.personal.doneProject = personal["doneProject"].string!
                self.dataModel.personal.follow = personal["follow"].int!
                self.dataModel.personal.age = personal["age"].int!
                self.dataModel.personal.userType = personal["userType"].string!
                self.dataModel.personal.area = personal["area"].string!
                self.dataModel.personal.article = personal["article"].int!
                self.dataModel.personal.birthday = personal["birthday"].string!
                self.dataModel.personal.nickName = personal["nickName"].string!
                self.dataModel.personal.integral = personal["integral"].int!
                self.dataModel.personal.fans = personal["fans"].int!
                self.dataModel.personal.photo = personal["photo"].string!
                self.dataModel.personal.gender = personal["gender"].string!
                
                //产品部分数据
                let product = data["product"]
                self.dataModel.product.id = product["id"].string!
                self.dataModel.product.doctorNames = product["doctorNames"].string!
                self.dataModel.product.createDate = product["createDate"].string!
                self.dataModel.product.productName = product["productName"].string!
                self.dataModel.product.salaPrice = product["salaPrice"].float!
                self.dataModel.product.isDiscount = product["isDiscount"].string!
                self.dataModel.product.disPrice = product["disPrice"].float!
                self.dataModel.product.reservationCount = product["reservationCount"].int!
                self.dataModel.product.productDescrible = product["productDescrible"].string!
                self.dataModel.product.updateDate = product["updateDate"].string!
                self.dataModel.product.thumbnail = product["thumbnail"].string!
                self.dataModel.product.productChildName = product["productChildName"].string!
                self.dataModel.product.reservationPrice = product["reservationPrice"].float!
                
                //三张术前照片图
                self.dataModel.preopImages = data["preopImages"].arrayObject as! [String]
                
                //日记详情
                for (_ , subJson) : (String , JSON) in data["articles"] {
                    let model = NewNoteDetail_2Model_Articles()
                    model.id = subJson["id"].string!
                    model.comments = subJson["comments"].string!
                    model.rewards = subJson["rewards"].string!
                    model.auditState = subJson["auditState"].string!
                    model.thumbs = subJson["thumbs"].string!
                    model.createDate = subJson["createDate"].string!
                    model.imageList = subJson["imageList"].arrayObject as! [String]
                    model.title = subJson["title"].string!
                    model.updateDate = subJson["updateDate"].string!
                    model.diaryId = subJson["diaryId"].string!
                    model.images = subJson["images"].string!
                    model.hits = subJson["hits"].string!
                    model.content = subJson["content"].string!
                    self.dataModel.articles.append(model)
                }
                
                //日记详情
                for (_ , subJson) : (String , JSON) in data["docotrs"] {

                    let model = NewNoteDetail_2Model_docotrs()
                    model.doctorName = subJson["doctorName"].string!
                    model.id = subJson["id"].string!
                    model.sex = subJson["sex"].string!
                    model.bespoke = subJson["bespoke"].int!
                    model.cases = subJson["cases"].int!
                    self.dataModel.docotrs.append(model)
                }
                self.isLoadData = true
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

extension NewNote_DetailVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 3 {
            let enter = NewNote_DetailEnterVC()
            enter.articlesId = dataModel.articles[indexPath.row].id
            navigationController?.pushViewController(enter, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return GET_SIZE * 208
        }else if indexPath.section == 1 {
            return GET_SIZE * 248
        }else if indexPath.section == 2 {
            return GET_SIZE * 285
        }else {
            
            //术后第几天加浏览评论按钮以及分割线的高
            var height = GET_SIZE * 220
            
            //日记内容尺寸
            let size = getSizeOnString(dataModel.articles[indexPath.row].content, 14)
            height += size.height
            height += GET_SIZE * 18
            
            // 中文逗号  不是英文逗号
            var x = dataModel.articles[indexPath.row].imageList.count / 3   //行数
            delog(x)
            if dataModel.articles[indexPath.row].imageList.count == 3 ||
                dataModel.articles[indexPath.row].imageList.count == 6 ||
                dataModel.articles[indexPath.row].imageList.count == 9 {
                x -= 1
            }
            delog(x)
            let imgViewHeight = GET_SIZE * CGFloat(176 * (x + 1) + 16 * x)
            height += imgViewHeight
            
            return height
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
           
            var cell:NewNote_MessageTableCell? = tableView.dequeueReusableCell(withIdentifier: "NewNote_MessageTableCell") as? NewNote_MessageTableCell
            if nil == cell {
                cell! = NewNote_MessageTableCell.init(style: .default, reuseIdentifier: "NewNote_MessageTableCell")
            }
            cell?.selectionStyle = .none
            cell?.model = dataModel
            return cell!
        }else if indexPath.section == 1 {
            
            var cell:NewNote_CaseTabCell? = tableView.dequeueReusableCell(withIdentifier: "NewNote_CaseTabCell") as? NewNote_CaseTabCell
            if nil == cell {
                cell! = NewNote_CaseTabCell.init(style: .default, reuseIdentifier: "NewNote_CaseTabCell")
            }
            cell?.selectionStyle = .none
            cell?.dModel = dataModel.product
            return cell!
        }else if indexPath.section == 2 {
            
            let cell : NewNote_ThreePictrueTabCell = tableView.dequeueReusableCell(withIdentifier: "NewNote_ThreePictrueTabCell", for: indexPath) as! NewNote_ThreePictrueTabCell
            cell.selectionStyle = .none
            cell.model = dataModel.preopImages
            return cell
        }else {
            
            var cell:NewMain_Note_ListTabCell? = tableView.dequeueReusableCell(withIdentifier: "NewMain_Note_ListTabCell") as? NewMain_Note_ListTabCell
            if nil == cell {
                cell! = NewMain_Note_ListTabCell.init(style: .default, reuseIdentifier: "NewMain_Note_ListTabCell")
            }
            cell?.selectionStyle = .none
            cell?.model = dataModel.articles[indexPath.row]
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 || section == 3 {
            return UIView()
        }
        let foot = UIView()
        foot.backgroundColor = lineColor
        return foot
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 || section == 3 {
            return 0
        }
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section != 1 {
            return UIView()
        }
        
        let head = UIView()
        head.backgroundColor = backGroundColor
        head.frame = CGRect.init(x: 0, y: 0, width: WIDTH, height: 44)
        
        let icon = UIImageView()
        
        let title = UILabel()
        title.textColor = darkText
        title.font = UIFont.systemFont(ofSize: TEXT32)
        
        icon.image = UIImage(named:"project_icon_default")
        title.text = "相关项目"
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
        if section != 1 {
            return 0
        }
        return 44
    }
}

// MARK: - UITableViewDataSource

extension NewNote_DetailVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if !isLoadData {
            return 0
        }
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if !isLoadData {
            return 0
        }
        
        if section <= 2 {
            return 1
        }
        return dataModel.articles.count
    }
}


