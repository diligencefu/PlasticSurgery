//
//  newMineNoteViewController.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/16.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON
import MJRefresh
import DZNEmptyDataSet

class NewMineNoteViewController: Wx_baseViewController {
    
    let pushedBtn = UIButton()
    let reviewingBtn = UIButton()
    let reviewedBtn = UIButton()
    let colorView = UIView()
    
    let scroller = UIScrollView()
    //已发布列表
    var pushedDateSource : [NewMain_NoteListModel] = []
    //审核中
    var reviewingDateSource : [NewMineReviewingModel] = []
    //审核失败
    var reviewedDateSource : [NewMineReviewingModel] = []
    
    var tableViewList : [UITableView] = []
    
    var pageIndex : NSInteger = 1
    var maxPage : NSInteger = 0
    var currentPage : NSInteger = 1
    
    var id = String()
    var order_no = String()
    var countDay = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createNaviController(title: "日记列表", leftBtn: buildLeftBtn(), rightBtn: nil)
        buildUI()
        buildTop()
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
            .topSpaceToView(naviView,44)?
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
            tabelView.register(NewMineNoteListTableViewCell.self, forCellReuseIdentifier: "NewMineNoteListTableViewCell")
            tabelView.register(NewReviewTabCell.self, forCellReuseIdentifier: "NewReviewTabCell")
            
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
        
        var url = String()
        switch currentPage {
        case 1:
            url = CBBGetReleaseDiarysJoggle
            break
        case 2:
            url = CBBGetUnpublishedDiarysJoggle
            up["flag"] = "0"
            break
        case 3:
            url = CBBGetUnpublishedDiarysJoggle
            up["flag"] = "2"
            break
        default:
            break
        }
        SVPWillShow("载入中...")
        delog(up)
        
