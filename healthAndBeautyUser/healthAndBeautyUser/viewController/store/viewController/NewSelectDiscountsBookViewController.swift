//
//  NewSelectDiscountsBookViewController.swift
//  healthAndBeautyUser
//
//  Created by 丿番茄 on 2017/11/2.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewSelectDiscountsBookViewController: Wx_baseViewController {
    
    var isPayNow = Bool()
    
    //1.预约 2.尾款
    var type = String()
    
    //当前的模型
    var currentModel = NewStoreShopCarModel()
    //通过这个刷新前一个页面的dataSource
    var index = IndexPath()
    //当前数组
    var dataSource = [NewSelectBookListModel]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if type == "1" {
            createNaviController(title: "预约金优惠券", leftBtn: buildLeftBtn(), rightBtn: nil)
        }else {
            createNaviController(title: "尾款优惠券", leftBtn: buildLeftBtn(), rightBtn: nil)
        }
        buildUI()
        reBuildData()
    }
    
    private func buildUI() {
        
        if HEIGHT == 812 {
            _ = tableView.sd_resetLayout().topSpaceToView(naviView,0)
        }
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        
        tableView.register(UINib.init(nibName: "NewDiscountBookTabCell", bundle: nil), forCellReuseIdentifier: "NewDiscountBookTabCell")
        tableView.register(UINib.init(nibName: "NewDontSelectBookTabCell", bundle: nil), forCellReuseIdentifier: "NewDontSelectBookTabCell")
    }
    
    private func reBuildData() {
        
        dataSource.removeAll()
        
        for tmp in ((type == "1") ? selectAppointmentDataSource : selectFinalDataSource) {
            
            tmp.canUse = true
            tmp.state = "点击使用"
            dataSource.append(tmp)

            //判断类型
            if tmp.counponUsingRange == "1" {
                //全品类通用优惠券
            }else {
                if !(tmp.productIds.components(separatedBy: currentModel.id).count > 1) {
                    //不包含该商品
                    tmp.canUse = false
                    tmp.state = "项目分类不符合"
                    continue
                }
            }
            //判断金额
            if type == "1" {
//                预约金计算
                if !(currentModel.payPrice * Float((isPayNow ? currentModel.currentGoodsCount : currentModel.num)) >= tmp.meetPrice) {
                    //不可以使用
                    tmp.canUse = false
                    tmp.state = "没有达到使用条件"
                    continue
                }
            }else {
//                尾款计算
                if !(currentModel.retainage * Float((isPayNow ? currentModel.currentGoodsCount : currentModel.num)) >= tmp.meetPrice) {
                    //不可以使用
                    tmp.canUse = false
                    tmp.state = "没有达到使用条件"
                    continue
                }
            }
            //判断是否在有效期
            //当前日期时间戳
            let date = Date()
            let timeInterval:TimeInterval = date.timeIntervalSince1970
            let timeStamp = Int(timeInterval)
//            delog("当前时间的时间戳：\(timeStamp)")
            //将时间转换为时间
            let formate = DateFormatter()
            formate.dateFormat = "yyyy-MM-dd HH:mm:ss"
            var time = formate.date(from: tmp.counponStartDate)
            var dateStamp:TimeInterval = time!.timeIntervalSince1970
            let startTime:Int = Int(dateStamp)
            time = formate.date(from: tmp.couponEndDate)
            dateStamp = time!.timeIntervalSince1970
            let endTime:Int = Int(dateStamp)
            if !(timeStamp > startTime && timeStamp < endTime) {
                //不可以使用
                tmp.canUse = false
                if timeStamp > startTime {
                    tmp.state = "已过期"
                }else {
                    tmp.state = "尚未到达活动开始时间"
                }
                continue
            }
            
            ////判断该模型是否使用过该优惠券
            if type == "1" {
                if RequireOrderDataSource[index.row].book1 == tmp.counponId {
                    tmp.canUse = true
                    tmp.state = "正在使用中"
                }else {
                    if tmp.receiveNum - tmp.userNum == 0 {
                        tmp.canUse = false
                        tmp.state = "可使用数量为0"
                    }
                }
            }else {
                if RequireOrderDataSource[index.row].book2 == tmp.counponId {
                    tmp.canUse = true
                    tmp.state = "正在使用中"
                }else {
                    if tmp.receiveNum - tmp.userNum == 0 {
                        tmp.canUse = false
                        tmp.state = "可使用数量为0"
                    }
                }
            }
        }
        tableView.reloadData()
    }
}


// MARK: - UITableViewDelegate
extension NewSelectDiscountsBookViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if type == "1" {
            
