import UIKit
import MJRefresh
import SwiftyJSON
import ZFPlayer

class NewMainNoteViewController: Wx_baseViewController {
    
    var currentIndex = 0
    var maxPage : NSInteger = 0
    
    //顶部tableView
    var selectTableView = UITableView()
    fileprivate var selectDataSource = [selectModel]()
    //主tableView
    var mainTableView = UITableView()
    fileprivate var mainDateSource : [NewMain_NoteListModel] = []
    
    let baikeView = Wx_twoTableView()
    
    let topView = UIView()
    var btnArr = [UIButton]()
    var imgArr = [UIImageView]()
    
    var pageNo = 1
    
    fileprivate var id : String?
    fileprivate var sortType : String?
    var isShowTop = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildNavi()
        buildUI()
        buildSelectData()
        buildData(id,pageNo,sortType)
    }
    
    fileprivate func buildData(_ id: String?, _ pageNo: Int?, _ sortType: String?) {
        
        var up = [String : Any]()
        
        if id != nil {
            up["id"] = id!
        }
        
        if pageNo != nil {
            up["pageNo"] = pageNo!
        }
        
        if sortType != nil {
            up["sortType"] = sortType!
        }
        
        if Defaults.hasKey("SESSIONID") {
            up["mobileCode"] = Defaults["mobileCode"].stringValue
            up["SESSIONID"] = Defaults["SESSIONID"].stringValue
        }
        
        SVPWillShow("载入中...")
        delog(up)
        
        Net.share.getRequest(urlString: get_diary_classifyJoggle, params: up, success: { (datas) in
            let json = JSON(datas)
            delog(json)
            SVPHide()
            if json["code"].int == 1 {
                
                self.maxPage = json["data"]["totalPage"].int!
                if self.pageNo == 1 {
                    self.mainDateSource.removeAll()
                }
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
                    self.mainDateSource.append(model)
                }
                self.mainTableView.reloadData()
            }else {
                SVPwillShowAndHide(json["message"].string!)
            }
            self.endRefresh()
        }) { (error) in
            delog(error)
            SVPwillShowAndHide("请检查您的网路")
            self.endRefresh()
        }
    }
    
    private func buildSelectData() {
        
        let arr = ["默认排序","最新发表","最新回复","最热门"]
        for str in arr {
            let model = selectModel()
            model.title = str
            model.isSelect = false
            selectDataSource.append(model)
        }
        selectTableView.reloadData()
    }
    
    // MARK: - function
    private func buildTop() {
        
        let selectArr = ["全部项目","默认排序"]
        let wid = Int(WIDTH) / selectArr.count
        
        topView.backgroundColor = backGroundColor
        topView.frame = CGRect.init(x: 0, y: (HEIGHT == 812 ? 88 : 64), width: WIDTH, height: 49)
        view.addSubview(topView)
        
        selectTableView.frame = CGRect.init(x: 0, y: 0, width: WIDTH, height: 49)
        selectTableView.backgroundColor = backGroundColor
        selectTableView.delegate = self
        selectTableView.dataSource = self
        selectTableView.tableFooterView = UIView()
        selectTableView.separatorStyle = .none
        selectTableView.register(WXSelectTabCell.self, forCellReuseIdentifier: "WXSelectTabCell")
        topView.addSubview(selectTableView)
        
        baikeView.frame = CGRect.init(x: 0, y: 0, width: WIDTH, height: 49)
        topView.addSubview(baikeView)
        baikeView.reBuildData()
        weak var weakSelf = self
        baikeView.callBackBlock { (id, name) in
            delog("id\(id)")
            delog("name\(name)")
            weakSelf?.btnArr.first?.setTitle(name, for: .normal)
            weakSelf?.hideTableView()
            weakSelf?.id = id
            weakSelf?.buildData(weakSelf?.id, weakSelf?.pageNo, weakSelf?.sortType)
        }
        
        for index in 0..<selectArr.count {
            
            let btn = UIButton()
            btn.frame = CGRect.init(x: wid * index,
                                    y: 0,
                                    width: wid,
                                    height: 49)
            btn.backgroundColor = backGroundColor
            btn.setTitle(selectArr[index], for: .normal)
            btn.setTitleColor(lightText, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: TEXT28)
            btn.addTarget(self, action: #selector(click(_:)), for: .touchUpInside)
            topView.addSubview(btn)
            btnArr.append(btn)
            
            let img = UIImageView()
            img.image = UIImage(named:"shangla_icon_default")
            img.isUserInteractionEnabled = true
            btn.addSubview(img)
            imgArr.append(img)
            
            _ = img.sd_layout()?
                .centerYEqualToView(btn)?
                .leftSpaceToView(btn.titleLabel,5)?
                .widthIs(14)?
                .heightIs(7)
            
            btn.tag = 400 + index
            img.tag = 500 + index
            
            if index == selectArr.count - 1 {
                break
            }
            let line = UIView()
            line.backgroundColor = lineColor
            btn.addSubview(line)
            _ = line.sd_layout()?
                .centerYEqualToView(btn)?
                .rightEqualToView(btn)?
                .widthIs(0.5)?
                .heightIs(21)
        }
        
        let line = UIView()
        line.backgroundColor = lineColor
        line.frame = CGRect.init(x: 0, y: 48, width: WIDTH, height: 1)
        topView.addSubview(line)
    }
    
    private func buildUI() {
        
        mainTableView.backgroundColor = backGroundColor
        mainTableView.frame = CGRect.init(x: 0, y: (HEIGHT == 812 ? 88 : 64) + 49, width: WIDTH, height: HEIGHT - 49 - (HEIGHT == 812 ? 88 : 64))
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.tableFooterView = UIView()
        mainTableView.separatorStyle = .none
        mainTableView.register(NewMineNoteListTableViewCell.self, forCellReuseIdentifier: "NewMineNoteListTableViewCell")
        view.addSubview(mainTableView)
        weak var weakSelf = self
        mainTableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            
            weakSelf?.pageNo = 1
            weakSelf?.buildData(weakSelf?.id, weakSelf?.pageNo, weakSelf?.sortType)
        })
        
        buildTop()
    }
    
    // 导航栏
    private func buildNavi() {
        
        let naviView = UIView.init(frame: CGRect(x: 0, y: 0, width: WIDTH, height: (HEIGHT == 812 ? 88 : 64)))
        naviView.backgroundColor = UIColor.white
        view.addSubview(naviView)
        
        let title = UIImageView()
        title.image = UIImage(named:"SeeDiary_icon_default")
        naviView.addSubview(title)
        _ = title.sd_layout()?
            .topSpaceToView(naviView,(HEIGHT == 812 ? 44 : 20) + 13)?
            .centerXEqualToView(naviView)?
            .widthIs(56)?
            .heightIs(18)
        
        let btn = buildLeftBtn()
        naviView.addSubview(btn)
        _ = btn.sd_layout()?
            .centerYEqualToView(title)?
            .leftSpaceToView(naviView,0)?
            .widthIs(44)?
            .heightIs(44)
        
        let line = UIView()
        line.backgroundColor = lineColor
        naviView.addSubview(line)
        _ = line.sd_layout()?
            .bottomSpaceToView(naviView,0)?
            .leftSpaceToView(naviView,0)?
            .widthIs(WIDTH)?
            .heightIs(0.5)
    }
    
    // MARK: - 逻辑
    @objc private func click(_ btn: UIButton) {
        
        isShowTop = true
        currentIndex = btn.tag - 400
        if btn.isSelected {
            btn.isSelected = false
            hideTableView()
            return
        }
        
        //点击变色处理
        for index in btnArr {
            index.setTitleColor(lightText, for: .normal)
            index.isSelected = false
        }
        btn.setTitleColor(darkText, for: .normal)
        btn.isSelected = true
        
        //获得该选项的图像
        let img = view.viewWithTag(btn.tag + 100) as! UIImageView
        
        if currentIndex == 0 {
            
            UIView.animate(withDuration: 0.25, animations: {
                
                //view点击区域
                var frame1 = self.topView.frame
                frame1.origin.y = (HEIGHT == 812 ? 88 : 64)
                frame1.size.height = 6 * 49
                self.topView.frame = frame1
                
                //
                var frame2 = self.baikeView.frame
                frame2.size.height = 5 * 49
                frame2.origin.y = 49
                self.baikeView.frame = frame2
                
                var frame3 = self.selectTableView.frame
                frame3.origin.y = 0
                frame3.size.height = 49
                self.selectTableView.frame = frame3
                
                //img旋转
                for index in self.imgArr {
                    index.transform = CGAffineTransform.identity
                }
                img.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
            })
            return
        }
        
        UIView.animate(withDuration: 0.25, animations: {
            
            //self点击区域
            var frame1 = self.topView.frame
            frame1.origin.y = (HEIGHT == 812 ? 88 : 64)
            frame1.size.height = CGFloat((self.selectDataSource.count + 1) * 49)
            self.topView.frame = frame1
            
            //table区域
            var frame2 = self.selectTableView.frame
            frame2.size.height = CGFloat(self.selectDataSource.count * 49)
            frame2.origin.y = 49
            self.selectTableView.frame = frame2
            
            var frame3 = self.baikeView.frame
            frame3.origin.y = 0
            frame3.size.height = 49
            self.baikeView.frame = frame3
            
            //img旋转
            for index in self.imgArr {
                index.transform = CGAffineTransform.identity
            }
            img.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        })
//        selectTableView.reloadData()
    }
    
    func hideTableView() {
        
        isShowTop = false

        buildData(id, pageNo, sortType)
        //点击变色处理
        for index in btnArr {
            index.setTitleColor(lightText, for: .normal)
        }
        
        UIView.animate(withDuration: 0.3) {
            
            var frame1 = self.topView.frame
            frame1.size.height = 49
            frame1.origin.y = (HEIGHT == 812 ? 88 : 64)
            self.topView.frame = frame1
            
            var frame2 = self.selectTableView.frame
            frame2.origin.y = 0
            frame2.size.height = 49
            self.selectTableView.frame = frame2
            
            var frame3 = self.baikeView.frame
            frame3.origin.y = 0
            frame3.size.height = 49
            self.baikeView.frame = frame3
            
            //img旋转
            for index in self.imgArr {
                index.transform = CGAffineTransform.identity
            }
        }
    }
    
    //停止刷新
    func endRefresh() {
        mainTableView.mj_header.endRefreshing()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        for btn in btnArr {
            btn.isSelected = false
        }
        hideTableView()
    }
}

