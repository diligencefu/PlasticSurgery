//
//  NewStoreDetailMainDetailTabCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/10/23.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewStoreDetailMainDetailTabCell: UITableViewCell {
    
    private var _model : NewStoreDetailModel?
    var model : NewStoreDetailModel? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    
    private func didSetModel(_ model: NewStoreDetailModel) {
        
        let  arr = NSMutableArray()
        for index in model.images {
            arr.add(index)
        }
        banner = ADView.init(frame: CGRect.init(x: 0, y: 0, width: WIDTH, height: adView.frame.size.height),
                             andImageURLArray: arr,
                             andIsRunning: true)
        contentView.addSubview(banner)
        
        titles.text = "【\(model.productName)】\(model.productChildName)"
        newPrice.text = "￥\(model.disPrice)"
        oldPrice.text = "￥\(model.salaPrice)"
        appointment.text = "预约数:\(model.reservationCount)"
        
        if model.isFreeShipping == "0" {
            post.isHidden = false
            post.text = "不包邮(邮费:\(model.postage))"
        }else if model.isFreeShipping == "1" {
            post.isHidden = false
            post.text = "包邮"
        }else {
            post.isHidden = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var banner = ADView()

    @IBOutlet weak var adView: UIView!
    @IBOutlet weak var titles: UILabel!
    @IBOutlet weak var newPrice: UILabel!
    @IBOutlet weak var oldPrice: UILabel!
    
    @IBOutlet weak var appointment: UILabel!
    
    //是否包邮
    @IBOutlet weak var post: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
