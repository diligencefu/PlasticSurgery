//
//  FYHShowCJGooddsCell.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/20.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
//import SnapKit

class FYHShowCJGooddsCell: UITableViewCell {
    
    @IBOutlet weak var goodImage: UIImageView!
    
    @IBOutlet weak var goodName: UILabel!
    
    @IBOutlet weak var createDate: UILabel!
    
    @IBOutlet weak var getGood: UIButton!
    
    var good_id = ""
    var goodModel = FYHShowGetGoodsModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        goodImage.clipsToBounds = true
        goodImage.layer.cornerRadius = 2
        
        getGood.clipsToBounds = true
        getGood.layer.cornerRadius = 5
    }
    
    
    func setValuesForFYHShowCJGooddsCell(model:FYHShowGetGoodsModel,isGet:Bool) {
        goodModel = model
        
        goodImage.kf.setImage(with:  StringToUTF_8InUrl(str:model.prizeIcon))
        goodName.text = model.prizeName
        createDate.text = model.createDate
        
        if model.status == "0" {
            getGood.setTitle("领取奖励", for: .normal)
            getGood.backgroundColor = kMainColor()
            getGood.isEnabled = true
        }else if model.status == "1" {
            getGood.setTitle("待发放", for: .normal)
            getGood.backgroundColor = kGaryColor(num: 117)
            getGood.isEnabled = false
        }else if model.status == "2" {
            getGood.setTitle("已发放", for: .normal)
            getGood.backgroundColor = kGaryColor(num: 117)
            getGood.isEnabled = false
        }
        
        if isGet {
            getGood.isHidden = true
        }else{
            getGood.isHidden = false
        }
    }

    
    @IBAction func getGoodAction(_ sender: UIButton) {

        let getDoodVC = FYHGetFreeGoodsViewController()
        getDoodVC.goodModel = goodModel
        viewController()?.navigationController?.pushViewController(getDoodVC, animated: true)
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
