//
//  Wx_twoTableView.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/21.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON

//选中颜色和线颜色
var Wx_selectColor = getColorWithNotAlphe(0xFF5D5E)          //选中后的颜色
var Wx_lineColor = getColorWithNotAlphe(0xDFDFDF)            //线的颜色

//3个字体颜色
var Wx_darkText = getColorWithNotAlphe(0x454545)              //tableViewCell颜色
var Wx_defaultText = getColorWithNotAlphe(0x656565)           //collectionViewCellHeade颜色
var Wx_lightText = getColorWithNotAlphe(0x949494)             //collectionViewCell字体颜色
var Wx_CollectionText = getColorWithNotAlphe(0xF3F4F5)        //collectionViewCell背景颜色

//背景颜色
var Wx_backColor = getColorWithNotAlphe(0xFDFDFD)             //一般背景颜色
var Wx_selectBackColor = getColorWithNotAlphe(0xFAFAFA)       //选中过的背景颜色

//左边宽度
var Wx_leftWidth = GET_SIZE * 200                               //选中过的背景颜色
var Wx_rightWidth = WIDTH - GET_SIZE * 200                      //选中过的背景颜色

class Wx_twoTableView: UIView  {
    
    //点击事件
    typealias swiftBlock = (_ id:String, _ name:String) -> Void
    var willClick : swiftBlock? = nil
    func callBackBlock(block: @escaping (_ id:String, _ name:String) -> Void ) {
        willClick = block
    }
    
    var isParent = Bool()
    
    var tableDateSource : [Wx_twoTableModel] = []
    var headDateSource : [Wx_twoTableModel] = []
    var collectionDateSource : [NSMutableArray] = []
    
    //UITableView
    //
    //
    lazy var leftTableView : UITableView = {
        let table = UITableView()
        table.backgroundColor = Wx_backColor
        table.delegate = self
        table.dataSource = self
        table.tableFooterView = UIView.init()
        table.separatorStyle = .none
        
        table.register(Wx_titleTableViewCell.self, forCellReuseIdentifier: "Wx_titleTableViewCell")
        
        return table
    }()
    