        Net.share.getRequest(urlString: url, params: up, success: { (datas) in
            let json = JSON(datas)
            delog(json)
            SVPHide()
            if json["code"].int == 1 {
                
                switch self.currentPage {
                case 1:
                    self.relosvePushed(json)
                    break
                case 2:
                    self.relosveReviewing(json)
                    break
                case 3:
                    self.relosveReviewed(json)
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
        
        switch currentPage {
        case 1:
            tableViewList[0].mj_header.endRefreshing()
            break
        case 2:
            tableViewList[1].mj_header.endRefreshing()
            break
        case 3:
            tableViewList[2].mj_header.endRefreshing()
            break
        default:
            break
        }
    }
    
    //解析日记
    private func relosvePushed(_ json: JSON) {
        
        if pageIndex == 1 {
            pushedDateSource.removeAll()
        }
        maxPage = json["data"]["totalPage"].int!
        let data = json["data"]
        for (_ , subJson) : (String , JSON) in data["articleList"] {
            let model = NewMain_NoteListModel()
            model.id = subJson["id"].string!
            model.preopImages = subJson["preopImages"].string!
            model.allowFollow = subJson["allowFollow"].bool!
            model.follow = subJson["follow"].bool!
            let personal = subJson["personal"]
                model.personald = personal["id"].string!
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
            self.pushedDateSource.append(model)
            tableViewList[0].reloadData()
        }
    }
    //解析项目
    private func relosveReviewing(_ json: JSON) {
        
        if pageIndex == 1 {
            reviewingDateSource.removeAll()
        }
        maxPage = json["data"]["totalPage"].int!
        let data = json["data"]
        for (_, subJson):(String,JSON) in data["articles"] {
            let model = NewMineReviewingModel()

            model.id = subJson["id"].string!
            model.content = subJson["content"].string!
            model.auditState = subJson["auditState"].string!
            model.title = subJson["title"].string!
            model.projectName = subJson["projectName"].string!
            model.nickName = subJson["nickName"].string!
            model.gender = subJson["gender"].string!
            model.photo = subJson["photo"].string!
            model.images = subJson["images"].arrayObject! as! [String]
            self.reviewingDateSource.append(model)
            tableViewList[1].reloadData()
        }
    }
    //解析商品
    private func relosveReviewed(_ json: JSON) {
        
        if pageIndex == 1 {
            reviewedDateSource.removeAll()
        }
        maxPage = json["data"]["totalPage"].int!
        let data = json["data"]
        for (_, subJson):(String,JSON) in data["articles"] {
            let model = NewMineReviewingModel()

            model.id = subJson["id"].string!
            model.content = subJson["content"].string!
            model.auditState = subJson["auditState"].string!
            model.title = subJson["title"].string!
            model.projectName = subJson["projectName"].string!
            model.nickName = subJson["nickName"].string!
            model.gender = subJson["gender"].string!
            model.photo = subJson["photo"].string!
            model.images = subJson["images"].arrayObject! as! [String]
            self.reviewedDateSource.append(model)
            tableViewList[2].reloadData()
        }
    }
}

//导航栏视图
extension NewMineNoteViewController {
    
    fileprivate func buildTop() {
        
        pushedBtn.frame = CGRect.init(x: 0, y: (HEIGHT == 812 ? 88 : 64), width: WIDTH/3, height: 42)
        pushedBtn.setTitle("已发布", for: .normal)
        pushedBtn.setTitleColor(tabbarColor, for: .normal)
        pushedBtn.addTarget(self, action: #selector(clickTop(_:)), for: .touchUpInside)
        pushedBtn.tag = 100
        pushedBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        view.addSubview(pushedBtn)
        
        reviewingBtn.frame = CGRect.init(x: WIDTH/3, y: (HEIGHT == 812 ? 88 : 64), width: WIDTH/3, height: 42)
        reviewingBtn.setTitle("审核中", for: .normal)
        reviewingBtn.setTitleColor(lightText, for: .normal)
        reviewingBtn.addTarget(self, action: #selector(clickTop(_:)), for: .touchUpInside)
        reviewingBtn.tag = 101
        reviewingBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        view.addSubview(reviewingBtn)
        
        reviewedBtn.frame = CGRect.init(x: WIDTH/3*2, y: (HEIGHT == 812 ? 88 : 64), width: WIDTH/3, height: 42)
        reviewedBtn.setTitle("审核失败", for: .normal)
        reviewedBtn.setTitleColor(lightText, for: .normal)
        reviewedBtn.addTarget(self, action: #selector(clickTop(_:)), for: .touchUpInside)
        reviewedBtn.tag = 102
        reviewedBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        view.addSubview(reviewedBtn)
        
        let sizes = getSizeOnLabel(pushedBtn.titleLabel!)
        
        colorView.backgroundColor = tabbarColor
        view.addSubview(colorView)
        
        colorView.frame = CGRect.init(x: 0,
                                      y: (HEIGHT == 812 ? 88 : 64)+42,
                                      width: sizes.width,
                                      height: 1.5)
        colorView.centerX = pushedBtn.centerX
        
        let line = UIView()
        line.frame = CGRect.init(x: 0,
                                 y: (HEIGHT == 812 ? 88 : 64)+43.5,
                                 width: WIDTH,
                                 height: 0.5)
        line.backgroundColor = lineColor
        view.addSubview(line)
    }
    
    @objc fileprivate func clickTop(_ btn: UIButton) {
        
        switch btn.tag {
            
        case 100:
            delog("已发布")
            currentPage = 1
            colorViewStartMove(1)
            scroller.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            break
            
        case 101:
            delog("审核中")
            currentPage = 2
            colorViewStartMove(2)
            scroller.setContentOffset(CGPoint(x: WIDTH, y: 0), animated: true)
            break
            
        case 102:
            delog("审核失败")
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
            
            sizes = getSizeOnLabel(pushedBtn.titleLabel!)
            
            pushedBtn.setTitleColor(tabbarColor, for: .normal)
            reviewingBtn.setTitleColor(lightText, for: .normal)
            reviewedBtn.setTitleColor(lightText, for: .normal)
            
            UIView.animate(withDuration: 0.15, animations: {
                var frame = self.colorView.frame
                frame.size.width = sizes.width
                frame.origin.x = self.pushedBtn.titleLabel!.origin.x + self.pushedBtn.origin.x
                self.colorView.frame = frame
            })
        }else if location == 2 {
            
            sizes = getSizeOnLabel(reviewingBtn.titleLabel!)
            
            pushedBtn.setTitleColor(lightText, for: .normal)
            reviewingBtn.setTitleColor(tabbarColor, for: .normal)
            reviewedBtn.setTitleColor(lightText, for: .normal)
            
            UIView.animate(withDuration: 0.15, animations: {
                
                var frame = self.colorView.frame
                frame.size.width = sizes.width
                frame.origin.x = self.reviewingBtn.titleLabel!.origin.x + self.reviewingBtn.origin.x
                self.colorView.frame = frame
            })
        }else if location == 3 {
            
            sizes = getSizeOnLabel(reviewedBtn.titleLabel!)
            
            pushedBtn.setTitleColor(lightText, for: .normal)
            reviewingBtn.setTitleColor(lightText, for: .normal)
            reviewedBtn.setTitleColor(tabbarColor, for: .normal)
            
            UIView.animate(withDuration: 0.15, animations: {
                
                var frame = self.colorView.frame
                frame.size.width = sizes.width
                frame.origin.x = self.reviewedBtn.titleLabel!.origin.x + self.reviewedBtn.origin.x
                self.colorView.frame = frame
            })
        }
        buildData()
    }
}

// MARK: - UIScrollViewDelegate
extension NewMineNoteViewController : UIScrollViewDelegate {
    
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
extension NewMineNoteViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if currentPage == 1 {
            
            let detail = NewNote_DetailVC()
            detail.id = pushedDateSource[indexPath.row].id
            navigationController?.pushViewController(detail, animated: true)
        }else {
            
            let enter = NewMineReviewingViewController()
            switch currentPage {
            case 2:
                enter.isReviewing = true
                enter.id = reviewingDateSource[indexPath.row].id
                break
            case 3:
                enter.isReviewing = false
                enter.id = reviewedDateSource[indexPath.row].id
                break
            default:
                break
            }
            navigationController?.pushViewController(enter, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch currentPage {
        case 1:
            return GET_SIZE * 640
        case 2:
            //加浏览评论按钮以及分割线的高
            var height = GET_SIZE * 138
            
            //日记内容尺寸
            let size = getSizeOnString(reviewingDateSource[indexPath.row].content, 14)
            //最多3排
            height += ((size.height > 50) ? 50 : size.height)
            height += GET_SIZE * 18
            
            // 中文逗号  不是英文逗号
            var x = reviewingDateSource[indexPath.row].images.count / 3   //行数
            if reviewingDateSource[indexPath.row].images.count == 3 ||
                reviewingDateSource[indexPath.row].images.count == 6 ||
                reviewingDateSource[indexPath.row].images.count == 9 {
                x -= 1
            }
            let imgViewHeight = GET_SIZE * CGFloat(176 * (x + 1) + 16 * x + 14)
            height += imgViewHeight
            return height
        case 3:
            //加浏览评论按钮以及分割线的高
            var height = GET_SIZE * 138

            //日记内容尺寸
            
            let size = getSizeOnString(reviewedDateSource[indexPath.row].content, 14)
            //最多3排
            height += ((size.height > 50) ? 50 : size.height)
            height += GET_SIZE * 18
            
            // 中文逗号  不是英文逗号
            var x = reviewedDateSource[indexPath.row].images.count / 3   //行数
            if reviewedDateSource[indexPath.row].images.count == 3 ||
                reviewedDateSource[indexPath.row].images.count == 6 ||
                reviewedDateSource[indexPath.row].images.count == 9 {
                x -= 1
            }
            let imgViewHeight = GET_SIZE * CGFloat(176 * (x + 1) + 16 * x + 14)
            height += imgViewHeight
            return height
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch currentPage {
        case 1:
            
            if indexPath.row >= pushedDateSource.count - 3 {
                if self.pageIndex < self.maxPage {
                    self.pageIndex += 1
                    self.buildData()
                }
            }
            var cell:NewMineNoteListTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "NewMineNoteListTableViewCell") as? NewMineNoteListTableViewCell
            if nil == cell {
                cell! = NewMineNoteListTableViewCell.init(style: .default, reuseIdentifier: "NewMineNoteListTableViewCell")
            }
            cell?.selectionStyle = .none
            cell?.model = pushedDateSource[indexPath.row]
            return cell!
        case 2,3:
            var cell:NewReviewTabCell? = tableView.dequeueReusableCell(withIdentifier: "NewReviewTabCell") as? NewReviewTabCell
            if nil == cell {
                cell! = NewReviewTabCell.init(style: .default, reuseIdentifier: "NewReviewTabCell")
            }
            cell?.selectionStyle = .none
            if currentPage == 2 {
                
                if indexPath.row >= reviewingDateSource.count - 3 {
                    if self.pageIndex < self.maxPage {
                        self.pageIndex += 1
                        self.buildData()
                    }
                }
                cell?.reviewingModel = reviewingDateSource[indexPath.row]
            }else {
                
                if indexPath.row >= reviewedDateSource.count - 3 {
                    if self.pageIndex < self.maxPage {
                        self.pageIndex += 1
                        self.buildData()
                    }
                }
                cell?.reviewingModel = reviewedDateSource[indexPath.row]
            }
            return cell!
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDataSource
extension NewMineNoteViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch currentPage {
        case 1:
            return pushedDateSource.count
        case 2:
            return reviewingDateSource.count
        case 3:
            return reviewedDateSource.count
        default:
            return 0
        }
    }
}

// MARK: -
extension NewMineNoteViewController: DZNEmptyDataSetSource,DZNEmptyDataSetDelegate {
    
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
