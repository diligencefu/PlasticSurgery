//
//  NewStoreCommentTabCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/10/24.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewStoreCommentModel: NSObject {
    
    var content = String()
    var createDate = String()
    var id = String()
    var nickName = String()
    var photo = String()
    var gender = String()
}

class NewStoreCommentTabCell: NewNote_EnterCommentTableViewCell {
    
    private var _goodsModel : NewStoreCommentModel?
    var goodsModel : NewStoreCommentModel? {
        didSet {
            _goodsModel = goodsModel
            self.didSetGoodsModel(goodsModel!)
        }
    }
    
    private func didSetGoodsModel(_ model: NewStoreCommentModel) {
        
        var sizes = CGSize()
        
        head.kf.setImage(with: StringToUTF_8InUrl(str: model.photo))
        
        name.text = model.nickName
        time.text = model.createDate
        
        detail.text = model.content
        sizes = getSizeOnString(model.content, 14)
        _ = detail.sd_layout()?
            .topSpaceToView(head,GET_SIZE * 24)?
            .leftSpaceToView(contentView,GET_SIZE * 30)?
            .rightSpaceToView(contentView,GET_SIZE * 30)?
            .heightIs(sizes.height + 20)
        
        _ = repeatsArr.filter() {
            $0.removeFromSuperview()
            return true
        }
        repeatsArr.removeAll()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