    //collectionView
    //
    //
    lazy var rightCollectionView : UICollectionView = {
        
        let layout = EqualSpaceFlowLayoutEvolve()
        layout.cellType = .left
        layout.sumWidth = GET_SIZE * 550

        let collection = UICollectionView.init(frame: CGRect(), collectionViewLayout: layout)
        collection.backgroundColor = Wx_selectBackColor
        collection.showsVerticalScrollIndicator = false
        collection.delegate = self
        collection.dataSource = self
        
        collection.register(Wx_titleCollectionViewCell.self, forCellWithReuseIdentifier: "Wx_titleCollectionViewCell")
        collection.register(Wx_CollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "Wx_CollectionViewHeader")
        
        return collection
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildUI() {
        
        self.addSubview(leftTableView)
        self.addSubview(rightCollectionView)

        _ = leftTableView.sd_layout()?
            .leftSpaceToView(self,0)?
            .topSpaceToView(self,0)?
            .widthIs(GET_SIZE * 200)?
            .bottomSpaceToView(self,0)
        
        _ = rightCollectionView.sd_layout()?
            .topSpaceToView(self,0)?
            .leftSpaceToView(leftTableView,0)?
            .rightSpaceToView(self,0)?
            .bottomSpaceToView(self,0)
    }
    
    func reBuildData() {
        
        let updata = ["nil":"nil"]
        
        SVPWillShow("载入中...")
        
        Net.share.getRequest(urlString: getProjects_06_joggle,params: updata,success: { (data) in
            
            let json = JSON(data)
            delog(json)
            if json["code"].int == 1 {
                
                let data = json["data"]
                //左边一级目录
                for (_, subJson):(String, JSON) in data["projrctClassifies"] {
                    
                    let model = Wx_twoTableModel()
                    model.id = subJson["id"].string!
                    model.name = subJson["name"].string!
                    model.parentId = subJson["parentId"].string!
                    self.tableDateSource.append(model)
                }
                //右边目录
                for (_, subJson):(String, JSON) in data["projectList"] {
                    
                    //二级标题内容
                    let model = Wx_twoTableModel()
                    if (subJson["name"].string != nil) {
                        //没有id
                        model.name = subJson["name"].string!
                        model.id = subJson["id"].string!
                    }
                    model.parentId = subJson["parentId"].string!
                    self.headDateSource.append(model)
                    
                    //3级cell内容
                    let collectionModel = NSMutableArray()
                    //如果没有数据 name就会直接跳过 不需要做判断
                    for (_, tmp):(String, JSON) in subJson["projects"] {
                        
                        let model = Wx_twoTableModel()
                        model.id = tmp["id"].string!
                        model.name = tmp["projectName"].string!
                        collectionModel.add(model)
                    }
                    self.collectionDateSource.append(collectionModel)
                }
                self.leftTableView.reloadData()
                self.rightCollectionView.reloadData()
                self.leftTableView.selectRow(at: IndexPath.init(row: 0, section: 0), animated: true, scrollPosition: .top)
            }else {
                SVPwillShowAndHide("数据请求失败!")
            }
            SVPHide()
        }) { (error) in
            SVPwillShowAndHide("网络连接错误!")
        }
    }
    
    //复制出来的 稍稍改了点
    fileprivate func clickLeft(_ model: Wx_twoTableModel) {
        
        let updata = ["id":model.id]
        
        SVPWillShow("载入中...")
        weak var weakSelf = self
        
        Net.share.getRequest(urlString: getProjects_06_joggle,params: updata,success: { (data) in
            
            let json = JSON(data)
            delog(json)
            if json["code"].int == 1 {
                
                weakSelf!.headDateSource.removeAll()
                weakSelf!.collectionDateSource.removeAll()
                
                let data = json["data"]
                for (_, subJson):(String, JSON) in data["projectList"] {
                    delog(subJson)
                    let model = Wx_twoTableModel()
                    if (subJson["name"].string != nil) {
                        //直目录下没有id
                        model.name = subJson["name"].string!
                        if subJson["id"].string != nil {
                            model.id = subJson["id"].string!
                        }
                    }
                    weakSelf!.headDateSource.append(model)
                    
                    let collectionModel = NSMutableArray()
                    for (_, tmp):(String, JSON) in subJson["projects"] {
                        
                        let model = Wx_twoTableModel()
                        model.id = tmp["id"].string!
                        model.name = tmp["projectName"].string!
                        collectionModel.add(model)
                    }
                    weakSelf!.collectionDateSource.append(collectionModel)
                }
                weakSelf!.rightCollectionView.reloadData()
            }else {
                SVPwillShowAndHide("数据请求失败!")
            }
            SVPHide()
        }) { (error) in
            SVPwillShowAndHide("网络连接错误!")
        }
    }
}

extension Wx_twoTableView : UITableViewDelegate, UITableViewDataSource {
    //MARK : -  table代理方法
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableDateSource.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return GET_SIZE * 86
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:Wx_titleTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "Wx_titleTableViewCell") as? Wx_titleTableViewCell
        if nil == cell {
            cell! = Wx_titleTableViewCell.init(style: .default, reuseIdentifier: "Wx_titleTableViewCell")
        }
        cell?.model = tableDateSource[indexPath.row]
        cell?.selectionStyle = .none
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        clickLeft(tableDateSource[indexPath.row])
    }
}

extension Wx_twoTableView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //MARK : -  collection代理方法
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:Wx_titleCollectionViewCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "Wx_titleCollectionViewCell", for: indexPath) as? Wx_titleCollectionViewCell
        cell?.model = collectionDateSource[indexPath.section][indexPath.row] as? Wx_twoTableModel
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionDateSource[section].count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return collectionDateSource.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: GET_SIZE * 550, height: GET_SIZE * 98)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "Wx_CollectionViewHeader", for: indexPath)
        (cell as! Wx_CollectionViewHeader).setTitle(headDateSource[indexPath.section].name)
        return cell
    }
    //返回cell 上下左右的间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsetsMake(10, 5, 10, 5)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let sizes = getSizeOnString((collectionDateSource[indexPath.section][indexPath.row] as! Wx_twoTableModel).name, 14)
        return CGSize(width: sizes.width + 12, height: GET_SIZE * 48)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let model = collectionDateSource[indexPath.section][indexPath.row] as? Wx_twoTableModel
        if willClick != nil {
            if isParent {
                willClick!(headDateSource[indexPath.section].id,
                           (model?.name)!)
            }else {
                willClick!((model?.id)!,
                           (model?.name)!)
            }
        }
    }
}
