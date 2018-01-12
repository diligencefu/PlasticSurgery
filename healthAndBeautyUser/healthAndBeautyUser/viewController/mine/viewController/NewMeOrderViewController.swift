//
//  NewMeOrderViewController.swift
//  healthAndBeautyUser
//
//  Created by 丿番茄 on 2017/11/7.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON
import MJRefresh
import DZNEmptyDataSet

class NewMeOrderViewController: Wx_baseViewController {
    
    var leftState : Int = -1
    var rightState : Int = -1

    var scroller = UIScrollView()
    var currentPage: Int = 0    //0项目1商品
    
    var leftPageIndex: Int = 1
    var leftMax: Int = 1
    var rightPageIndex: Int = 1
    var rightMax: Int = 1

    let leftTopView = Wx_scrollerBtnView()
    var leftTableView = UITableView()
    
    let rightTopView = Wx_scrollerBtnView()
    var rightTableView = UITableView()
    
    var leftDataSource = [[NewMineOrderLIstModel]]()
    var rightDataSource = [[NewGoodsOrderListModel]]()

    override func viewDidLoad() {
        super.viewDidLoad()

        buildNavi()
        buildUI()
        
        if leftState == -1 {
            //右边
            scroller.setContentOffset(CGPoint(x: WIDTH, y: 0), animated: true)
            colorView.frame = CGRect.init(x: (goods.titleLabel!.origin.x)/2 + goods.origin.x,
                                          y: naviView.height - 2,
                                          width: sizes.width,
                                          height: 1.5)
            project.setTitleColor(darkText, for: .normal)
            goods.setTitleColor(tabbarColor, for: .normal)
            buildGoodsData(rightState)
            buildData(0)
        }else {
            
            buildData(leftState)
            buildGoodsData(0)
        }
    }
    
