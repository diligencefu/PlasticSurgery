//
//  NewMainIconGroupCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/19.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class iconModel : NSObject {
    
    var title = String()
    var img = String()
    
    
    
    
}

class NewMainIconGroupCell: Wx_baseTableViewCell,
                            UICollectionViewDelegate,
                            UICollectionViewDataSource,
                            UICollectionViewDelegateFlowLayout {
//    03_zhengxingbaike_icon_default2@2x        04_rijianli_icon_default1@2x    05_zuixinyouhui_icon_default@2x    06_mianfeizhengxing_icon_default@2x    07_jifenshangcheng_icon_default@2x    08_shoushuxianchang_icon_default@2x.png    09_shuhouzixun_icon_default@2x    10_renwuzhongxin_icon_default@2x
    
    
    var gotoFreeBlock:((String)->())?  //声明闭包

    
    func buildDatas() {
        
        let strArr = ["整形百科","日记案例","免费整形","手术现场","积分商城","任务中心"]
        let imgArr = ["03_zhengxingbaike_icon_default2",
                      "04_rijianli_icon_default1",
                      "06_mianfeizhengxing_icon_default",
                      "08_shoushuxianchang_icon_default",
                      "07_jifenshangcheng_icon_default",
                      "10_renwuzhongxin_icon_default"]
        collectionDateSource.removeAll()
        for index in 0..<strArr.count {
            let model = iconModel()
            model.title = strArr[index]
            model.img = imgArr[index]
            collectionDateSource.append(model)
        }
        collectionView.reloadData()
    }
    
    
    func setValuesForNewMainIconGroupCell(icons:[iconModel]) {
        collectionDateSource = icons
        collectionView.reloadData()
    }
    
    
    //collectionView
    //
    //
    lazy var collectionView : UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        
        let collection = UICollectionView.init(frame: CGRect(), collectionViewLayout: layout)
        collection.backgroundColor = backGroundColor
        collection.delegate = self
        collection.dataSource = self
        
        collection.register(NewMainIconCollectionViewCell.self, forCellWithReuseIdentifier: "NewMainIconCollectionViewCell")
        
        return collection
    }()
    var collectionDateSource : [iconModel] = []
    
    
    private var _model : NewMineMessageModel?
    var model : NewMineMessageModel? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    private func didSetModel(_ model: NewMineMessageModel) {
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func buildUI() {
        
        contentView.addSubview(collectionView)
        _ = collectionView.sd_layout()?
            .topSpaceToView(contentView,0)?
            .leftSpaceToView(contentView,0)?
            .rightSpaceToView(contentView,0)?
            .bottomSpaceToView(contentView,0)
    }
    
    //MARK : -  collection代理方法
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:NewMainIconCollectionViewCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "NewMainIconCollectionViewCell", for: indexPath) as? NewMainIconCollectionViewCell
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
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: GET_SIZE * 165, height: GET_SIZE * 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        index
        
        switch collectionDateSource[indexPath.row].title {
        case "整形百科":
            let tmp = NewMain_BaiKeViewController()
            viewController()?.navigationController?.pushViewController(tmp, animated: true)
            break
        case "日记案例":
            let tmp = NewMainNoteViewController()
            viewController()?.navigationController?.pushViewController(tmp, animated: true)
            break
        case "最新优惠":
            let tmp = NewMain_favourableViewController()
            viewController()?.navigationController?.pushViewController(tmp, animated: true)
            break
        case "免费整形":
            if gotoFreeBlock != nil {
                gotoFreeBlock!("1")
            }
            break
        case "积分商城":
            if gotoFreeBlock != nil {
                gotoFreeBlock!("2")
            }
            break
        case "手术现场":
            let tmp = NewMain_operationViewController()
//            let tmp = VideoViewController()
            viewController()?.navigationController?.pushViewController(tmp, animated: true)
            break
        case "术后咨询":

            break
        case "任务中心":
            let tmp = FYHMissionCenterViewController()
            viewController()?.navigationController?.pushViewController(tmp, animated: true)
            break
        default:
            break
        }
    }
}
