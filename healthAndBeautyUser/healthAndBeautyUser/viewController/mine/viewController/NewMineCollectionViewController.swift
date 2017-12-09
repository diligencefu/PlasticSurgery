
//
//  NewMineCollectionViewController.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/28.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON
import MJRefresh
import DZNEmptyDataSet

class NewMineCollectionViewController: Wx_baseViewController {
    
    let noteBtn = UIButton()
    let projectBtn = UIButton()
    let goodsBtn = UIButton()
    let colorView = UIView()
    
    let scroller = UIScrollView()
    var noteDateSource : [NewMineCollectionNoteModel] = []
    var projectDateSource : [NewStoreProjectModel] = []
    var goodsDateSource : [NewStoreGoodsModel] = []
    
    var tableViewList : [UITableView] = []
    
    var pageIndex : NSInteger = 1
    var maxPage : NSInteger = 0

    var currentPage : NSInteger = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createNaviController(title: "我的收藏", leftBtn: buildLeftBtn(), rightBtn: nil)
        buildTop()
        buildUI()
        buildData()
    }
    
    private func buildUI() {
        
        //page 项目 商品 特权商品
        scroller.alwaysBounceHorizontal = false
        scroller.showsHorizontalScrollIndicator = false
        scroller.isPagingEnabled = true
        scroller.delegate = self
        scroller.bounces = false
        scroller.contentSize = CGSize.init(width: WIDTH*3, height: 0)
        view.addSubview(scroller)
        _ = scroller.sd_layout()?
            .topSpaceToView(view,(HEIGHT == 812 ? 88 : 64) + 49)?
            .leftSpaceToView(view,0)?
            .rightSpaceToView(view,0)?
            .bottomSpaceToView(view,0)
        
        for index in 0..<3 {
            
            let tabelView = UITableView()
            tabelView.delegate = self
            tabelView.dataSource = self
            tabelView.emptyDataSetSource = self
            tabelView.emptyDataSetDelegate = self
            tabelView.tableFooterView = UIView.init()
            tabelView.separatorStyle = .none
            tabelView.register(NewStoreListTabCell.self, forCellReuseIdentifier: "NewStoreListTabCell")
            tabelView.register(NewMainNoteListTabCell.self, forCellReuseIdentifier: "NewMainNoteListTabCell")

            weak var weakSelf = self
            scroller.addSubview(tabelView)
            _ = tabelView.sd_layout()?
                .topSpaceToView(scroller,0)?
                .widthIs(WIDTH)?
                .leftSpaceToView(scroller,WIDTH * CGFloat(index))?
                .bottomSpaceToView(scroller,0)
            tabelView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
                weakSelf?.pageIndex = 1
                weakSelf?.buildData()
            })
            
            tableViewList.append(tabelView)
        }
    }
    
    fileprivate func buildData() {
        
        var up = ["pageNo" : pageIndex]
            as [String: Any]
        
        if Defaults.hasKey("SESSIONID") {
            up["mobileCode"] = Defaults["mobileCode"].stringValue
            up["SESSIONID"] = Defaults["SESSIONID"].stringValue
        }else {
            SVPwillShowAndHide("请登录后重新操作")
            present(NewLoginLocationViewController(), animated: true, completion: nil)
            return
        }
        
        switch currentPage {
        case 1:
            up["collectionType"] = "1"
            break
        case 2:
            up["collectionType"] = "2"
            break
        case 3:
            up["collectionType"] = "3"
            break
        default:
            break
        }
        SVPWillShow("载入中...")
        delog(up)
        
        Net.share.getRequest(urlString: getEnshrinesJoggle, params: up, success: { (datas) in
            let json = JSON(datas)
            delog(json)
            SVPHide()
            if json["code"].int == 1 {
                
                self.maxPage = json["data"]["totalPage"].int!
                switch self.currentPage {
                case 1:
                    self.relosveNote(json)
                    break
                case 2:
                    self.relosvePeoject(json)
                    break
                case 3:
                    self.relosveGoods(json)
                    break
                default:
                    break
                }
            }else {
                SVPwillShowAndHide(json["message"].string!)
            }
            self.endRefresh()
        }) { (error) in
            delog(error)
            SVPwillShowAndHide("请检查您的网路")
        }
    }
    
    //停止刷新
    private func endRefresh() {
        
        tableViewList[0].mj_header.endRefreshing()
        tableViewList[1].mj_header.endRefreshing()
        tableViewList[2].mj_header.endRefreshing()
    }
    
    //解析日记
    private func relosveNote(_ json: JSON) {
        
        if pageIndex == 1 {
            noteDateSource.removeAll()
        }
        let data = json["data"]
        for (_, subJson):(String,JSON) in data["enshrines"] {
            let model = NewMineCollectionNoteModel()
            
            let object = subJson["object"]
            model.id = object["id"].string!
            model.title = object["title"].string!
            model.hits = object["hits"].string!
            model.comments = object["comments"].string!
            model.thumbs = object["thumbs"].string!
            model.time = object["createDate"].string!

            let diary = object["diary"]
            let personal = diary["personal"]
            model.nickName = personal["nickName"].string!
            model.photo = personal["photo"].string!
            model.gender = personal["gender"].string!
            
            for (_, tags):(String,JSON) in object["tags"] {
                if tags["tarContent"].string != nil {
                    model.tarContent += "\(tags["tarContent"].string!) "
                }
            }
            model.imageList = object["imageList"].arrayObject as! [String]
            self.noteDateSource.append(model)
            tableViewList[0].reloadData()
        }
    }
    //解析项目
    private func relosvePeoject(_ json: JSON) {
        
        if pageIndex == 1 {
            projectDateSource.removeAll()
        }
        let data = json["data"]
        for (_, subJson):(String,JSON) in data["enshrines"] {
            let model = NewStoreProjectModel()
            
            let object = subJson["object"]
            model.id = object["id"].string!
            model.productName = object["productName"].string!
            model.productChildName = object["productChildName"].string!
            model.thumbnail = object["thumbnail"].string!
            model.doctorNames = object["doctorNames"].string!
            model.reservationCount = object["reservationCount"].int!
            model.salaPrice = object["salaPrice"].float!
            model.disPrice = object["disPrice"].float!
            self.projectDateSource.append(model)
            tableViewList[1].reloadData()
        }
    }
    
    //解析商品
    private func relosveGoods(_ json: JSON) {
        
        if pageIndex == 1 {
            goodsDateSource.removeAll()
        }
        let data = json["data"]
        for (_, subJson):(String,JSON) in data["enshrines"] {
            let model = NewStoreGoodsModel()
            
            let object = subJson["object"]
            model.id = object["id"].string!
            model.goodItemName = object["goodItemName"].string!
            model.goodItemChildName = object["goodItemChildName"].string!
            model.thumbnail = object["thumbnail"].string!
            model.reservationCount = object["reservationCount"].int!
            model.salaPrice = object["salaPrice"].float!
            model.disPrice = object["disPrice"].float!
            self.goodsDateSource.append(model)
            tableViewList[2].reloadData()
        }
    }
}

