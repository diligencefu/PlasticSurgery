//
//  FYHIntegralStoreViewController.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/19.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class FYHIntegralStoreViewController: Base2ViewController {
    
    var stopIndex = 0
    
    var dataArr = NSMutableArray()

    var luckView = LuckView()
    
    var doneModel = FYHIntegralModel()
    
    var showGoods = NSMutableArray()
    
    var footView = UIView()
    var headView = UIView()
    
    
    var intagralStr = Int()
    var priceStr = Int()
    var surplusStr = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        addTagsView()  
    }
    
//    override func addHeaderRefresh() {
//
//    }
//
//    override func configSubViews() {
//        setupTitleViewSectionStyle(titleStr: "积分商城")
//
//        mainTableView = UITableView.init(frame: CGRect(x: 0,
//                                                       y: CGFloat(navHeight),
//                                                       width: kSCREEN_WIDTH,
//                                                       height: kSCREEN_HEIGHT - 64 ),
//                                         style: .grouped)
//        mainTableView.dataSource = self;
//        mainTableView.delegate = self;
//        mainTableView.estimatedRowHeight = 80
//        mainTableView.register(UINib(nibName: "FYHShowCJGooddsCell", bundle: nil), forCellReuseIdentifier: identyfierTable)
//
//        headView = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 65+kSCREEN_WIDTH))
//        headView.backgroundColor = UIColor.clear
////        infoView = UINib(nibName:"FYHIntegralHeadView",bundle:nil).instantiate(withOwner: self, options: nil).first as! FYHIntegralHeadView
////        infoView.frame =  CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 65)
////        infoView.backgroundColor = UIColor.clear
////        headView.addSubview(infoView)
//
//        luckView = LuckView.init(frame: CGRect(x: 0, y: 83, width: kSCREEN_WIDTH, height: kSCREEN_WIDTH))
//
////        抽奖结果回调
//        luckView.getLuckResult { (index) in
//            setToast(str: "抽中了第"+String(index)+"个")
//            let model = self.dataArr[index] as! FYHIntegralModel
//            deBugPrint(item: model.name)
//            self.showDoneViewc()
//        }
////        点击开始抽奖
//        luckView.beginLuck = {
//
//            if self.surplusStr<1 {
//                SVPwillShowAndHide( "今天抽奖次数已用完，请明天再来！")
//                return
//            }
//
//            if self.intagralStr<self.priceStr {
//                SVPwillShowAndHide( "积分不足！")
//                return
//            }
//
//            deBugPrint(item: $0!)
//            let params = [
//                "mobileCode" : Defaults["mobileCode"].stringValue,
//                "SESSIONID" : Defaults["SESSIONID"].stringValue,
//                ]
//            NetWorkForChoujiangJieGuo(params: params, callBack: { (datas, flag) in
//                if flag {
//                    self.doneModel = datas[0] as! FYHIntegralModel
//
//                    self.showDoneView = UINib(nibName:"FYHShowDoneView",bundle:nil).instantiate(withOwner: self, options: nil).first as! FYHShowDoneView
//                    self.showDoneView.展示抽奖得到的奖品(图片: self.doneModel.icon, 名称: self.doneModel.name)
//                    self.showDoneView.alpha = 0
//                    self.showDoneView.center = CGPoint(x: self.view.centerX, y: self.view.centerY-20)
//                    self.view.addSubview(self.showDoneView)
//
////                    得出中奖结果在奖品中的对应位置
//                    for index in 0..<self.dataArr.count {
//                        let model = self.dataArr[index] as! FYHIntegralModel
//                        if model.id == self.doneModel.id {
//                            self.luckView.stopCount = Int32(index)
//                            break
//                        }
//                    }
////                    抽奖动画开始
//                    self.luckView.startDrawLotteryRaffle()
//
//                    self.intagralStr = self.intagralStr-self.priceStr
//                    self.surplusStr = self.surplusStr-1
////                    self.infoView.setValueForFYHIntegralHeadView(intagralStr: String(self.intagralStr), priceStr: String(self.priceStr), surplusStr: String(self.surplusStr))
//                }else{
////                    内幕没有准备就绪
//                    SVPwillShowAndHide("系统错误")
//                }
//            })
//        }
//
//        headView.addSubview(luckView)
//        self.mainTableView.tableHeaderView = headView
//
//        let bgView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT))
//        bgView.image = #imageLiteral(resourceName: "luckybg")
//        bgView.isUserInteractionEnabled = true
//        self.mainTableView.backgroundView = bgView
//
//
//
//        //        #MARK:footview
//        footView = UIView.init(frame: CGRect(x: 0, y: 65+kSCREEN_WIDTH, width: kSCREEN_WIDTH, height: 0))
//        footView.backgroundColor = UIColor.clear
////        self.mainTableView.tableFooterView = footView
//        headView.addSubview(footView)
//        self.view.addSubview(mainTableView)
//    }
//
//
//    override func requestData() {
//
//        let params = [
//            "mobileCode" : Defaults["mobileCode"].stringValue,
//            "SESSIONID" : Defaults["SESSIONID"].stringValue,
//            ]
//        NetWorkForPrizeList(params: params) { (datas, times, consumptionIntegral, integral, flag) in
//            if flag {
//                self.dataArr.addObjects(from: datas)
//                let data = NSMutableArray()
//                for index in datas {
//                    let model1 = index as! FYHIntegralModel
//                    let model = FYHLuckyModel()
//                    model.goodImage = model1.icon
//                    model.goodName = model1.name
//                    data.add(model)
//                }
//                self.luckView.imageArray = data
//                self.intagralStr = Int(integral)!
//                self.priceStr = Int(consumptionIntegral)!
//                self.surplusStr = Int(times)!
////                self.infoView.setValueForFYHIntegralHeadView(intagralStr: integral, priceStr: consumptionIntegral, surplusStr: times)
//            }
//        }
//
//        NetWorkForCommoditys(params: params) { (goods, flag) in
//            if flag {
//                self.showGoods.removeAllObjects()
//                self.showGoods.addObjects(from: goods)
//            }
//        }
//    }
//
//
//    func viewTheBigImage(ges:UITapGestureRecognizer) {
//
//    }
//
//
//    //    ******************代理 ： UITableViewDataSource,UITableViewDelegate  ************
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//
//        return 1
//    }
//
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell : FYHShowCJGooddsCell = tableView.dequeueReusableCell(withIdentifier: identyfierTable, for: indexPath) as! FYHShowCJGooddsCell
//        if showGoods.count > 0 {
////            cell.setValuesForFYHShowCJGooddsCell(goods: showGoods as! Array<FYHConvertGoodsModel>)
//        }
//        cell.selectionStyle = .none
//        return cell
//    }
//
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let kSpace = CGFloat(15)
//        let kHeight = CGFloat(278)
//        var height = 0
//        let line = CGFloat((showGoods.count)%2)
//        if line == 0 {
//            height = Int(CGFloat((showGoods.count)/2)*kHeight + kSpace*CGFloat(showGoods.count/2)-kSpace)
//        }else{
//            height = Int(CGFloat((showGoods.count)/2+1)*kHeight + kSpace*CGFloat(showGoods.count/2))
//        }
//
//        if height <= 0 {
//            return 1
//        }
//
//        return CGFloat(height)
//    }
//
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//
//        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 19 * kSCREEN_SCALE))
//        view.backgroundColor = UIColor.blue
//        return view
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: 19 * kSCREEN_SCALE))
//        view.backgroundColor = kSetRGBColor(r: 239, g: 239, b: 244)
//        return view
//    }
//
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if section == 0 {
//            return 0.001
//        }
//
//        return 19 * kSCREEN_SCALE
//    }
//
//    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 0.01 * kSCREEN_SCALE
//    }
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//
//    var BGView = UIView()
//    var showDoneView = FYHShowDoneView()
//    var totalNum = 1
//
//
//    @objc func showChooseCondi(tap:UITapGestureRecognizer) -> Void {
//        if tap.view?.alpha == 1 {
//
//            UIView.animate(withDuration: 0.5) {
//                tap.view?.alpha = 0
//                self.showDoneView.alpha = 0
//            }
//        }
//    }
//
//    func hiddenViews() {
//        UIView.animate(withDuration: 0.5) {
//            self.BGView.alpha = 0
//            self.showDoneView.alpha = 0
//        }
//
//    }
//
//
//    //    视图TagView
//    func addTagsView() {
//
//        //        弹出视图弹出来之后的背景蒙层
//        BGView = UIView.init(frame: self.view.frame)
//        BGView.backgroundColor = kSetRGBAColor(r: 5, g: 5, b: 5, a: 0.5)
//        BGView.alpha = 0
//
//        let tapGes1 = UITapGestureRecognizer.init(target: self, action: #selector(showChooseCondi(tap:)))
//        tapGes1.numberOfTouchesRequired = 1
//        BGView.addGestureRecognizer(tapGes1)
//        self.view.addSubview(BGView)
//
////        showDoneView = UINib(nibName:"FYHShowDoneView",bundle:nil).instantiate(withOwner: self, options: nil).first as! FYHShowDoneView
////        showDoneView.frame =  CGRect(x: 0, y: kSCREEN_HEIGHT, width: kSCREEN_WIDTH, height: 190+206*kSCREEN_SCALE)
////        showDoneView.layer.cornerRadius = 24*kSCREEN_SCALE
//////        showDoneView.selectBlock = {
//////            if !$1 {
//////
//////            }
//////            self.hiddenViews()
//////        }
////        showDoneView.clipsToBounds = true
////        self.view.addSubview(showDoneView)
////
//    }
//
//
//
//    func showDoneViewc() -> Void {
//
//        UIView.animate(withDuration: 0.5) {
//            self.showDoneView.alpha = 1
//            self.BGView.alpha = 1
//        }
//    }
//
}

