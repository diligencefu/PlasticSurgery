//
//  NewEditSelectTabTabCell.swift
//  healthAndBeautyUser
//
//  Created by 丿番茄 on 2017/11/6.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

var EditSelectArr = [String]()
class NewEditSelectTabTabCell: Wx_baseTableViewCell {
    
    private var _editModel : NewEditMeModel?
    var editModel : NewEditMeModel? {
        didSet {
            _editModel = editModel
            self.didSetEditModel(editModel!)
        }
    }
    private func didSetEditModel(_ model: NewEditMeModel) {
        
        EditSelectArr = [String]()
        collectionDateSource.removeAll()
        for index in 0..<model.projectClassify.count {
            let tmp = Wx_twoTableModel()
            tmp.id = model.projectClassify[index].id
            tmp.name = model.projectClassify[index].name
            for tmpModel in model.projectClassified {
                if tmpModel.id == tmp.id {
//                    tmp.isSelect = true
                    EditSelectArr.append(tmp.id)
                }
            }
            collectionDateSource.append(tmp)
        }
        collectionView.reloadData()
    }
    
    lazy var collectionView : UICollectionView = {
        
        let layout = EqualSpaceFlowLayoutEvolve()
        
        let collection = UICollectionView.init(frame: CGRect(), collectionViewLayout: layout)
        collection.backgroundColor = backGroundColor
        collection.delegate = self
        collection.dataSource = self
        
        collection.register(UINib.init(nibName: "NewEditTableCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NewEditTableCollectionViewCell")
        
        return collection
    }()
    var collectionDateSource : [Wx_twoTableModel] = []
    
    let title = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func buildUI() {
        
        title.text = "做过哪些项目呢"
        title.textColor = tabbarColor
        title.font = UIFont.systemFont(ofSize: GET_SIZE * 32)
        title.textAlignment = .left
        contentView.addSubview(title)
        _ = title.sd_layout()?
            .topSpaceToView(contentView,GET_SIZE * 24)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(WIDTH)?
            .heightIs(GET_SIZE * 34)
        
        contentView.addSubview(collectionView)
        _ = collectionView.sd_layout()?
            .topSpaceToView(title,0)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .rightSpaceToView(contentView,GET_SIZE * 24)?
            .bottomSpaceToView(contentView,0)
    }
}


extension NewEditSelectTabTabCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //MARK : -  collection代理方法
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if EditSelectArr.contains(collectionDateSource[indexPath.row].id) {
            collectionDateSource[indexPath.row].isSelect = true
        }else{
            collectionDateSource[indexPath.row].isSelect = false
        }
        let cell:NewEditTableCollectionViewCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "NewEditTableCollectionViewCell", for: indexPath) as? NewEditTableCollectionViewCell
        cell?.model = collectionDateSource[indexPath.row]
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let model = collectionDateSource[indexPath.row]
        collectionView.deselectItem(at: indexPath, animated: true)
        if EditSelectArr.contains(model.id) {
            EditSelectArr.remove(at: EditSelectArr.index(of: model.id)!)
        }else{
            EditSelectArr.append(model.id)
        }
        collectionView.reloadData()
        delog(EditSelectArr)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionDateSource.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    //返回cell 上下左右的间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsetsMake(10, 5, 10, 5)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let sizes = getSizeOnString((collectionDateSource[indexPath.row]).name, 14)
        return CGSize(width: sizes.width + 30, height: GET_SIZE * 48)
    }
}