//导航栏视图
extension NewMineCollectionViewController {

    fileprivate func buildTop() {
        
        noteBtn.frame = CGRect.init(x: 0, y: (HEIGHT == 812 ? 88 : 64), width: WIDTH/3, height: 49)
        noteBtn.setTitle("日记", for: .normal)
        noteBtn.setTitleColor(tabbarColor, for: .normal)
        noteBtn.addTarget(self, action: #selector(clickTop(_:)), for: .touchUpInside)
        noteBtn.tag = 100
        noteBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        view.addSubview(noteBtn)
        
        projectBtn.frame = CGRect.init(x: WIDTH/3, y: (HEIGHT == 812 ? 88 : 64), width: WIDTH/3, height: 49)
        projectBtn.setTitle("案例", for: .normal)
        projectBtn.setTitleColor(lightText, for: .normal)
        projectBtn.addTarget(self, action: #selector(clickTop(_:)), for: .touchUpInside)
        projectBtn.tag = 101
        projectBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        view.addSubview(projectBtn)
        
        goodsBtn.frame = CGRect.init(x: WIDTH/3*2, y: (HEIGHT == 812 ? 88 : 64), width: WIDTH/3, height: 49)
        goodsBtn.setTitle("商品", for: .normal)
        goodsBtn.setTitleColor(lightText, for: .normal)
        goodsBtn.addTarget(self, action: #selector(clickTop(_:)), for: .touchUpInside)
        goodsBtn.tag = 102
        goodsBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        view.addSubview(goodsBtn)
        
        let sizes = getSizeOnLabel(noteBtn.titleLabel!)
        
        colorView.backgroundColor = tabbarColor
        view.addSubview(colorView)
        
        colorView.frame = CGRect.init(x: 0,
                                      y: (HEIGHT == 812 ? 88 : 64)+47,
                                      width: sizes.width,
                                      height: 1.5)
        colorView.centerX = noteBtn.centerX
        
        let line = UIView()
        line.frame = CGRect.init(x: 0,
                                 y: (HEIGHT == 812 ? 88 : 64)+48.5,
                                 width: WIDTH,
                                 height: 0.5)
        line.backgroundColor = lineColor
        view.addSubview(line)
    }

    @objc fileprivate func clickTop(_ btn: UIButton) {
        
        switch btn.tag {
            
        case 100:
            delog("日记")
            currentPage = 1
            colorViewStartMove(1)
            scroller.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            break
            
        case 101:
            delog("项目")
            currentPage = 2
            colorViewStartMove(2)
            scroller.setContentOffset(CGPoint(x: WIDTH, y: 0), animated: true)
            break
            
        case 102:
            delog("商品")
            currentPage = 3
            colorViewStartMove(3)
            scroller.setContentOffset(CGPoint(x: WIDTH*2, y: 0), animated: true)
            break
            
        default:
            break
        }
    }

    // location 0项目  1商品 2特权商品
    fileprivate func colorViewStartMove(_ location: Int) {
        
        var sizes = CGSize()
        if location == 1 {
            
            sizes = getSizeOnLabel(noteBtn.titleLabel!)
            
            noteBtn.setTitleColor(tabbarColor, for: .normal)
            projectBtn.setTitleColor(lightText, for: .normal)
            goodsBtn.setTitleColor(lightText, for: .normal)
            
            UIView.animate(withDuration: 0.15, animations: {
                var frame = self.colorView.frame
                frame.size.width = sizes.width
                frame.origin.x = self.noteBtn.titleLabel!.origin.x + self.noteBtn.origin.x
                self.colorView.frame = frame
            })
        }else if location == 2 {
        
            sizes = getSizeOnLabel(projectBtn.titleLabel!)
            
            noteBtn.setTitleColor(lightText, for: .normal)
            projectBtn.setTitleColor(tabbarColor, for: .normal)
            goodsBtn.setTitleColor(lightText, for: .normal)
            
            UIView.animate(withDuration: 0.15, animations: {
                
                var frame = self.colorView.frame
                frame.size.width = sizes.width
                frame.origin.x = self.projectBtn.titleLabel!.origin.x + self.projectBtn.origin.x
                self.colorView.frame = frame
            })
        }else if location == 3 {
            
            sizes = getSizeOnLabel(goodsBtn.titleLabel!)
            
            noteBtn.setTitleColor(lightText, for: .normal)
            projectBtn.setTitleColor(lightText, for: .normal)
            goodsBtn.setTitleColor(tabbarColor, for: .normal)

            UIView.animate(withDuration: 0.15, animations: {

                var frame = self.colorView.frame
                frame.size.width = sizes.width
                frame.origin.x = self.goodsBtn.titleLabel!.origin.x + self.goodsBtn.origin.x
                self.colorView.frame = frame
            })
        }
        buildData()
    }
}

// MARK: - UIScrollViewDelegate
extension NewMineCollectionViewController : UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if scrollView == scroller {
            
            if scrollView.contentOffset.x == 0 {
                currentPage = 1
            } else if scrollView.contentOffset.x == WIDTH {
                currentPage = 2
            } else {
                currentPage = 3
            }
            colorViewStartMove(currentPage)
        }
    }
}

// MARK: - UITableViewDelegate
extension NewMineCollectionViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch currentPage {
        case 1:
            //加浏览评论按钮以及分割线的高
            var height = GET_SIZE * 315
            
