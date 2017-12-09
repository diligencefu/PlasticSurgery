//
//  NewCreateNoteSymptomTabCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/9/28.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewCreateNoteSymptomTabCell: Wx_baseTableViewCell {
    
    private var _symptoms : [articleTagsAndArticleSymptomsModel]?
    var symptoms : [articleTagsAndArticleSymptomsModel]? {
        didSet {
            _symptoms = symptoms
            self.didSetSymptomsModel(symptoms!)
        }
    }
    
    private func didSetSymptomsModel(_ model: [articleTagsAndArticleSymptomsModel]) {
        
        dataSource = model
        collectionView.reloadData()
        
        line.removeFromSuperview()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let detail = UILabel()
    var collectionView = UICollectionView(frame: CGRect(x: 0,
                                                        y: 0,
                                                        width: 0,
                                                        height: 0),
                                          collectionViewLayout: UICollectionViewFlowLayout())
    let line = UIView()
    var dataSource = [articleTagsAndArticleSymptomsModel]()
    
    private func buildUI() {
        
        detail.text = "症状记录 （方便医生跟踪回复行程）"
        detail.textColor = getColorWithNotAlphe(0x757575)
        detail.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        detail.textAlignment = .left
        contentView.addSubview(detail)
        _ = detail.sd_layout()?
            .topEqualToView(contentView)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .rightSpaceToView(contentView,GET_SIZE * 24)?
            .heightIs(GET_SIZE * 64)
        
        let layout = EqualSpaceFlowLayoutEvolve()
        layout.cellType = .left
        layout.betweenOfCell = GET_SIZE * 18
        
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = backGroundColor
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: "NewTagCollecCell",
                                           bundle: nil),
                                forCellWithReuseIdentifier: "NewTagCollecCell")
        contentView.addSubview(collectionView)
        _ = collectionView.sd_layout()?
            .topSpaceToView(detail,0)?
            .leftSpaceToView(contentView,0)?
            .rightSpaceToView(contentView,0)?
            .bottomSpaceToView(contentView,10)
        
        line.backgroundColor = lineColor
        contentView.addSubview(line)
        _ = line.sd_layout()?
            .topSpaceToView(collectionView,0)?
            .leftSpaceToView(contentView,0)?
            .rightSpaceToView(contentView,0)?
            .bottomSpaceToView(contentView,0)
    }
}

extension NewCreateNoteSymptomTabCell : UICollectionViewDelegate,
                                        UICollectionViewDataSource,
                                        UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:NewTagCollecCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "NewTagCollecCell", for: indexPath) as? NewTagCollecCell
        cell?.model = dataSource[indexPath.row]
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    //返回cell 上下左右的间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsetsMake(10, 5, 10, 5)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let seizs = getSizeOnString(dataSource[indexPath.row].tarContentOrSymptomInfo, 14)
        return CGSize(width: seizs.width + 25, height: seizs.height + 10)
    }
}
