//
//  FYHIntegralStoreViewController1.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/20.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class FYHIntegralStoreViewController1: Base2ViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var stopIndex = 0
    
    var dataArr = NSMutableArray()
    
//    var infoView = FYHIntegralHeadView()
    
    var showGoods = NSMutableArray()
    var doneModel = FYHIntegralModel()
    
    var intagralStr = Int()
    var priceStr = Int()
    var surplusStr = Int()
    
    var memberCollectionView = UICollectionView(frame: CGRect(x: 25, y: 150, width: 50, height: 40), collectionViewLayout: UICollectionViewFlowLayout())
    
    var dataArray = NSMutableArray()
    
    let isEdit = Bool()
    
    let identifierCell = "addMemberCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.navigaView.backgroundColor = UIColor.clear
        super.titleLabel.textColor = UIColor.white
        addTagsView()
    }
    
    override func configSubViews() {
        
        let bgView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT))
        bgView.image = #imageLiteral(resourceName: "luckybg")
        bgView.isUserInteractionEnabled = true
        self.view.insertSubview(bgView, at: 0)
        
        setupTitleViewSectionStyle(titleStr: "积分商城")

        //        创建collectionView
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 1, height:1)
        
        layout.scrollDirection = .vertical
        
        layout.minimumInteritemSpacing = 0
        //        设置每行之间最小的间距
        layout.minimumLineSpacing = 10
        
        memberCollectionView = UICollectionView(frame: CGRect(x: 0, y: CGFloat(navHeight), width: kSCREEN_WIDTH, height: kSCREEN_HEIGHT-CGFloat(navHeight)), collectionViewLayout: layout)
        memberCollectionView.backgroundColor = UIColor.white
        
        memberCollectionView.delegate = self
        memberCollectionView.dataSource = self
        
        memberCollectionView.register(UINib.init(nibName: "FYHIntegralHeadCell0", bundle: nil), forCellWithReuseIdentifier: identyfierTable)
        memberCollectionView.register(UINib.init(nibName: "FYHChoujiangCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: identyfierTable1)
        memberCollectionView.register(UINib.init(nibName: "FYHGoodsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: identyfierTable2)
        
        self.view .addSubview(memberCollectionView)
        memberCollectionView.backgroundColor = UIColor.clear
    }
    
    func beginLuck(cell:FYHChoujiangCollectionViewCell) {
        if self.surplusStr<1 {
            SVPwillShowAndHide( "今天抽奖次数已用完，请明天再来！")
            return
        }
        
        if self.intagralStr<self.priceStr {
            SVPwillShowAndHide( "积分不足！")
            return
        }
        let params = [
            "mobileCode" : Defaults["mobileCode"].stringValue,
            "SESSIONID" : Defaults["SESSIONID"].stringValue,
            ]
        NetWorkForChoujiangJieGuo(params: params, callBack: { (datas, flag) in
            if flag {
                self.doneModel = datas[0] as! FYHIntegralModel
                self.showDoneView.removeFromSuperview()
                self.showDoneView = UINib(nibName:"FYHShowDoneView",bundle:nil).instantiate(withOwner: self, options: nil).first as! FYHShowDoneView
                self.showDoneView.展示抽奖得到的奖品(图片: self.doneModel.icon, 名称: self.doneModel.name)
                self.showDoneView.alpha = 0
                self.showDoneView.center = CGPoint(x: self.view.centerX, y: self.view.centerY-20)
                self.view.addSubview(self.showDoneView)
                
                //                    得出中奖结果在奖品中的对应位置
                for index in 0..<self.dataArr.count {
                    let model = self.dataArr[index] as! FYHIntegralModel
                    if model.id == self.doneModel.id {
                        // 抽奖动画开始
                        cell.beginLuckAction(index: Int32(index))
                        break
                    }
                }
                self.intagralStr = self.intagralStr-self.priceStr
                self.surplusStr = self.surplusStr-1
                self.memberCollectionView.reloadSections([0])
            }else{
                //                    内幕没有准备就绪
                SVPwillShowAndHide("系统错误")
            }
        })
    }
    
    override func requestData() {
        
        let params = [
            "mobileCode" : Defaults["mobileCode"].stringValue,
            "SESSIONID" : Defaults["SESSIONID"].stringValue,
            ]
        NetWorkForPrizeList(params: params) { (datas, times, consumptionIntegral, integral, flag) in
            if flag {
                self.dataArr.addObjects(from: datas)
                let data = NSMutableArray()
                for index in datas {
                    let model1 = index as! FYHIntegralModel
                    let model = FYHLuckyModel()
                    model.goodImage = model1.icon
                    model.goodName = model1.name
                    data.add(model)
                }
                self.dataArray = data
                self.intagralStr = Int(integral)!
                self.priceStr = Int(consumptionIntegral)!
                self.surplusStr = Int(times)!
                self.memberCollectionView.reloadData()
            }
        }
        
        NetWorkForCommoditys(params: params) { (goods, flag) in
            if flag {
                self.showGoods.removeAllObjects()
                self.showGoods.addObjects(from: goods)
                self.memberCollectionView.reloadData()
            }
        }
    }

    
    
    //    collectionViewDelegate and Datasource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        }
        if section == 1 {
            return 1
        }
        return showGoods.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identyfierTable, for: indexPath) as! FYHIntegralHeadCell0
            cell.setInfomation(intagralStr: String(intagralStr), priceStr: String(priceStr), surplusStr: String(surplusStr))
            return cell
        }else if indexPath.section == 1 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identyfierTable1, for: indexPath) as! FYHChoujiangCollectionViewCell
            cell.beginLuckBlock = {
                self.beginLuck(cell: cell)
            }
            
            cell.finishLuckBlock = {
                setToast(str: "抽中了第"+$0+"个")
                let model = self.dataArr[Int($0)!] as! FYHIntegralModel
                deBugPrint(item: model.name)
                self.showDoneViewc()
            }
            if dataArray.count > 0{
                cell.setImagesForLuck(images:dataArray)
            }
            return cell
        }else{
            let model = showGoods[indexPath.row] as! FYHConvertGoodsModel
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identyfierTable2, for: indexPath) as! FYHGoodsCollectionViewCell
            cell.setValuesForFYHGoodsCollectionViewCell(model:model)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            return CGSize(width: kSCREEN_WIDTH, height: 112)
        }
        
        if indexPath.section == 1 {
            return CGSize(width: kSCREEN_WIDTH, height: kSCREEN_WIDTH+85)
        }

        return CGSize(width: (kSCREEN_WIDTH-3*15)/2, height: 278)
    }
    
    //    最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    //    每个section的缩进
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if section == 2{
            return UIEdgeInsets(top: 20, left: 15, bottom: 20, right: 15)
        }
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        if indexPath.section != 2 {
            return
        }
        
        let model = showGoods[indexPath.row] as! FYHConvertGoodsModel
        let webView = FYHShowInfoWithWebViewController()
        webView.webTitle = model.name