            //日记内容尺寸
            let size = getSizeOnString(noteDateSource[indexPath.row].title, 14)
            height += size.height
            height += GET_SIZE * 18
            
            // 中文逗号  不是英文逗号
            var x = noteDateSource[indexPath.row].imageList.count / 3   //行数
            if noteDateSource[indexPath.row].imageList.count == 3 ||
                noteDateSource[indexPath.row].imageList.count == 6 ||
                noteDateSource[indexPath.row].imageList.count == 9 {
                x -= 1
            }
            let imgViewHeight = GET_SIZE * CGFloat(176 * (x + 1) + 16 * x)
            height += imgViewHeight
            return height
        case 2,3:
            return GET_SIZE * 249
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch currentPage {
        case 1:
            if indexPath.row >= noteDateSource.count - 3 {
                if pageIndex < maxPage {
                    pageIndex += 1
                    buildData()
                }
            }
            var cell:NewMainNoteListTabCell? = tableView.dequeueReusableCell(withIdentifier: "NewMainNoteListTabCell") as? NewMainNoteListTabCell
            if nil == cell {
                cell! = NewMainNoteListTabCell.init(style: .default, reuseIdentifier: "NewMineNoteListTableViewCell")
            }
            cell?.selectionStyle = .none
            cell?.model = noteDateSource[indexPath.row]
            return cell!
        case 2:
            if indexPath.row >= projectDateSource.count - 3 {
                if pageIndex < maxPage {
                    pageIndex += 1
                    buildData()
                }
            }
            var cell:NewStoreListTabCell? = tableView.dequeueReusableCell(withIdentifier: "NewStoreListTabCell") as? NewStoreListTabCell
            if nil == cell {
                cell! = NewStoreListTabCell.init(style: .default, reuseIdentifier: "NewStoreListTabCell")
            }
            cell?.selectionStyle = .none
            cell?.projectModel = projectDateSource[indexPath.row]
            return cell!
        case 3:
            if indexPath.row >= goodsDateSource.count - 3 {
                if pageIndex < maxPage {
                    pageIndex += 1
                    buildData()
                }
            }
            var cell:NewStoreListTabCell? = tableView.dequeueReusableCell(withIdentifier: "NewStoreListTabCell") as? NewStoreListTabCell
            if nil == cell {
                cell! = NewStoreListTabCell.init(style: .default, reuseIdentifier: "NewStoreListTabCell")
            }
            cell?.selectionStyle = .none
            cell?.goodsModel = goodsDateSource[indexPath.row]
            return cell!
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDataSource
extension NewMineCollectionViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch currentPage {
        case 1:
            return noteDateSource.count
        case 2:
            return projectDateSource.count
        case 3:
            return goodsDateSource.count
        default:
            return 0
        }
    }
}

// MARK: -
extension NewMineCollectionViewController: DZNEmptyDataSetSource,DZNEmptyDataSetDelegate {
    
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