    func buildGoodsData(_ state: Int) {
        
        var up = [:]
            as [String: Any]
        
        if Defaults.hasKey("SESSIONID") {
            up["mobileCode"] = Defaults["mobileCode"].stringValue
            up["SESSIONID"] = Defaults["SESSIONID"].stringValue
        }else {
            SVPwillShowAndHide("请登录后重新操作")
            let login = NewLoginLocationViewController.init(nibName: "NewLoginLocationViewController", bundle: nil)
            let loginVC = Wx_baseNaviViewController.init(rootViewController: login)
            self.present(loginVC, animated: true, completion: nil)
            return
        }
        
        SVPWillShow("加载中...")
        
        if state == 0 {
            //待支付
            delog(up)
            Net.share.getRequest(urlString: stayGoodOrderList_54_joggle, params: up, success: { (datas) in
                
                let json = JSON(datas)
                SVPHide()
                delog(json)
                
                if json["code"].int == 1 {
                    
                    self.rightDataSource.removeAll()
                    var x = 0
                    for (_, subJson):(String, JSON) in json["data"]["stayGoodOrderList"] {
                        
                        self.rightDataSource.append([NewGoodsOrderListModel]())
                        for (_, subJson2):(String, JSON) in subJson["orderGoodChilds"] {
                            
                            //防止串值
                            let model = NewGoodsOrderListModel()
                            model.type = 0
                            model.id = subJson["id"].string!
                            model.productTotal = subJson["productTotal"].float!
                            model.pickType = subJson["pickType"].string!
                            
                            model.list.goodId = subJson2["goodId"].string!
                            model.list.goodName = subJson2["goodName"].string!
                            model.list.goodChildName = subJson2["goodChildName"].string!
                            model.list.thumbnail = subJson2["thumbnail"].string!
                            model.list.num = subJson2["num"].int!
                            model.list.goodPrice = subJson2["goodPrice"].float!
                            self.rightDataSource[x].append(model)
                        }
                        x += 1
                    }
                    self.rightTableView.reloadData()
                    self.endRefresh()
                }
            }) { (error) in
                delog(error)
                self.endRefresh()
            }
        }else if state == 1 || state == 2 || state == 3 {
            
            //待付尾款 已支付 已完成
            up["flag"] = state - 1
            up["pageNo"] = leftPageIndex
            delog(up)
            
            Net.share.getRequest(urlString: goodOrders_56_joggle, params: up, success: { (datas) in
                let json = JSON(datas)
                SVPHide()
                delog(json)
                if json["code"].int == 1 {
                    
                    if self.rightPageIndex == 1 {
                        self.rightDataSource.removeAll()
                    }
                    self.rightMax = json["data"]["totalPage"].int!
                    var x = 0
                    for (_, subJson):(String, JSON) in json["data"]["goodOrders"] {
                        
                        self.rightDataSource.append([NewGoodsOrderListModel]())
                        for (_, subJson2):(String, JSON) in subJson["orderGoodChilds"] {
                            
                            //防止串值
                            let model = NewGoodsOrderListModel()
                            model.type = state
                            model.id = subJson["id"].string!
                            model.productTotal = subJson["productTotal"].float!
                            model.pickType = subJson["pickType"].string!
                            
                            model.list.goodId = subJson2["goodId"].string!
                            model.list.goodName = subJson2["goodName"].string!
                            model.list.goodChildName = subJson2["goodChildName"].string!
                            model.list.thumbnail = subJson2["thumbnail"].string!
                            model.list.num = subJson2["num"].int!
                            model.list.goodPrice = subJson2["goodPrice"].float!
                            self.rightDataSource[x].append(model)
                        }
                        x += 1
                    }
                    self.rightTableView.reloadData()
                    self.endRefresh()
                }
            }) { (error) in
                delog(error)
            }
        }else {
            //待付尾款 已支付 已完成
            up["pageNo"] = leftPageIndex
            delog(up)
            
            Net.share.getRequest(urlString: orderReturnsList_61_joggle, params: up, success: { (datas) in
                let json = JSON(datas)
                SVPHide()
                delog(json)
                if json["code"].int == 1 {
                    
                    if self.rightPageIndex == 1 {
                        self.rightDataSource.removeAll()
                    }
                    self.rightMax = json["data"]["totalPage"].int!
                    var x = 0
                    for (_, subJson):(String, JSON) in json["data"]["orderReturns"] {
                        
                        self.rightDataSource.append([NewGoodsOrderListModel]())
                        for (_, subJson2):(String, JSON) in subJson["orderMain"]["orderGoodChilds"] {
                            
                            //防止串值
                            let model = NewGoodsOrderListModel()
                            model.type = state
                            
                            model.id = subJson["id"].string!
                            model.createDate = subJson["createDate"].string!
                            model.handingSchedule = subJson["handingSchedule"].string!
                            model.returnsStatus = subJson["returnsStatus"].string!
                            
                            model.productTotal = subJson["orderMain"]["productTotal"].float!
                            model.pickType = subJson["orderMain"]["pickType"].string!

                            model.list.goodId = subJson2["goodId"].string!
                            model.list.goodName = subJson2["goodName"].string!
                            model.list.goodChildName = subJson2["goodChildName"].string!
                            model.list.thumbnail = subJson2["thumbnail"].string!
                            model.list.num = subJson2["num"].int!
                            model.list.goodPrice = subJson2["goodPrice"].float!
                            self.rightDataSource[x].append(model)
                        }
                        x += 1
                    }
                    self.rightTableView.reloadData()
                    self.endRefresh()
                }
            }) { (error) in
                delog(error)
            }
        }
    }
    
