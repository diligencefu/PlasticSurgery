//
//  NewPostLocationViewController.swift
//  healthAndBeautyUser
//
//  Created by 丿番茄 on 2017/11/1.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON
import DZNEmptyDataSet

var NewPostLocationViewControllerLocationModel = NewStoreLocationModel()
var loadMineSelectModel = Bool()

class NewPostLocationViewController: Wx_baseViewController {

    @IBOutlet weak var add: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource = [NewStoreLocationModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        createNaviController(title: "收货地址", leftBtn: buildLeftBtn(), rightBtn: nil)
        buildUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        buildData()
    }
    
    //
    private func buildUI() {
        
        tableView.tableFooterView = UIView.init()
        tableView.separatorStyle = .none
        
        tableView.register(UINib.init(nibName: "NewLocationListTabCell", bundle: nil), forCellReuseIdentifier: "NewLocationListTabCell")
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        
        add.layer.cornerRadius = 5.0
    }
    
    public func buildData() {
        
        let up = ["SESSIONID":Defaults["SESSIONID"].stringValue,
                  "mobileCode":Defaults["mobileCode"].stringValue]
            as [String:Any]
        
        SVPWillShow("载入中...")
        delog(up)
        
        Net.share.getRequest(urlString: deliveryAddressList_23_joggle, params: up,success: { (data) in
            
            let json = JSON(data)
            SVPHide()
            delog(json)
            
            if json["code"].int == 1 {
                
                self.dataSource.removeAll()
                for (_, subJson):(String, JSON) in json["data"]["deliveryAddressList"] {
                    
                    let model = NewStoreLocationModel()
                    model.id = subJson["id"].string!
                    model.realName = subJson["realName"].string!
                    model.tel = subJson["tel"].string!
                    model.area = subJson["area"].string!
                    model.street = subJson["street"].string!
                    model.isDefaultAddress = subJson["isDefaultAddress"].string!
                    self.dataSource.append(model)
                }
                self.tableView.reloadData()
                if self.dataSource.count == 10 {
                    self.add.backgroundColor = lineColor
                    self.add.setTitle("收货地址已达到上限", for: .normal)
                    self.add.isUserInteractionEnabled = false
                }else {
                    self.add.backgroundColor = tabbarColor
                    self.add.setTitle("新增收货地址", for: .normal)
                    self.add.isUserInteractionEnabled = true
                }
            }else {
                SVPwillShowAndHide("数据请求失败!")
            }
        }) { (error) in
            SVPwillShowAndHide("网络连接错误!")
        }
    }
    
    @IBAction func addLocation(_ sender: UIButton) {
        
        let add = NewAddLocationViewController.init(nibName: "NewAddLocationViewController", bundle: nil)
        add.isAdd = true
        self.navigationController?.pushViewController(add, animated: true)
    }
    
    override func alertController() {
        
        let up = ["SESSIONID": Defaults["SESSIONID"].stringValue,
                  "mobileCode": Defaults["mobileCode"].stringValue,
                  "id": NewLocationListTabCellDeleteId]
            as [String : Any]
        
        SVPWillShow("载入中...")
        delog(up)
        
        Net.share.postRequest(urlString: daleteDeliveryAddress_24_joggle, params: up, success: { (datas) in
            let json = JSON(datas)
            delog(json)
            SVPHide()
            if json["code"].int == 1 {
                
                self.buildData()
            }else {
                SVPwillShowAndHide(json["message"].string!)
            }
        }) { (error) in
            delog(error)
            SVPwillShowAndHide("请检查您的网路")
        }
    }
    
    fileprivate func reBuildData(_ indexPath: IndexPath) {
        
        for index in 0..<dataSource.count {
            dataSource[index].isDefaultAddress = "2"
            if index == indexPath.row {
                dataSource[index].isDefaultAddress = "1"
            }
        }
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate
extension NewPostLocationViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NewPostLocationViewControllerLocationModel = dataSource[indexPath.row]
        loadMineSelectModel = true
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 174
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell:NewLocationListTabCell? = tableView.dequeueReusableCell(withIdentifier: "NewLocationListTabCell") as? NewLocationListTabCell
        cell?.selectionStyle = .none
        cell?.model = dataSource[indexPath.row]
        weak var weakSelf = self
        cell?.callBackBlock {
            weakSelf?.reBuildData(indexPath)
        }
        return cell!
    }
}

// MARK: - UITableViewDataSource
extension NewPostLocationViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataSource.count
    }
}

// MARK: -
extension NewPostLocationViewController: DZNEmptyDataSetSource,DZNEmptyDataSetDelegate {
    
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