extension NewMainNoteViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == selectTableView {
            
            let btn = view.viewWithTag(400 + currentIndex) as! UIButton
            btn.setTitle(selectDataSource[indexPath.row].title, for: .normal)
            sortType = "\(indexPath.row)"
            hideTableView()
            buildData(id,pageNo,sortType)
        }else {
            
            tableView.deselectRow(at: indexPath, animated: true)

            let detail = NewNote_DetailVC()
            detail.id = mainDateSource[indexPath.row].id
            navigationController?.pushViewController(detail, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == selectTableView {
            return GET_SIZE * 98
        }
        return GET_SIZE * 640
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == selectTableView {
            var cell:WXSelectTabCell? = tableView.dequeueReusableCell(withIdentifier: "WXSelectTabCell")
                as? WXSelectTabCell
            if nil == cell {
                cell! = WXSelectTabCell.init(style: .default,reuseIdentifier: "WXSelectTabCell")
            }
            cell?.selectionStyle = .none
            cell?.model = selectDataSource[indexPath.row]
            return cell!
        }
        if indexPath.row >= mainDateSource.count - 3 {
            if self.pageNo < self.maxPage {
                self.pageNo += 1
                self.buildData(id,pageNo,sortType)
            }
        }
        var cell:NewMineNoteListTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "NewMineNoteListTableViewCell") as? NewMineNoteListTableViewCell
        if nil == cell {
            cell! = NewMineNoteListTableViewCell.init(style: .default, reuseIdentifier: "NewMineNoteListTableViewCell")
        }
        cell?.selectionStyle = .none
        cell?.model = mainDateSource[indexPath.row]
        return cell!
    }
}

extension NewMainNoteViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == selectTableView {
            return selectDataSource.count
        }
        return mainDateSource.count
    }
}

extension NewMainNoteViewController : HJImageBrowserDelegate {
    
    func getTheThumbnailImage(_ indexRow: Int) -> UIImage {
        return tmpImg
    }
}
