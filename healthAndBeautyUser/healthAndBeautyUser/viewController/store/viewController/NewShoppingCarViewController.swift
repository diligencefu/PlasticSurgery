//
//  NewShoppingCarViewController.swift
//  healthAndBeautyUser
//
//  Created by 丿番茄 on 2017/10/30.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON
import DeviceKit
import DZNEmptyDataSet

class NewShoppingCarViewController: Wx_baseViewController {
    
    @IBOutlet weak var alphaView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var projectBtn: UIButton!
    @IBOutlet weak var goodsBtn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var controller: UIButton!
    
    var projectDateSource : [NewStoreShopCarModel] = []
    var productDateSource : [NewStoreShopCarModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createNaviController(title: "购物车", leftBtn: buildLeftBtn(), rightBtn: nil)
        
        buildUI()
        buildData()
    }
    
    private func buildUI() {
        
        if HEIGHT == 812 {
            
            _ = tableView.sd_resetLayout().topSpaceToView(naviView,0)
        }
        
        tableView.tableFooterView = UIView.init()
        tableView.separatorStyle = .none
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        
        tableView.register(UINib.init(nibName: "NewShoppingCarTabCell", bundle: nil), forCellReuseIdentifier: "NewShoppingCarTabCell")
        tableView.register(NewStoreShopCarHeadView.self, forHeaderFooterViewReuseIdentifier: "NewStoreShopCarHeadView")
        
        //层级管理
        view.bringSubview(toFront: alphaView)
        view.bringSubview(toFront: bottomView)
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(hideBottomView))
        alphaView.addGestureRecognizer(tap)
        
        projectBtn.layer.cornerRadius = 5.0
        goodsBtn.layer.cornerRadius = 5.0
    }
    
    private func buildData() {
        
        var up : [String: Any] = [:]
        
        if Defaults.hasKey("SESSIONID") {
            up["mobileCode"] = Defaults["mobileCode"].stringValue
            up["SESSIONID"] = Defaults["SESSIONID"].stringValue
        }else {
            SVPwillShowAndHide("请登录后重新操作")
            nowGotoLogin()
            return
        }
        
        SVPWillShow("载入中...")
        delog(up)
        
        Net.share.getRequest(urlString: shopCarList_17_joggle, params: up,success: { (data) in
            
            let json = JSON(data)
            SVPHide()
            delog(json)
            
            if json["code"].int == 1 {
                self.projectDateSource.removeAll()
                self.productDateSource.removeAll()
                for (_, subJson):(String, JSON) in json["data"]["shopCars"] {
                    
                    let model = NewStoreShopCarModel()
                    model.thumbnail = subJson["thumbnail"].string!
                    model.doctorName = subJson["doctorName"].string!
                    model.id = subJson["id"].string!
                    model.goodType = subJson["goodType"].string!
                    model.payPrice = subJson["payPrice"].float!
                    model.goodChildName = subJson["goodChildName"].string!
                    model.num = subJson["num"].int!
                    model.goodName = subJson["goodName"].string!
                    model.isDiscount = subJson["isDiscount"].string!
                    if model.goodType == "1" {
                        self.projectDateSource.append(model)
                    }else {
                        self.productDateSource.append(model)
                    }
                    self.tableView.reloadData()
                    self.rebuildBottomData()
                }
            }else {
                SVPwillShowAndHide("数据请求失败!")
            }
        }) { (error) in
            SVPwillShowAndHide("网络连接错误!")
        }
    }
    //
    public func rebuildBottomData() {
        
        var _price = Float()
        if projectDateSource.count != 0 {
            for index in projectDateSource {
                if index.isSelect {
                    _price += index.payPrice * Float(index.num)
                }
            }
        }
        if productDateSource.count != 0 {
            for index in productDateSource {
                if index.isSelect {
                    _price += index.payPrice * Float(index.num)
                }
            }
        }
        tableView.reloadData()
        
        let attributeString = NSMutableAttributedString(string:"合计：￥\(_price)")
        //设置字体颜色
        attributeString.addAttribute(NSForegroundColorAttributeName,
                                     value: getColorWithNotAlphe(0x565656),
                                     range: NSMakeRange(0,
                                                        "合计：".count))
        attributeString.addAttribute(NSForegroundColorAttributeName,
                                     value: tabbarColor,
                                     range: NSMakeRange("合计：".count,
                                                        "￥\(_price)".count))
        price.attributedText = attributeString
    }
    
    //结算
    @IBAction func toPay(_ sender: UIButton) {
        
        //这里的逻辑是必须
        var isSelectProject = Bool()
        var isSelectProduct = Bool()
        
        if projectDateSource.count != 0 {
            for index in projectDateSource {
                if index.isSelect {
                    isSelectProject = true
                }
            }
        }
        if productDateSource.count != 0 {
            for index in productDateSource {
                if index.isSelect {
                    isSelectProduct = true
                }
            }
        }
        if isSelectProduct && isSelectProject {
            selectPayFunction()
            return
        }
        if !isSelectProduct && !isSelectProject {
            SVPwillShowAndHide("请至少选中一项项目或产品再结算")
            return
        }
        let require = NewRequireOrderViewController.init(nibName: "NewRequireOrderViewController", bundle: nil)
        if isSelectProject {
            require.isProject = true
            require.id = returnTrue(true)
        }else {
            require.id = returnTrue(false)
        }
        require.flag = "1"
        navigationController?.pushViewController(require, animated: true)
    }
    
    //显示底部分开结算按钮
    private func selectPayFunction() {
        
        UIView.animate(withDuration: 0.25) {
            self.alphaView.alpha = 0.35
            var frame = self.bottomView.frame
            frame.origin.y = HEIGHT - 180
            self.bottomView.frame = frame
        }
    }
    
    //隐藏底部分开结算按钮
    @objc private func hideBottomView() {
        UIView.animate(withDuration: 0.25) {
            self.alphaView.alpha = 0
            var frame = self.bottomView.frame
            frame.origin.y = HEIGHT
            self.bottomView.frame = frame
        }
    }

    //选择支付方式
    @IBAction func payWhat(_ sender: UIButton) {
        
        hideBottomView()

        let require = NewRequireOrderViewController.init(nibName: "NewRequireOrderViewController", bundle: nil)
        switch sender.tag {
        case 300:
            require.isProject = true
            require.id = returnTrue(true)
            break
        case 301:
            require.id = returnTrue(false)
            break
        default:
            break
        }
        require.flag = "1"
        navigationController?.pushViewController(require, animated: true)
    }
    
    private func returnTrue(_ isProject: Bool) -> [String] {
        
        var strArr = [String]()
        
        if isProject {
            
            if projectDateSource.count != 0 {
                for index in projectDateSource {
                    if index.isSelect {
                        strArr.append(index.id)
                    }
                }
            }
        }else {
            
            if productDateSource.count != 0 {
                for index in productDateSource {
                    if index.isSelect {
                        strArr.append(index.id)
                    }
                }
            }
        }
        delog(strArr)
        return strArr
    }
}

