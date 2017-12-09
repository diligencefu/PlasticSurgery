//
//  NewMain_hotTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/22.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewMain_hotTableViewCell:
                                Wx_baseTableViewCell,
                                UICollectionViewDelegate,
                                UICollectionViewDataSource,
                                UICollectionViewDelegateFlowLayout {
    
    private var _model : Array<Any>?
    var model : Array<Any>? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    private func didSetModel(_ model: Array<Any>) {
        
        collectionDateSource.removeAll()
        for index in model {
            let model = Wx_twoTableModel()
            model.id = "345345"
            model.name = "开眼角"
            collectionDateSource.append(model)
        }
        rightCollectionView.reloadData()
    }
    
    //collectionView
    //
    //
    lazy var rightCollectionView : UICollectionView = {
        
        let layout = EqualSpaceFlowLayoutEvolve()
        
        let collection = UICollectionView.init(frame: CGRect(), collectionViewLayout: layout)
        collection.backgroundColor = backGroundColor
        collection.delegate = self
        collection.dataSource = self
        
        collection.register(Wx_titleCollectionViewCell.self, forCellWithReuseIdentifier: "Wx_titleCollectionViewCell")
        collection.register(Wx_CollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "Wx_CollectionViewHeader")
        
        return collection
    }()
    var collectionDateSource : [Wx_twoTableModel] = []

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func buildUI() {
        
        contentView.addSubview(rightCollectionView)
        
        _ = rightCollectionView.sd_layout()?
            .topSpaceToView(contentView,0)?
            .leftSpaceToView(contentView,0)?
            .rightSpaceToView(contentView,0)?
            .bottomSpaceToView(contentView,0)
    }
    
    //MARK : -  collection代理方法
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:Wx_titleCollectionViewCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "Wx_titleCollectionViewCell", for: indexPath) as? Wx_titleCollectionViewCell
        cell?.model = collectionDateSource[indexPath.row]
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionDateSource.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    //返回cell 上下左右的间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsetsMake(0, 15, 10, 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizes = getSizeOnString(collectionDateSource[indexPath.row].name,28)
        return CGSize(width: sizes.width+20, height: GET_SIZE * 45)
    }

}
