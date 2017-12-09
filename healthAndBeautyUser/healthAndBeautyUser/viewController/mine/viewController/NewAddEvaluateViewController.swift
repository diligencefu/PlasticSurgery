//
//  NewAddEvaluateViewController.swift
//  healthAndBeautyUser
//
//  Created by 丿番茄 on 2017/11/11.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewAddEvaluateViewController: Wx_baseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var controller: UIButton!
    
    var dataSource = [NewGoodsDetailModel]()

    var source = [IndexPath]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createNaviController(title: "撰写评价", leftBtn: buildLeftBtn(), rightBtn: nil)
        
        tableView.tableFooterView = UIView.init()
        tableView.separatorStyle = .none
        
        tableView.register(UINib.init(nibName: "NewAddEvaluateTabCell", bundle: nil), forCellReuseIdentifier: "NewAddEvaluateTabCell")
        tableView.register(UINib.init(nibName: "NewOrderDetailOtherTabCell", bundle: nil), forCellReuseIdentifier: "NewOrderDetailOtherTabCell")
        controller.layer.cornerRadius = 5.0
        
        tableView.reloadData()
    }
    
    @IBAction func click(_ sender: UIButton) {
        
        var up = ["mobileCode":Defaults["mobileCode"].stringValue,
                  "SESSIONID":Defaults["SESSIONID"].stringValue]
            as [String: String]
        var isHave = false
        var indexGood = 0
        
        for index in source {
            
            let cell = tableView.cellForRow(at: index) as! NewAddEvaluateTabCell!
            if cell?.tv.text != "撰写评论" {
                up["goodComments[\(indexGood)].goodItemId"] = cell?.model?.goodID
                up["goodComments[\(indexGood)].orderId"] = cell?.model?.id
                up["goodComments[\(indexGood)].content"] = cell?.tv.text!
                isHave = !isHave
                indexGood += 1
            }
        }
        if !isHave {
            SVPwillShowAndHide("您还未对任何商品评价")
            return
        }
        
        delog(up)
        SVPWillShow("载入中...")

        Net.share.postRequest(urlString: comment_59_joggle, params: up, success: { (datas) in
            let json = JSON(datas)
            delog(json)
            SVPHide()
            if json["code"].int == 1 {
                SVPwillSuccessShowAndHide("添加评论成功")
                self.navigationController?.popViewController(animated: true)
            }else {
                SVPwillShowAndHide(json["message"].string!)
            }
        }) { (error) in
            delog(error)
        }
    }
}

// MARK: - UITableViewDelegate
extension NewAddEvaluateViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 44
        }else {
            return 210
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell:NewOrderDetailOtherTabCell? = tableView.dequeueReusableCell(withIdentifier: "NewOrderDetailOtherTabCell") as? NewOrderDetailOtherTabCell
            cell?.selectionStyle = .none
            let model = NewOrderDetailOtherTabCellModel()
            if indexPath.row == 0 {
                model.type = "订单编号:"
                model.detail = self.dataSource[0].orderNo
            }else {
                model.type = "下单时间:"
                model.detail = self.dataSource[0].createDate
            }
            cell?.model = model
            return cell!
        }else {
            
            //一般cell
            let cell:NewAddEvaluateTabCell? = tableView.dequeueReusableCell(withIdentifier: "NewAddEvaluateTabCell") as? NewAddEvaluateTabCell
            cell?.selectionStyle = .none
            cell?.model = dataSource[indexPath.row]
            if indexPath.row != source.last?.row {
                source.append(indexPath)
            }
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let foot = UIView()
        foot.backgroundColor = lineColor
        return foot
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section <= 0 {
            return 10
        }else {
            return 0
        }
    }
}

// MARK: - UITableViewDataSource
extension NewAddEvaluateViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 2
        }
        return dataSource.count
    }
}