// MARK: - UITableViewDelegate
extension NewShoppingCarViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 165
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:NewShoppingCarTabCell? = tableView.dequeueReusableCell(withIdentifier: "NewShoppingCarTabCell") as? NewShoppingCarTabCell
        cell?.selectionStyle = .none
        if projectDateSource.count != 0 && indexPath.section == 0  {
            cell?.model = projectDateSource[indexPath.row]
            cell?.dataSource = projectDateSource
        }else {
            cell?.model = productDateSource[indexPath.row]
            cell?.dataSource = productDateSource
        }
        cell?.indexPath = indexPath
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var cell:NewStoreShopCarHeadView? = tableView.dequeueReusableHeaderFooterView(withIdentifier: "NewStoreShopCarHeadView") as? NewStoreShopCarHeadView
        if nil == cell {
            cell! = NewStoreShopCarHeadView.init(reuseIdentifier: "NewStoreShopCarHeadView")
        }
        cell?.section = section
        if projectDateSource.count != 0 && section == 0  {
            cell?.projectDateSource = projectDateSource
            cell?.isProject = true
        }else {
            cell?.productDateSource = productDateSource
            cell?.isProject = false
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        delog("购物车开启删除功能")
        if editingStyle == .delete {
            delog("删除\(indexPath)")
            deleteRow(indexPath)
        }
    }
    
    //删除数据
    private func deleteRow(_ indexPath: IndexPath) {
        
        var model = NewStoreShopCarModel()
        if projectDateSource.count != 0 && indexPath.section == 0 {
            model = projectDateSource[indexPath.row]
        }else{
            model = productDateSource[indexPath.row]
        }
        let up = ["SESSIONID":Defaults["SESSIONID"].stringValue,
                  "mobileCode":Defaults["mobileCode"].stringValue,
                  "id":model.id]
            as [String:Any]
        
        SVPWillShow("载入中...")
        delog(up)
        Net.share.postRequest(urlString: delShopCar_18_joggle, params: up,success: { (data) in
            
            let json = JSON(data)
            SVPHide()
            delog(json)
            if json["code"].int == 1 {
                
                if self.projectDateSource.count != 0 && indexPath.section == 0 {
                    self.projectDateSource.remove(at: indexPath.row)
                    if self.projectDateSource.count == 0 {
                        self.tableView.deleteSections(NSIndexSet(index: indexPath.section) as IndexSet, with: .right)
                    }else {
                        self.tableView.deleteRows(at: [indexPath], with: .right)
                    }
                }else{
                    self.productDateSource.remove(at: indexPath.row)
                    if self.productDateSource.count == 0 {
                        self.tableView.deleteSections(NSIndexSet(index: indexPath.section) as IndexSet, with: .right)
                    }else {
                        self.tableView.deleteRows(at: [indexPath], with: .right)
                    }
                }
                self.rebuildBottomData()
            }else {
                SVPwillShowAndHide("数据请求失败!")
            }
        }) { (error) in
            SVPwillShowAndHide("网络连接错误!")
        }
    }
}

// MARK: - UITableViewDataSource
extension NewShoppingCarViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var count : Int = 0
        if projectDateSource.count != 0 {
            count += 1
        }
        if productDateSource.count != 0 {
            count += 1
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //这个只需要判断有没有第一个即可
        if projectDateSource.count != 0 && section == 0 {
            
            //如果是项目栏
            //那么就返回每一个cell的数据
            return projectDateSource.count
        }
        return productDateSource.count
    }
}

// MARK: -
extension NewShoppingCarViewController: DZNEmptyDataSetSource,DZNEmptyDataSetDelegate {
    
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
