//
//  FYHOrderForIntegralViewController.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/25.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class FYHOrderForIntegralViewController: Base2ViewController {
    
    let topView = Wx_scrollerBtnView()
    
    lazy var tableView : UITableView = {
        let table = UITableView()
        table.backgroundColor = backGroundColor
        table.delegate = self
        table.dataSource = self
        table.tableFooterView = UIView()
//        table.separatorStyle = .none
        
        table.register(UINib.init(nibName: "FYHShowIntegralStateCell", bundle: nil), forCellReuseIdentifier: "FYHShowIntegralStateCell")
        
        return table
    }()
    
    var datas1 = NSMutableArray()
    var datas2 = NSMutableArray()
    var datas3 = NSMutableArray()
    var datas4 = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitleViewSectionStyle(titleStr: "积分订单")
        buildUI()
    }
    
    private func buildUI() {
        
        view.backgroundColor = backGroundColor
        
        view.addSubview(topView)
        _ = topView.sd_layout()?
            .topSpaceToView(self.view,CGFloat(navHeight))?
            .leftSpaceToView(view,0)?
            .widthIs(WIDTH)?
            .heightIs(GET_SIZE * 86)
        
        topView.btnArray = ["待付款","待发货","已发货","已完成"]
        topView.scrollerViewColor = getColorWithNotAlphe(0xF1931A)
        topView.scrollerViewHeight = 3.0
        topView.btnColor = UIColor.black
        topView.buildUI()
        topView.callBackBlock { (type) in
            self.buildData()
        }
        
        view.addSubview(tableView)
        _ = tableView.sd_layout()?
            .topSpaceToView(topView,0)?
            .leftSpaceToView(view,0)?
            .rightSpaceToView(view,0)?
            .bottomSpaceToView(view,0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        buildData()
    }
    
    private func buildData() {
        
        if !Defaults.hasKey("SESSIONID") {
            SVPwillShowAndHide("请登录后重新操作")
            let login = NewLoginLocationViewController.init(nibName: "NewLoginLocationViewController", bundle: nil)
            let loginVC = Wx_baseNaviViewController.init(rootViewController: login)
            self.present(loginVC, animated: true, completion: nil)
            return
        }
        
        buildDatas1111()
        tableView.reloadData()
    }
    
    
    //
    private func buildDatas1111() {
        
        let params = [
            "mobileCode":Defaults["mobileCode"].stringValue,
            "SESSIONID":Defaults["SESSIONID"].stringValue,
            "flag":topView.currentBtn+1
            ] as [String : Any]
        
        SVPWillShow("加载中...")
        NetWorkForIntegralOrderList(params: params) { (datas, flag) in
            
            if flag {
                if self.topView.currentBtn+1 == 1{
                    self.datas1.removeAllObjects()
                    self.datas1.addObjects(from: datas)
                }
                if self.topView.currentBtn+1 == 2{
                    self.datas2.removeAllObjects()
                    self.datas2.addObjects(from: datas)
                }
                if self.topView.currentBtn+1 == 3{
                    self.datas3.removeAllObjects()
                    self.datas3.addObjects(from: datas)
                }
                if self.topView.currentBtn+1 == 4{
                    self.datas4.removeAllObjects()
                    self.datas4.addObjects(from: datas)
                }
                self.tableView.reloadData()
            }
            SVPHide()
        }
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var model = FYHIntergralGoodsModel()
        
        if topView.currentBtn+1 == 4{
            
            model = datas4[indexPath.row] as! FYHIntergralGoodsModel
        }
        if topView.currentBtn+1 == 3{
            
            model = datas3[indexPath.row] as! FYHIntergralGoodsModel
        }
        if topView.currentBtn+1 == 2{
            
            model = datas2[indexPath.row] as! FYHIntergralGoodsModel
        }
        if topView.currentBtn+1 == 1{
            
            model = datas1[indexPath.row] as! FYHIntergralGoodsModel
        }

        let cell : FYHShowIntegralStateCell = tableView.dequeueReusableCell(withIdentifier: "FYHShowIntegralStateCell", for: indexPath) as! FYHShowIntegralStateCell
        cell.setValuesForFYHShowIntegralStateCell(model: model)
        cell.selectionStyle = .none
        return cell
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch topView.currentBtn {
        case 3:
            return datas4.count
        case 0:
            return datas1.count
        case 1:
            return datas2.count
        case 2:
            return datas3.count
        default:
            break
        }
        return 1
    }

}
