//
//  NewMain_freeViewController.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/21.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import MJRefresh
import SwiftyJSON

class NewMain_freeViewController: Wx_baseViewController {
    
    var dataArr = NSMutableArray()
    var pageNo = 1
    
    var mainModel = FYHSowMainADModel()
    
    lazy var tableView : UITableView = {
        let table = UITableView()
        table.backgroundColor = backGroundColor
        table.delegate = self
        table.dataSource = self
        table.tableFooterView = UIView.init()
        table.separatorStyle = .none
        
//        table.register(NewMain_freeTableViewCell.self, forCellReuseIdentifier: "NewMain_freeTableViewCell")
        table.register(NewStoreListTabCell.self, forCellReuseIdentifier: "NewStoreListTabCell")
        table.register(NewMainBannerCell.self, forCellReuseIdentifier: "NewMainBannerCell")
        table.register(UINib.init(nibName: "FYHMainShowADCell", bundle: nil), forCellReuseIdentifier: "FYHMainShowADCell")
        
        return table
    }()
    
    var dateSource : [NSString] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createNaviController(title: "免费整形", leftBtn: buildLeftBtn(), rightBtn: nil)
        buildUI()
        requestData()
    }
    
    
    func requestData() {
        
        let up = ["pageNo":String(pageNo),
                  "isFree":"1",
                  ]
            as [String: Any]
        
        SVPWillControllerShow("载入中...")
        delog(up)
        
        Net.share.getRequest(urlString: productList_12_joggle, params: up, success: { (datas) in
            
            let json = JSON(datas)
            delog(json)
            if json["code"].int == 1 {
                
                self.pageNo = json["data"]["totalPage"].int!
                if self.pageNo == 1 {
                    self.dataArr.removeAllObjects()
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
                    self.dataArr.add(model)
                }
//                self.dataArr.add(self.mainModel)
                self.tableView.reloadData()
                self.insertADCells()
            }
        }) { (error) in
            delog(error)
        }
        
    }
    
    
    
    var headImage = UIImageView()
    
    private func buildUI() {
        
        view.backgroundColor = backGroundColor
        
        view.addSubview(tableView)
        _ = tableView.sd_layout()?
            .topSpaceToView(naviView,0)?
            .leftSpaceToView(view,0)?
            .rightSpaceToView(view,0)?
            .bottomSpaceToView(view,0)
        
        headImage = UIImageView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: GET_SIZE * 520))
        headImage.contentMode = .scaleAspectFit
        headImage.isUserInteractionEnabled = true
        let tapGes1 = UITapGestureRecognizer.init(target: self, action: #selector(openLink(tap:)))
        tapGes1.numberOfTouchesRequired = 1
        headImage.addGestureRecognizer(tapGes1)
        headImage.kf.setImage(with: StringToUTF_8InUrl(str:mainModel.infoBanner.imgUrl), placeholder: UIImage.init(named: "02_banner_link_default"), options: nil, progressBlock: nil, completionHandler: nil)
        self.tableView.tableHeaderView = headImage
    }
    
    @objc func openLink(tap:UITapGestureRecognizer) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(StringToUTF_8InUrl(str:mainModel.infoBanner.linkUrl), options: [:],
                                      completionHandler: {
                                        (success) in
                                        if !success {
                                            setToast(str: "网址格式错误！")
                                        }
            })
        } else {
            // Fallback on earlier versions
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        buildData()
    }
    
    private func buildData() {
        for _ in 0..<10 {
            dateSource.append("null")
        }
        tableView.reloadData()
    }
    
    func insertADCells() {
        
//        let index = Int(arc4random() % UInt32(dataArr.count-1))
//        tableView.insertRows(at: [IndexPath.init(row: 0, section: 0)], with: .automatic)
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        deBugPrint(item: "要加入广告了啊？")
    }
    
}


// MARK: - UITableViewDelegate
extension NewMain_freeViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
//        let model = dataArr[indexPath.row] as! NewStoreProjectModel
        

        let model = dataArr[indexPath.row] as! NewStoreProjectModel
        let detail = NewStoresDetailViewController.init(nibName: "NewStoresDetailViewController", bundle: nil)
        detail.isProject = true
        detail.id = model.id
        navigationController?.pushViewController(detail, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.section == 0 {
//            return GET_SIZE * 520
//        }
        return GET_SIZE * 280
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        switch indexPath.section {
//        case 0:
//            var cell:NewMainBannerCell? = tableView.dequeueReusableCell(withIdentifier: "NewMainBannerCell") as? NewMainBannerCell
//            cell?.clipsToBounds = true
//            if nil == cell {
//                cell! = NewMainBannerCell.init(style: .default, reuseIdentifier: "NewMainBannerCell")
//            }
//            cell?.selectionStyle = .none
//            cell?.buildData()
//            return cell!
//        case 1:
////            var cell:NewMain_freeTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "NewMain_freeTableViewCell") as? NewMain_freeTableViewCell
////            if nil == cell {
////                cell! = NewMain_freeTableViewCell.init(style: .default, reuseIdentifier: "NewMain_freeTableViewCell")
////            }
////            cell?.selectionStyle = .none
////            cell?.buildModel()
////            return cell!
//
//
//        default :
//            return UITableViewCell()
//        }
        
        let model = dataArr[indexPath.row] as! NewStoreProjectModel
        var cell:NewStoreListTabCell? = tableView.dequeueReusableCell(withIdentifier: "NewStoreListTabCell") as? NewStoreListTabCell
        if nil == cell {
            cell! = NewStoreListTabCell.init(style: .default, reuseIdentifier: "NewStoreListTabCell")
        }
        cell?.selectionStyle = .none
        cell?.projectModel = model
        return cell!

    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        if section == 1 {
//            let header = Wx_scrollerBtnView()
//            header.frame = CGRect.init(x: 0, y: 0, width: WIDTH, height: 44)
//            header.isShowBottomView = false
//            header.scrollerViewColor = getColorWithNotAlphe(0xF1931A)
//            header.btnColor = UIColor.black
//            header.callBackBlock { (type) in
//                delog(type)
//            }
//            header.btnArray = ["全部项目","智能排序","筛选"]
//            header.buildUI()
//            return header
//        }
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
//            return 44
        }
        return 0
    }
}

// MARK: - UITableViewDataSource
extension NewMain_freeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == 0 {
//            return 1
//        }
        return dataArr.count
    }
}