//        webView.webUrl = "http://16559c35c7.iask.in:34682/details/integral.html"
        webView.webUrl = "http://192.168.1.172:8081/webstrom11/details/integral.html"
        webView.goodId = model.id
        self.navigationController?.pushViewController(webView, animated: true)
    }
    
    
    var BGView = UIView()
    var showDoneView = FYHShowDoneView()
    var totalNum = 1
    
    
    @objc func showChooseCondi(tap:UITapGestureRecognizer) -> Void {
        if tap.view?.alpha == 1 {
            
            UIView.animate(withDuration: 0.5) {
                tap.view?.alpha = 0
                self.showDoneView.alpha = 0
            }
        }
    }
    
    func hiddenViews() {
        UIView.animate(withDuration: 0.5) {
            self.BGView.alpha = 0
            self.showDoneView.alpha = 0
        }
        
    }
    
    
    //    视图TagView
    func addTagsView() {
        
        //        弹出视图弹出来之后的背景蒙层
        BGView = UIView.init(frame: self.view.frame)
        BGView.backgroundColor = kSetRGBAColor(r: 5, g: 5, b: 5, a: 0.5)
        BGView.alpha = 0
        
        let tapGes1 = UITapGestureRecognizer.init(target: self, action: #selector(showChooseCondi(tap:)))
        tapGes1.numberOfTouchesRequired = 1
        BGView.addGestureRecognizer(tapGes1)
        self.view.addSubview(BGView)
    }
    
    
    func showDoneViewc() -> Void {
        
        UIView.animate(withDuration: 0.5) {
            self.showDoneView.alpha = 1
            self.BGView.alpha = 1
        }
    }

    
}