            delog("预约金优惠券")
            if indexPath.row == 0 {
                
                delog("不使用任何优惠券直接返回上一步")
                if RequireOrderDataSource[index.row].book1.count == 0 {
                    delog("这个项目没有选择任何优惠券")
                }else {
                    delog("把这个所在的优惠券已使用数量-1")
                    for tmp in 0..<selectAppointmentDataSource.count {
                        delog("寻找到优惠券所在的数据列表")
                        if RequireOrderDataSource[index.row].book1 == selectAppointmentDataSource[tmp].counponId {
                            delog("减少使用数量1")
                            selectAppointmentDataSource[tmp].userNum -= 1
                            delog("给这个项目的优惠券初始化")
                            RequireOrderDataSource[index.row].book1 = String()
                        }
                    }
                }
            }else {
                
                delog("判断该优惠券是否可以使用")
                if dataSource[indexPath.row-1].canUse {
                    delog("判断现在正在使用的是否是点击区域的优惠券")
                    if dataSource[indexPath.row - 1].state == "正在使用中" {
                        delog("正在使用的就是点击区域类的优惠券，直接返回上一步")
                    }else {
                        for tmp in 0..<selectAppointmentDataSource.count {
                            
                            delog("判断之前是否使用过优惠券")
                            if dataSource[indexPath.row-1].counponId.count == 0 {
                                
                                delog("之前没有使用过优惠券")
                                delog("获得点击的优惠券")
                                if dataSource[indexPath.row-1].counponId == selectAppointmentDataSource[tmp].counponId {
                                    delog("增加当前点击的优惠券使用数量1")
                                    selectAppointmentDataSource[tmp].userNum += 1
                                    delog("记录所使用的优惠券")
                                    RequireOrderDataSource[index.row].book1 = dataSource[indexPath.row-1].counponId
                                }
                            }else {
                                
                                delog("获得点击的优惠券")
                                if dataSource[indexPath.row-1].counponId == selectAppointmentDataSource[tmp].counponId {
                                    delog("之前使用过优惠券")
                                    if RequireOrderDataSource[index.row].book1 == selectAppointmentDataSource[tmp].counponId {
                                        delog("之前使用过的优惠券减少使用数量1")
                                        selectAppointmentDataSource[tmp].userNum -= 1
                                    }
                                    delog("增加当前点击的优惠券使用数量1")
                                    selectAppointmentDataSource[tmp].userNum += 1
                                    RequireOrderDataSource[index.row].book1 = dataSource[indexPath.row-1].counponId
                                    delog("记录所使用的优惠券")
                                    RequireOrderDataSource[index.row].book1 = dataSource[indexPath.row-1].counponId
                                }
                            }
                        }
                    }
                }else {
                    SVPwillShowAndHide("该优惠券无法使用")
                }
            }
        }else {
            
            delog("尾款优惠券")
            if indexPath.row == 0 {
                
                delog("不使用任何优惠券直接返回上一步")
                if RequireOrderDataSource[index.row].book2.count == 0 {
                    delog("这个项目没有选择任何优惠券")
                }else {
                    delog("把这个所在的优惠券已使用数量-1")
                    for tmp in 0..<selectFinalDataSource.count {
                        delog("寻找到优惠券所在的数据列表")
                        if RequireOrderDataSource[index.row].book2 == selectFinalDataSource[tmp].counponId {
                            delog("减少使用数量1")
                            selectFinalDataSource[tmp].userNum -= 1
                            delog("给这个项目的优惠券初始化")
                            RequireOrderDataSource[index.row].book2 = String()
                        }
                    }
                }
            }else {
                
                delog("判断该优惠券是否可以使用")
                if dataSource[indexPath.row-1].canUse {
                    delog("判断现在正在使用的是否是点击区域的优惠券")
                    if dataSource[indexPath.row - 1].state == "正在使用中" {
                        delog("正在使用的就是点击区域类的优惠券，直接返回上一步")
                    }else {
                        for tmp in 0..<selectFinalDataSource.count {
                            
                            delog("判断之前是否使用过优惠券")
                            if dataSource[indexPath.row-1].counponId.count == 0 {
                                
                                delog("之前没有使用过优惠券")
                                delog("获得点击的优惠券")
                                if dataSource[indexPath.row-1].counponId == selectFinalDataSource[tmp].counponId {
                                    delog("增加当前点击的优惠券使用数量1")
                                    selectFinalDataSource[tmp].userNum += 1
                                    delog("记录所使用的优惠券")
                                    RequireOrderDataSource[index.row].book2 = dataSource[indexPath.row-1].counponId
                                }
                            }else {
                                
                                delog("获得点击的优惠券")
                                if dataSource[indexPath.row-1].counponId == selectFinalDataSource[tmp].counponId {
                                    delog("之前使用过优惠券")
                                    if RequireOrderDataSource[index.row].book2 == selectFinalDataSource[tmp].counponId {
                                        delog("之前使用过的优惠券减少使用数量1")
                                        selectFinalDataSource[tmp].userNum -= 1
                                    }
                                    delog("增加当前点击的优惠券使用数量1")
                                    selectFinalDataSource[tmp].userNum += 1
                                    RequireOrderDataSource[index.row].book2 = dataSource[indexPath.row-1].counponId
                                    delog("记录所使用的优惠券")
                                    RequireOrderDataSource[index.row].book2 = dataSource[indexPath.row-1].counponId
                                }
                            }
                        }
                    }
                }else {
                    SVPwillShowAndHide("该优惠券无法使用")
                }
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 98
        }
        return 135
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell : NewDontSelectBookTabCell! = tableView.dequeueReusableCell(withIdentifier: "NewDontSelectBookTabCell", for: indexPath) as! NewDontSelectBookTabCell
            cell.selectionStyle = .none
            return cell
        }
        let cell : NewDiscountBookTabCell! = tableView.dequeueReusableCell(withIdentifier: "NewDiscountBookTabCell", for: indexPath) as! NewDiscountBookTabCell
        cell.selectionStyle = .none
        cell.selectBookModel = dataSource[indexPath.row-1]
        cell.index = index
        return cell
    }
}

// MARK: - UITableViewDataSource
extension NewSelectDiscountsBookViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return dataSource.count + 1
    }
}
