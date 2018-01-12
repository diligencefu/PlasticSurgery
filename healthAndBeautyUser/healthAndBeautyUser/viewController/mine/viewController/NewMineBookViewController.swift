//
//  NewMineBookViewController.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/18.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON
import MJRefresh
import DZNEmptyDataSet

class NewMineBookViewController: Wx_baseViewController {
    
    let topView = Wx_scrollerBtnView()
    var pageIndex : NSInteger = 1
    var maxPage : NSInteger = 0

    lazy var tableView : UITableView? = {
        let table = UITableView()
        table.backgroundColor = backGroundColor
        table.delegate = self
        table.dataSource = self
        table.emptyDataSetSource = self
        table.emptyDataSetDelegate = self
        table.tableFooterView = UIView.init()
        table.separatorStyle = .none
        
        table.register(UINib.init(nibName: "NewDiscountBookTabCell", bundle: nil), forCellReuseIdentifier: "NewDiscountBookTabCell")
        
        return table
    }()
    
    var dateSource : [NewMineBookModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createNaviController(title: "我的优惠券",
                             leftBtn: buildLeftBtn(),
                             rightBtn: buildRightBtnWithName("领券中心"))
        buildUI()
        buildData()
    }
    
    override func rightClick() {
        delog("领券中心")
        let center = NewMineBookAddViewController()
        navigationController?.pushViewController(center, animated: true)
    }
    
    private func buildUI() {
        
        view.backgroundColor = backGroundColor
        
        view.addSubview(topView)
        _ = topView.sd_layout()?
            .topSpaceToView(naviView,0)?
            .leftSpaceToView(view,0)?
            .widthIs(WIDTH)?
            .heightIs(GET_SIZE * 86)
        
        topView.btnArray = ["预约金优惠券","尾款优惠券"]
        topView.scrollerViewColor = getColorWithNotAlphe(0xF1931A)
        topView.scrollerViewHeight = 3.0
        topView.btnColor = UIColor.black
        topView.buildUI()
        weak var weakSelf = self
        topView.callBackBlock { (type) in
            weakSelf?.buildData()
        }
        
        view.addSubview(tableView!)
        _ = tableView!.sd_layout()?
            .topSpaceToView(topView,0)?
            .leftSpaceToView(view,0)?
            .rightSpaceToView(view,0)?
            .bottomSpaceToView(view,0)
        tableView?.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            weakSelf?.pageIndex = 1
            weakSelf?.buildData()
        })
    }
    
    fileprivate func buildData() {
        
        var up = ["pageNo": pageIndex,
                  "type": (topView.currentBtn == -1 || topView.currentBtn == 0) ? 1 : 2 ]
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
        
        SVPWillShow("载入中...")
        delog(up)
        
        Net.share.getRequest(urlString: userCoupons_41_joggle, params: up, success: { (datas) in
            let json = JSON(datas)
            delog(json)
            SVPHide()
            if json["code"].int == 1 {
                
                self.maxPage = json["data"]["totalPage"].int!
                if self.pageIndex == 1 {
                    self.dateSource.removeAll()
                }
                let data = json["data"]
                for (_, subJson):(String, JSON) in data["userCoupons"] {
                    let model = NewMineBookModel()
                    model.counponId = subJson["counponId"].string!
                    model.status = subJson["status"].string!
                    model.receiveNum = subJson["receiveNum"].int!
                    model.userNum = subJson["userNum"].int!
                    let coupon = subJson["coupon"]
                    model.couponName = coupon["couponName"].string!
                    model.counponAmount = coupon["counponAmount"].float!
                    model.counponStartDate = coupon["counponStartDate"].string!
                    model.couponEndDate = coupon["couponEndDate"].string!
                    model.counponKind = coupon["counponKind"].string!
                    model.counponUsingRange = coupon["counponUsingRange"].string!
                    
                    if coupon["projectNames"].string != nil {
                        model.projectNames = coupon["projectNames"].string!
                    }
                    model.counponExplain = coupon["counponExplain"].string!
                    model.meetPrice = coupon["meetPrice"].float!
                    self.dateSource.append(model)
                }
                self.tableView?.reloadData()
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

        tableView?.mj_header.endRefreshing()
    }
}

// MARK: - UITableViewDelegate
extension NewMineBookViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row >= dateSource.count - 3 {
            if self.pageIndex < self.maxPage {
                self.pageIndex += 1
                self.buildData()
            }
        }
        let cell : NewDiscountBookTabCell! = tableView.dequeueReusableCell(withIdentifier: "NewDiscountBookTabCell", for: indexPath) as! NewDiscountBookTabCell
        cell.selectionStyle = .none
        cell.model = dateSource[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDataSource
extension NewMineBookViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dateSource.count
    }
}

// MARK: -
extension NewMineBookViewController: DZNEmptyDataSetSource,DZNEmptyDataSetDelegate {
    
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
