//
//  newStoreViewController.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/11.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import MJRefresh
import SwiftyJSON
import DZNEmptyDataSet

enum StoreViewButtonTag : NSInteger {
    case prject = 222
    case goods
    case specialGooods
}

class NewStoreViewController:  Wx_baseViewController{
    
    var currentPage : NSInteger = 0
    var currentIndex : NSInteger = 0
    //页码
    var leftPageIndex : NSInteger = 1
    var rightPageIndex : NSInteger = 1
    var leftMaxPage : NSInteger = 0
    var rightMaxPage : NSInteger = 0

    let baikeView = Wx_twoTableView()
    var selectDataSource = [selectModel]()
    var selectTableView = UITableView()
    let topView = UIView()
    var btnArr = [UIButton]()
    var imgArr = [UIImageView]()

    var isLoadLeft = false
    var leftDateSource : [NewStoreProjectModel] = []
    var leftTableView = UITableView()
    var leftClassifyId = String()
    var leftClassifyIdName = String()
    var leftOrderBy = String()
    var leftOrderByName = String()
    
    var isLoadRight = false
    var rightCalssDateSource : [NewStoreGoodsClassifies] = []
    var rightDateSource : [NewStoreGoodsModel] = []
    var rightTableView = UITableView()
    var rightClassifyId = String()
    var rightOrderBy = String()
    var rightClassifyIdName = String()
    var rightOrderByName = String()
    let scroller = UIScrollView()
    
    // MARK: - function
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildNavi()
        buildUI()
        buildSelectData()
        buildDataLeftData()
        buildDataRightData()
        
        //  接收登录成功的通知
        NotificationCenter.default.addObserver(self, selector: #selector(receiveNitification(nitofication:)), name: NSNotification.Name(rawValue: SuccessRefreshNotificationCenter_Login), object: nil)
        
    }
    
    @objc func receiveNitification(nitofication:Notification) {
        self.rightTableView.mj_header.beginRefreshing()
        self.leftTableView.mj_header.beginRefreshing()
    }

    private func reBuildAllData() {
        
        if isLoadLeft && isLoadRight {
            SVPHide()
            self.rightTableView.reloadData()
            self.leftTableView.reloadData()
        }
    }
    