    func buildData(_ state: Int) {
        
        var up = [:]
            as [String: Any]
        
        if Defaults.hasKey("SESSIONID") {
            up["mobileCode"] = Defaults["mobileCode"].stringValue
            up["SESSIONID"] = Defaults["SESSIONID"].stringValue
        }else {
            SVPwillShowAndHide("请登录后重新操作")
            let login = NewLoginLocationViewController.init(nibName: "NewLoginLocationViewController", bundle: nil)
            let loginVC = Wx_baseNaviViewController.init(rootViewController: login)
            self.present(loginVC, animated: true, completion: nil)
            return
        }
        
        SVPWillShow("加载中...")
        
            if state == 0 {
                //待支付
                delog(up)
                Net.share.getRequest(urlString: stayOrderList_42_joggle, params: up, success: { (datas) in
                    let json = JSON(datas)
                    SVPHide()
                    delog(json)
                    if json["code"].int == 1 {
                        
                        self.leftDataSource.removeAll()
                        var x = 0
                        for (_, subJson):(String, JSON) in json["data"]["stayOrderList"] {
                            
                            self.leftDataSource.append([NewMineOrderLIstModel]())
                            for (_, subJson2):(String, JSON) in subJson["orderProductChilds"] {
                                
                                //防止串值
                                let model = NewMineOrderLIstModel()
                                model.type = 0
                                model.id = subJson["id"].string!
                                model.productTotal = subJson["productTotal"].float!
                                
                                model.thumbnail = subJson2["thumbnail"].string!
                                model.productName = subJson2["productName"].string!
                                model.productChildName = subJson2["productChildName"].string!
                                model.reservationPrice = subJson2["reservationPrice"].float!
                                model.prepaidPrice = subJson2["prepaidPrice"].float!
                                model.isFree = subJson2["isFree"].string!
                                model.num = subJson2["num"].int!
                                model.discountReservation = subJson2["discountReservation"].float!
                                model.discountRetainage = subJson2["discountRetainage"].float!
                                self.leftDataSource[x].append(model)
                            }
                            x += 1
                        }
                        self.leftTableView.reloadData()
                        self.endRefresh()
                    }
                }) { (error) in
                    delog(error)
                    self.endRefresh()
                }
            }else if state == 1 || state == 3 || state == 4 {
                
                //待付尾款 已支付 已完成
                if state == 1 {
                    up["flag"] = state
                }else {
                    up["flag"] = state - 1
                }
                up["pageNo"] = leftPageIndex
                delog(up)
                
                Net.share.getRequest(urlString: productOrders_44_joggle, params: up, success: { (datas) in
                    let json = JSON(datas)
                    SVPHide()
                    delog(json)
                    if json["code"].int == 1 {
                        
                        if self.leftPageIndex == 1 {
                            self.leftDataSource.removeAll()
                        }
                        self.leftMax = json["data"]["totalPage"].int!
                        var x = 0
                        for (_, subJson):(String, JSON) in json["data"]["productOrders"] {
                            
                            self.leftDataSource.append([NewMineOrderLIstModel]())
                            let model = NewMineOrderLIstModel()
                            model.type = state
                            model.id = subJson["id"].string!
                            model.orderNo = subJson["orderNo"].string!
                            model.productName = subJson["productName"].string!
                            model.productChildName = subJson["productChildName"].string!
                            model.reservationPrice = subJson["reservationPrice"].float!
                            model.prepaidPrice = subJson["prepaidPrice"].float!
                            model.residualPrice = subJson["residualPrice"].float!
                            model.num = subJson["num"].int!
                            model.discountReservation = subJson["discountReservation"].float!
                            model.isFree = subJson["isFree"].string!
                            model.discountRetainage = subJson["discountRetainage"].float!
                            model.payStatus = subJson["payStatus"].string!
                            model.orderStatus = subJson["orderStatus"].string!
                            model.thumbnail = subJson["thumbnail"].string!
                            if state != 1 {
                                if state != 4 {
                                    model.operationDate = subJson["operationDate"].string!
                                }
                                model.projectName = subJson["projectName"].string!
                            }
                            for (_, subJson2):(String, JSON) in subJson["doctors"]{
                                let doctor = NewMineOrderLIstModelDoctor()
                                doctor.bespoke = subJson2["bespoke"].int!
                                doctor.cases = subJson2["cases"].int!
                                doctor.currentPosition = subJson2["currentPosition"].string!
                                doctor.doctorName = subJson2["doctorName"].string!
                                doctor.doctorPrensent = subJson2["doctorPrensent"].string!
                                doctor.doctorTime = subJson2["doctorTime"].string!
                                doctor.education = subJson2["education"].string!
                                doctor.headImage = subJson2["headImage"].string!
                                doctor.id = subJson2["id"].string!
//                                doctor.remarks = subJson2["remarks"].string!
                                doctor.sex = subJson2["sex"].string!
                                doctor.updateDate = subJson2["updateDate"].string!
                                model.doctors.append(doctor)
                            }
                            self.leftDataSource[x].append(model)
                            x += 1
                        }
                        self.leftTableView.reloadData()
                        self.endRefresh()
                    }
                }) { (error) in
                    delog(error)
                }
            }else if state == 5 {
                //退款
                up["pageNo"] = leftPageIndex
                delog(up)
                Net.share.getRequest(urlString: getRefundOrders_51_joggle, params: up, success: { (datas) in
                    let json = JSON(datas)
                    SVPHide()
                    delog(json)
                    if json["code"].int == 1 {
                        
                        if self.leftPageIndex == 1 {
                            self.leftDataSource.removeAll()
                        }
                        self.leftMax = json["data"]["totalPage"].int!
                        var x = 0
                        for (_, subJson):(String, JSON) in json["data"]["refundOrders"] {
                            
                            self.leftDataSource.append([NewMineOrderLIstModel]())
                            
                            //防止串值
                            let model = NewMineOrderLIstModel()
                            model.type = state
                            model.id = subJson["id"].string!
                            
                            model.createDate = subJson["createDate"].string!
                            model.refundStatus = subJson["refundStatus"].string!
                            model.refundCost = subJson["refundCost"].float!
                            model.thumbnail = subJson["thumbnail"].string!
                            model.productName = subJson["productName"].string!
                            model.productChildName = subJson["productChildName"].string!
                            model.productId = subJson["productId"].string!
                            model.num = subJson["num"].int!
                            self.leftDataSource[x].append(model)
                            x += 1
                        }
                        self.leftTableView.reloadData()
                        self.endRefresh()
                    }
                }) { (error) in
                    delog(error)
                    self.endRefresh()
                }
            }
        }

    
    //停止刷新
    func endRefresh() {
        
        leftTableView.mj_header.endRefreshing()
        rightTableView.mj_header.endRefreshing()
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
            .topSpaceToView(view,(HEIGHT == 812 ? 88 : 64))?
            .leftSpaceToView(view,0)?
            .rightSpaceToView(view,0)?
            .bottomSpaceToView(view,0)
        
        scroller.addSubview(leftTopView)
        _ = leftTopView.sd_layout()?
            .topSpaceToView(scroller,0)?
            .leftSpaceToView(scroller,0)?
            .widthIs(WIDTH)?
            .heightIs(49)
        
        leftTopView.btnArray = ["待付款","待付尾款","已支付","已完成","退款"]
        leftTopView.scrollerViewColor = getColorWithNotAlphe(0xF1931A)
        leftTopView.scrollerViewHeight = 3.0
        leftTopView.btnColor = darkText
        if leftState > 3 {
            leftTopView.currentBtn = leftState - 1
        }else {
            leftTopView.currentBtn = leftState
        }
        leftTopView.buildUI()
        weak var weakSelf = self
        leftTopView.callBackBlock { (type) in
            var index = weakSelf!.leftTopView.btnArray.index(of: type)
            if index! > 1 {
                index! += 1
            }
            weakSelf!.leftState = index!
            weakSelf!.buildData(weakSelf!.leftState)
        }
        
        
        leftTableView.delegate = self
        leftTableView.dataSource = self
        leftTableView.emptyDataSetSource = self
        leftTableView.emptyDataSetDelegate = self
        leftTableView.tableFooterView = UIView.init()
        leftTableView.separatorStyle = .none
        leftTableView.register(UINib.init(nibName: "NewMeOrderListTabCell", bundle: nil), forCellReuseIdentifier: "NewMeOrderListTabCell")
        leftTableView.register(UINib.init(nibName: "NewMeOrderControllerTabCell", bundle: nil), forCellReuseIdentifier: "NewMeOrderControllerTabCell")
        leftTableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            weakSelf?.leftPageIndex = 1
            if weakSelf!.leftState == -1 {
                weakSelf!.leftState = 0
            }
            weakSelf?.buildData(weakSelf!.leftState)
        })
        
        scroller.addSubview(leftTableView)
        _ = leftTableView.sd_layout()?
            .topSpaceToView(leftTopView,0)?
            .leftSpaceToView(scroller,0)?
            .widthIs(WIDTH)?
            .bottomSpaceToView(scroller,0)
        
        
        
        scroller.addSubview(rightTopView)
        _ = rightTopView.sd_layout()?
            .topSpaceToView(scroller,0)?
            .leftSpaceToView(leftTopView,0)?
            .widthIs(WIDTH)?
            .heightIs(49)
        
        rightTopView.btnArray = ["待付款","待发货","已支付","已完成","退货"]
        rightTopView.scrollerViewColor = getColorWithNotAlphe(0xF1931A)
        rightTopView.scrollerViewHeight = 3.0
        rightTopView.btnColor = darkText
        rightTopView.currentBtn = rightState
        rightTopView.buildUI()
        rightTopView.callBackBlock { (type) in
            let index = weakSelf!.rightTopView.btnArray.index(of: type)
            //因为这里没有外部直接入口 所以不需要判断
            weakSelf!.rightState = index!
            weakSelf!.buildGoodsData(weakSelf!.rightState)
        }
        
        
        rightTableView.delegate = self
        rightTableView.dataSource = self
        rightTableView.emptyDataSetSource = self
        rightTableView.emptyDataSetDelegate = self
        rightTableView.tableFooterView = UIView.init()
        rightTableView.separatorStyle = .none
        rightTableView.register(UINib.init(nibName: "NewMeOrderListTabCell", bundle: nil), forCellReuseIdentifier: "NewMeOrderListTabCell")
        rightTableView.register(UINib.init(nibName: "NewMeOrderControllerTabCell", bundle: nil), forCellReuseIdentifier: "NewMeOrderControllerTabCell")
        rightTableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            weakSelf?.rightPageIndex = 1
            if weakSelf!.rightState == -1 {
                weakSelf!.rightState = 0
            }
            weakSelf?.buildGoodsData(weakSelf!.rightState)
        })
        scroller.addSubview(rightTableView)
        _ = rightTableView.sd_layout()?
            .topSpaceToView(rightTopView,0)?
            .leftSpaceToView(leftTableView,0)?
            .widthIs(WIDTH)?
            .bottomSpaceToView(scroller,0)
    }
    
    // MARK: - 导航栏
    let project = UIButton()
    let goods = UIButton()
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
        goods.setTitleColor(darkText, for: .normal)
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
        
        let back = UIButton()
        back.setImage(UIImage(named:"02_back"), for: .normal)
        back.addTarget(self, action: #selector(pop), for: .touchUpInside)
        back.frame = CGRect.init(x: 0, y: (HEIGHT == 812 ? 44 : 20), width: 44, height: 44)
        naviView.addSubview(back)
        
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
        default:
            break
        }
    }
    
    // location 0项目  1商品 2特权商品
    fileprivate func colorViewStartMove(_ location: Int) {
        
        currentPage = location
        if location == 0 {
            
            sizes = getSizeOnLabel(project.titleLabel!)
            
            project.setTitleColor(tabbarColor, for: .normal)
            goods.setTitleColor(darkText, for: .normal)
            
            UIView.animate(withDuration: 0.3, animations: {
                var frame = self.colorView.frame
                frame.size.width = self.sizes.width
                frame.origin.x = self.project.titleLabel!.origin.x + self.project.origin.x
                self.colorView.frame = frame
            })
        }else if location == 1 {
            
            sizes = getSizeOnLabel(goods.titleLabel!)
            
            project.setTitleColor(darkText, for: .normal)
            goods.setTitleColor(tabbarColor, for: .normal)
            
            UIView.animate(withDuration: 0.3, animations: {
                
                var frame = self.colorView.frame
                frame.size.width = self.sizes.width
                frame.origin.x = self.goods.titleLabel!.origin.x + self.goods.origin.x
                self.colorView.frame = frame
            })
        }
    }
}