    fileprivate func buildDataLeftData(){
        
        let up = ["pageNo":leftPageIndex,
                  "classifyId":leftClassifyId,
                  "orderBy":leftOrderBy]
            as [String: Any]
        
        SVPWillControllerShow("载入中...")
        delog(up)
        
        Net.share.getRequest(urlString: productList_12_joggle, params: up, success: { (datas) in
            
            let json = JSON(datas)
            delog(json)
            if json["code"].int == 1 {
                
                self.leftMaxPage = json["data"]["totalPage"].int!
                if self.leftPageIndex == 1 {
                    self.leftDateSource.removeAll()
                }
                let data = json["data"]
                //刷新项目数据
                for (_, subJson):(String, JSON) in data["products"] {
                    let model = NewStoreProjectModel()
                    model.disPrice = subJson["disPrice"].float!
                    model.doctorNames = subJson["doctorNames"].string!
                    model.id = subJson["id"].string!
                    model.productChildName = subJson["productChildName"].string!
                    model.productDescrible = subJson["productDescrible"].string!
                    model.productName = subJson["productName"].string!
                    model.reservationCount = subJson["reservationCount"].int!
                    model.reservationPrice = subJson["reservationPrice"].float!
                    model.salaPrice = subJson["salaPrice"].float!
                    model.thumbnail = subJson["thumbnail"].string!
                    model.isFree = subJson["isFree"].string!
                    self.leftDateSource.append(model)
                }
                self.isLoadLeft = true
                self.reBuildAllData()
            }
            self.endRefresh()
        }) { (error) in
            delog(error)
            self.endRefresh()
        }
    }
    fileprivate func buildDataRightData(){
        
        let up = ["pageNo":rightPageIndex,
                  "classifyId":rightClassifyId,
                  "orderBy":rightOrderBy]
            as [String: Any]
        
        SVPWillControllerShow("载入中...")
        delog(up)
        
        Net.share.getRequest(urlString: goodItemList_09_joggle, params: up, success: { (datas) in
            
            let json = JSON(datas)
            delog(json)
            if json["code"].int == 1 {
                
            if self.rightPageIndex == 1 {
                self.rightDateSource.removeAll()
            }
            self.rightMaxPage = json["data"]["totalPage"].int!
            let data = json["data"]
                //刷新商品数据
                //商品分类
                if self.rightCalssDateSource.count == 0 {
                    
                    let model = NewStoreGoodsClassifies()
                    model.goodClsName = "全部商品"
                    self.rightCalssDateSource.append(model)
                    
                    for (_, subJson):(String, JSON) in data["classifies"] {
                        let model = NewStoreGoodsClassifies()
                        model.createDate = subJson["createDate"].string!
                        model.goodClsName = subJson["goodClsName"].string!
                        model.id = subJson["id"].string!
                        model.sort = subJson["sort"].int!
                        model.updateDate = subJson["updateDate"].string!
                        self.rightCalssDateSource.append(model)
                    }
                }
                //商品列表
                for (_, subJson):(String, JSON) in data["goodItems"] {
                    let model = NewStoreGoodsModel()
                    model.disPrice = subJson["disPrice"].float!
                    model.goodItemChildName = subJson["goodItemChildName"].string!
                    model.goodItemDescrible = subJson["goodItemDescrible"].string!
                    model.goodItemName = subJson["goodItemName"].string!
                    model.id = subJson["id"].string!
                    model.isNew = subJson["isNew"].string!
                    model.isReconment = subJson["isReconment"].string!
                    model.isSale = subJson["isSale"].string!
                    model.postage = subJson["postage"].int!
                    model.reservationCount = subJson["reservationCount"].int!
                    model.salaPrice = subJson["salaPrice"].float!
                    model.thumbnail = subJson["thumbnail"].string!
                    
//                    if subJson["isFree"].string! != nil {
//                        model.isFree = subJson["isFree"].string!
//                    }
                    
                    self.rightDateSource.append(model)
                }
                self.isLoadRight = true
                self.reBuildAllData()
            }
            self.endRefresh()
        }) { (error) in
            delog(error)
            self.endRefresh()
        }
    }
    
    private func buildSelectData() {
        
        let arr = ["智能排序","价格最高","价格最低","销量优先"]
        let idArr = ["","a.dis_price DESC","a.dis_price","a.reservation_count DESC"]
        for index in 0..<arr.count {
            let model = selectModel()
            model.title = arr[index]
            model.id = idArr[index]
            model.isSelect = false
            selectDataSource.append(model)
        }
    }
    