// MARK: - UIScrollViewDelegate
extension NewMeOrderViewController : UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if scrollView == scroller {
            
            if scrollView.contentOffset.x == 0 {
                colorViewStartMove(0)
            } else if scrollView.contentOffset.x == scrollView.frame.size.width {
                colorViewStartMove(1)
            }
        }
    }
}

// MARK: - UITableViewDelegate
extension NewMeOrderViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if tableView == leftTableView {
            let detail = NewMeDetailOrderViewController.init(nibName: "NewMeDetailOrderViewController", bundle: nil)
            detail.type = leftDataSource[indexPath.section][0].type
            detail.id = leftDataSource[indexPath.section][0].id
            navigationController?.pushViewController(detail, animated: true)
        }else {
            let detail = NewGoodsOrderDetailViewController.init(nibName: "NewGoodsOrderDetailViewController", bundle: nil)
            detail.type = rightDataSource[indexPath.section][0].type
            detail.id = rightDataSource[indexPath.section][0].id
            navigationController?.pushViewController(detail, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView == leftTableView {
            if indexPath.row == leftDataSource[indexPath.section].count {
                return 54
            }
        }else {
            if indexPath.row == rightDataSource[indexPath.section].count {
                return 54
            }
        }
        return 110
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == leftTableView {
            
            if indexPath.section >= leftDataSource.count - 1 {
                if leftPageIndex < leftMax {
                    leftPageIndex += 1
                    buildData(rightState)
                }
            }
            if indexPath.row == leftDataSource[indexPath.section].count {
                //如果是最后一项（带按钮的结算项）
                let cell:NewMeOrderControllerTabCell? = tableView.dequeueReusableCell(withIdentifier: "NewMeOrderControllerTabCell") as? NewMeOrderControllerTabCell
                cell?.selectionStyle = .none
                cell?.model = leftDataSource[indexPath.section][0]
                return cell!
            }else {
                //一般cell
                let cell:NewMeOrderListTabCell? = tableView.dequeueReusableCell(withIdentifier: "NewMeOrderListTabCell") as? NewMeOrderListTabCell
                cell?.selectionStyle = .none
                cell?.model = leftDataSource[indexPath.section][indexPath.row]
                return cell!
            }
        }else {
            
            if indexPath.section >= rightDataSource.count - 1 {
                if rightPageIndex < rightMax {
                    rightPageIndex += 1
                    buildGoodsData(leftState)
                }
            }
            if indexPath.row == rightDataSource[indexPath.section].count {
                //如果是最后一项（带按钮的结算项）
                let cell:NewMeOrderControllerTabCell? = tableView.dequeueReusableCell(withIdentifier: "NewMeOrderControllerTabCell") as? NewMeOrderControllerTabCell
                cell?.selectionStyle = .none
                cell?.goodsListModel = rightDataSource[indexPath.section][0]
                return cell!
            }else {
                //一般cell
                let cell:NewMeOrderListTabCell? = tableView.dequeueReusableCell(withIdentifier: "NewMeOrderListTabCell") as? NewMeOrderListTabCell
                cell?.selectionStyle = .none
                cell?.goodsListModel = rightDataSource[indexPath.section][indexPath.row]
                return cell!
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension NewMeOrderViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == leftTableView {
            return leftDataSource.count
        }else {
            return rightDataSource.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == leftTableView {
            return leftDataSource[section].count + 1
        }else {
            return rightDataSource[section].count + 1
        }
    }
}

// MARK: -
extension NewMeOrderViewController: DZNEmptyDataSetSource,DZNEmptyDataSetDelegate {
    
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