    private func buildUI() {
        
        //page 项目 商品 特权商品
        scroller.alwaysBounceHorizontal = false
        scroller.showsHorizontalScrollIndicator = false
        scroller.isPagingEnabled = true
        scroller.delegate = self
        scroller.bounces = false
        scroller.contentSize = CGSize.init(width: WIDTH*2, height: 0)
        view.addSubview(scroller)
        _ = scroller.sd_layout()?
            .topSpaceToView(view,(HEIGHT == 812 ? 88 : 64) + 49)?
            .leftSpaceToView(view,0)?
            .rightSpaceToView(view,0)?
            .bottomSpaceToView(view,(HEIGHT == 812 ? 49+34 : 49))
        
        leftTableView.delegate = self
        leftTableView.dataSource = self
        leftTableView.tableFooterView = UIView.init()
        leftTableView.separatorStyle = .none
        leftTableView.register(NewStoreListTabCell.self, forCellReuseIdentifier: "NewStoreListTabCell")
        leftTableView.emptyDataSetSource = self
        leftTableView.emptyDataSetDelegate = self
        
        rightTableView.delegate = self
        rightTableView.dataSource = self
        rightTableView.tableFooterView = UIView.init()
        rightTableView.separatorStyle = .none
        rightTableView.register(NewStoreListTabCell.self, forCellReuseIdentifier: "NewStoreListTabCell")
        rightTableView.emptyDataSetSource = self
        rightTableView.emptyDataSetDelegate = self
        
        weak var weakSelf = self
        scroller.addSubview(leftTableView)
        _ = leftTableView.sd_layout()?
            .topSpaceToView(scroller,0)?
            .widthIs(WIDTH)?
            .leftSpaceToView(scroller,0)?
            .bottomSpaceToView(scroller,0)
        leftTableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            weakSelf!.leftPageIndex = 1
            weakSelf!.buildDataLeftData()
        })

        scroller.addSubview(rightTableView)
        _ = rightTableView.sd_layout()?
            .topSpaceToView(scroller,0)?
            .widthIs(WIDTH)?
            .leftSpaceToView(leftTableView,0)?
            .bottomSpaceToView(scroller,0)
        rightTableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            weakSelf!.rightPageIndex = 1
            weakSelf!.buildDataRightData()
        })
        
        let toTop = UIButton()
        toTop.setImage(UIImage(named:"top"), for: .normal)
        toTop.addTarget(self, action: #selector(toViewTop), for: .touchUpInside)
        view.addSubview(toTop)
        _ = toTop.sd_layout()?
            .bottomSpaceToView(view,(HEIGHT == 812 ? 95 : 62))?
            .rightSpaceToView(view,15)?
            .widthIs(GET_SIZE * 58)?
            .heightIs(GET_SIZE * 58)
        
        buildTab()
    }
    
    //点击下拉view
    private func buildTab() {
        
        topView.backgroundColor = backGroundColor
        topView.frame = CGRect.init(x: 0, y: (HEIGHT == 812 ? 88 : 64), width: WIDTH, height: 49)
        view.addSubview(topView)
        
        baikeView.frame = CGRect.init(x: 0, y: 0, width: WIDTH, height: 49)
        topView.addSubview(baikeView)
        baikeView.isParent = true
        baikeView.reBuildData()
        weak var weakSelf = self
        baikeView.callBackBlock { (id, name) in
            delog("id\(id)")
            delog("name\(name)")
            weakSelf!.leftClassifyIdName = name
            weakSelf!.leftClassifyId = id
            weakSelf!.buildDataLeftData()
            weakSelf!.hideTableView()
            
            let btn = weakSelf!.view.viewWithTag(400) as! UIButton
            btn.setTitle(name, for: .normal)
        }
        
        selectTableView.frame = CGRect.init(x: 0, y: 0, width: WIDTH, height: 49)
        selectTableView.backgroundColor = backGroundColor
        selectTableView.delegate = self
        selectTableView.dataSource = self
        selectTableView.tableFooterView = UIView()
        selectTableView.separatorStyle = .none
        selectTableView.register(WXSelectTabCell.self, forCellReuseIdentifier: "WXSelectTabCell")
        topView.addSubview(selectTableView)
        
        buildTOPUI()
    }
    
    // MARK: - 项目首页顶部
    private func buildTOPUI() {
        
        let selectArr = ["全部项目","默认排序"]
        let wid = Int(WIDTH) / selectArr.count
        
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
            btn.addTarget(self, action: #selector(topClick(_:)), for: .touchUpInside)
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
            
            if index == 0 {
                //中间线
                let line = UIView()
                line.backgroundColor = lineColor
                btn.addSubview(line)
                _ = line.sd_layout()?
                    .centerYEqualToView(btn)?
                    .rightEqualToView(btn)?
                    .widthIs(0.5)?
                    .heightIs(21)
            }
        }
        
        //底边线
        let line = UIView()
        line.backgroundColor = lineColor
        line.frame = CGRect.init(x: 0, y: 48, width: WIDTH, height: 1)
        topView.addSubview(line)
    }
    
    @objc private func topClick(_ btn: UIButton) {
        
        currentIndex = btn.tag - 400
        
        if btn.isSelected {
            btn.isSelected = !btn.isSelected
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
        
        //判断序号
        //先判断是左边按钮还是右边按钮 0左其他右
        if currentIndex == 0 {
            
            //接着判断是左边页面还是右边页面吧
            if currentPage == 0 {
                
                //百科view显示出来
                UIView.animate(withDuration: 0.25, animations: {
                    
                    //基本标记
                    var frame1 = self.topView.frame
                    frame1.size.height = 6 * 49
                    self.topView.frame = frame1
                    
                    //项目百科标记
                    var frame2 = self.baikeView.frame
                    frame2.size.height = 5 * 49
                    frame2.origin.y = 49
                    self.baikeView.frame = frame2
                    
                    //商品类别
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
            }else {

                //商品分类列表显示出来
                self.selectTableView.reloadData()
                UIView.animate(withDuration: 0.25, animations: {
                    
                    //self点击区域
                    var frame1 = self.topView.frame
                    frame1.size.height = CGFloat((self.rightCalssDateSource.count + 1) * 49)
                    self.topView.frame = frame1
                    
                    //table区域
                    var frame2 = self.selectTableView.frame
                    frame2.origin.y = 49
                    frame2.size.height = CGFloat(self.rightCalssDateSource.count * 49)
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
            }
        }else {

            //条件筛选刷新数据
            selectTableView.reloadData()
            UIView.animate(withDuration: 0.25, animations: {
                
                //self点击区域
                var frame1 = self.topView.frame
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
        }
    }
    
    // MARK: - 顶部隐藏
    func hideTableView() {
        
        //点击变色处理
        for index in btnArr {
            index.isSelected = false
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
    private func endRefresh() {
        
        leftTableView.mj_header.endRefreshing()
        rightTableView.mj_header.endRefreshing()
    }
    
    // MARK: - 导航栏
    let project = UIButton()
    let goods = UIButton()
    let specialGoods = UIButton()
    let colorView = UIView()
    
    var sizes = CGSize()
    
    private func buildNavi() {
        
        naviView.backgroundColor = UIColor.white
        naviView.frame = CGRect.init(x: 0, y: 0, width: WIDTH, height: (HEIGHT == 812 ? 88 : 64))
        view.addSubview(naviView)
        
        project.frame = CGRect.init(x: WIDTH/2-70, y: (HEIGHT == 812 ? 44 : 20), width: 70, height: 42)
        project.setTitle("项目", for: .normal)
        project.setTitleColor(tabbarColor, for: .normal)
        project.addTarget(self, action: #selector(clickNavi(_:)), for: .touchUpInside)
        project.tag = StoreViewButtonTag.prject.rawValue
        project.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        naviView.addSubview(project)
        
        goods.frame = CGRect.init(x: WIDTH/2, y: (HEIGHT == 812 ? 44 : 20), width: 70, height: 42)
        goods.setTitle("商品", for: .normal)
        goods.setTitleColor(lightText, for: .normal)
        goods.addTarget(self, action: #selector(clickNavi(_:)), for: .touchUpInside)
        goods.tag = StoreViewButtonTag.goods.rawValue
        goods.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        naviView.addSubview(goods)
        
        sizes = getSizeOnLabel(project.titleLabel!)
        
        colorView.backgroundColor = tabbarColor
        naviView.addSubview(colorView)
        
        colorView.frame = CGRect.init(x: (project.titleLabel!.origin.x)/2 + project.origin.x,
                                      y: naviView.height - 2,
                                      width: sizes.width,
                                      height: 1.5)
        
        let search = UIButton()
        search.tag = 700
        search.setImage(UIImage(named:"search"), for: .normal)
        search.addTarget(self, action: #selector(clickNavi(_:)), for: .touchUpInside)
        search.frame = CGRect.init(x: WIDTH-64, y: (HEIGHT == 812 ? 44 : 20), width: 44, height: 44)
        naviView.addSubview(search)
        
        let car = UIButton()
        car.tag = 701
        car.setImage(UIImage(named:"shopping_icon"), for: .normal)
        car.addTarget(self, action: #selector(clickNavi(_:)), for: .touchUpInside)
        car.frame = CGRect.init(x: WIDTH-108, y: (HEIGHT == 812 ? 44 : 20), width: 44, height: 44)
        naviView.addSubview(car)
        
        let line = UIView()
        line.backgroundColor = lineColor
        naviView.addSubview(line)
        _ = line.sd_layout()?
            .bottomSpaceToView(naviView,0)?
            .leftSpaceToView(naviView,0)?
            .widthIs(WIDTH)?
            .heightIs(0.5)
    }
    
    @objc private func clickNavi(_ btn: UIButton) {
        
        switch btn.tag {
            
        case StoreViewButtonTag.prject.rawValue:
            delog("项目")
            colorViewStartMove(0)
            scroller.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            break
        case StoreViewButtonTag.goods.rawValue:
            delog("商品")
            colorViewStartMove(1)
            scroller.setContentOffset(CGPoint(x: WIDTH, y: 0), animated: true)
            break
        case 700:
            //搜索
            break
        case 701:
            //购物车
            let tmp = NewShoppingCarViewController.init(nibName: "NewShoppingCarViewController", bundle: nil)
            navigationController?.pushViewController(tmp, animated: true)
            break
        default:
            break
        }
    }
    
    // location 0项目  1商品 2特权商品
    fileprivate func colorViewStartMove(_ location: Int) {
        
        hideTableView()
        currentPage = location
        
        if location == 0 {
            
            let left = view.viewWithTag(400) as! UIButton
            if leftClassifyIdName.count != 0 {
                left.setTitle(leftClassifyIdName, for: .normal)
            }else {
                left.setTitle("全部项目", for: .normal)
            }
            
            let right = view.viewWithTag(401) as! UIButton
            if leftOrderByName.count != 0 {
                right.setTitle(leftOrderByName, for: .normal)
            }else {
                right.setTitle("默认排序", for: .normal)
            }
            sizes = getSizeOnLabel(project.titleLabel!)
            
            project.setTitleColor(tabbarColor, for: .normal)
            goods.setTitleColor(lightText, for: .normal)
            specialGoods.setTitleColor(lightText, for: .normal)
            
            UIView.animate(withDuration: 0.3, animations: {
                var frame = self.colorView.frame
                frame.size.width = self.sizes.width
                frame.origin.x = self.project.titleLabel!.origin.x + self.project.origin.x
                self.colorView.frame = frame
            })
        }else if location == 1 {
            
            let left = view.viewWithTag(400) as! UIButton
            if rightClassifyIdName.count != 0 {
                left.setTitle(rightClassifyIdName, for: .normal)
            }else {
                left.setTitle("全部项目", for: .normal)
            }
            
            let right = view.viewWithTag(401) as! UIButton
            if rightOrderByName.count != 0 {
                right.setTitle(rightOrderByName, for: .normal)
            }else {
                right.setTitle("默认排序", for: .normal)
            }
            
            sizes = getSizeOnLabel(goods.titleLabel!)

            project.setTitleColor(lightText, for: .normal)
            goods.setTitleColor(tabbarColor, for: .normal)
            specialGoods.setTitleColor(lightText, for: .normal)

            UIView.animate(withDuration: 0.3, animations: {
                
                var frame = self.colorView.frame
                frame.size.width = self.sizes.width
                frame.origin.x = self.goods.titleLabel!.origin.x + self.goods.origin.x
                self.colorView.frame = frame
            })
        }
//        else if location == 2 {
//            //暂时没有特权商品
////            rightTableView.reloadData()
//
//            sizes = getSizeOnLabel(specialGoods.titleLabel!)
//
//            project.setTitleColor(darkText, for: .normal)
//            goods.setTitleColor(darkText, for: .normal)
//            specialGoods.setTitleColor(tabbarColor, for: .normal)
//
//            UIView.animate(withDuration: 0.3, animations: {
//
//                var frame = self.colorView.frame
//                frame.size.width = self.sizes.width
//                frame.origin.x = self.specialGoods.titleLabel!.origin.x + self.specialGoods.origin.x
//                self.colorView.frame = frame
//            })
//        }
    }
    
    //点击前往顶部
    @objc private func toViewTop() {
        if currentPage == 0 {
            leftTableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .bottom, animated: true)
        } else if currentPage == 1 {
            rightTableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .bottom, animated: true)
        }
    }
}

// MARK: - UIScrollViewDelegate
extension NewStoreViewController : UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if scrollView == scroller {
            
            if scrollView.contentOffset.x == 0 {
                colorViewStartMove(0)
            } else if scrollView.contentOffset.x == scrollView.frame.size.width {
                colorViewStartMove(1)
            } else {
                colorViewStartMove(2)
            }
        }
    }
}

// MARK: - UITableViewDelegate
extension NewStoreViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if tableView == leftTableView || tableView == rightTableView {
            
            let detail = NewStoresDetailViewController.init(nibName: "NewStoresDetailViewController", bundle: nil)
            if tableView == leftTableView {
                detail.isProject = true
                detail.id = leftDateSource[indexPath.row].id
            }else {
                detail.isProject = false
                detail.id = rightDateSource[indexPath.row].id
            }
            navigationController?.pushViewController(detail, animated: true)
        }else {
            
            //判断序号
            if currentPage == 0 {
            //左边页面
                leftOrderByName = selectDataSource[indexPath.row].title
                leftOrderBy = selectDataSource[indexPath.row].id
                buildDataLeftData()
                
                let btn = view.viewWithTag(401) as! UIButton
                btn.setTitle(leftOrderByName, for: .normal)
            }else {
            //右边页面
                if currentIndex == 0 {
                    //左边按钮
                    rightClassifyId = rightCalssDateSource[indexPath.row].id
                    rightClassifyIdName = rightCalssDateSource[indexPath.row].goodClsName
                    let btn = view.viewWithTag(400) as! UIButton
                    btn.setTitle(rightClassifyIdName, for: .normal)
                }else {
                    //右边按钮
                    rightOrderByName = selectDataSource[indexPath.row].title
                    rightOrderBy = selectDataSource[indexPath.row].id
                    let btn = view.viewWithTag(401) as! UIButton
                    btn.setTitle(rightOrderByName, for: .normal)
                }
                buildDataRightData()
            }
        }
        hideTableView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView == selectTableView {
            return 49
        }
        return GET_SIZE * 246
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == leftTableView {
            
            if indexPath.row >= leftDateSource.count - 3 {
                if self.leftPageIndex < self.leftMaxPage {
                    self.leftPageIndex += 1
                    self.buildDataLeftData()
                }
            }
            var cell:NewStoreListTabCell? = tableView.dequeueReusableCell(withIdentifier: "NewStoreListTabCell") as? NewStoreListTabCell
            if nil == cell {
                cell! = NewStoreListTabCell.init(style: .default, reuseIdentifier: "NewStoreListTabCell")
            }
            cell?.selectionStyle = .none
            cell?.projectModel = leftDateSource[indexPath.row]
            return cell!
        }else if tableView == rightTableView {
            
            if indexPath.row >= leftDateSource.count - 3 {
                if self.rightPageIndex < self.rightMaxPage {
                    self.rightPageIndex += 1
                    self.buildDataRightData()
                }
            }
            var cell:NewStoreListTabCell? = tableView.dequeueReusableCell(withIdentifier: "NewStoreListTabCell") as? NewStoreListTabCell
            if nil == cell {
                cell! = NewStoreListTabCell.init(style: .default, reuseIdentifier: "NewStoreListTabCell")
            }
            cell?.selectionStyle = .none
            cell?.goodsModel = rightDateSource[indexPath.row]
            return cell!
        }else if tableView == selectTableView {
            
            var cell:WXSelectTabCell? = tableView.dequeueReusableCell(withIdentifier: "WXSelectTabCell")
                as? WXSelectTabCell
            if nil == cell {
                cell! = WXSelectTabCell.init(style: .default,reuseIdentifier: "WXSelectTabCell")
            }
            cell?.selectionStyle = .none
            //只有左边的才显示商品分类
            if currentIndex == 0 {
                cell?.cModel = rightCalssDateSource[indexPath.row]
            }else {
                cell?.model = selectDataSource[indexPath.row]
            }
            return cell!
        }else {
            return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDataSource
extension NewStoreViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == leftTableView {
            return leftDateSource.count
        }else if tableView == rightTableView {
            return rightDateSource.count
        }else {
            if currentIndex == 0 {
                return rightCalssDateSource.count
            }else {
                return selectDataSource.count
            }
        }
    }
}

// MARK: -
extension NewStoreViewController: DZNEmptyDataSetSource,DZNEmptyDataSetDelegate {
    
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
