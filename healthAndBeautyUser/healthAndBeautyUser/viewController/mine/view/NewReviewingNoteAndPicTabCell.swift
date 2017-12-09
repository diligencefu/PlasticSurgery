//
//  NewReviewingNoteAndPicTabCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/10/26.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewReviewingNoteAndPicTabCell: NewNote_noteCharAndIMGTabCell {

    
    private var _reviewModel : NewReviewingModel?
    var reviewModel : NewReviewingModel? {
        didSet {
            _reviewModel = reviewModel
            self.didSetReviewModel(reviewModel!)
        }
    }
    
    private func didSetReviewModel(_ model: NewReviewingModel) {
        
        date.text = model.title
        
        //日记内容尺寸
        detail.text = model.content
        let size = getSizeOnString(model.content, 14)
        _ = detail.sd_layout()?
            .topSpaceToView(date,GET_SIZE * 24)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 700)?
            .heightIs(size.height + 5)
        
        //移除所有数据
        for sub in imgView.subviews {
            sub.removeFromSuperview()
        }
        imgArr.removeAll()
        
        // 中文逗号  不是英文逗号
        _ = imgView.sd_layout()?
            .topSpaceToView(detail,GET_SIZE * 14)?
            .leftSpaceToView(contentView,GET_SIZE * 15)?
            .rightSpaceToView(contentView,GET_SIZE * 15)?
            .heightIs(GET_SIZE * CGFloat(584 * model.images.count))
        tmp.removeAll()
        
        for index in 0..<model.images.count {
            
            let img = UIImageView()
            img.kf.setImage(with: StringToUTF_8InUrl(str: model.images[index]))
            img.contentMode = .scaleAspectFill
            img.layer.masksToBounds = true
            img.tag = 900+index
            imgView.addSubview(img)
            imgArr.append(img)
            
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(click(_:)))
            img.addGestureRecognizer(tap)
            img.isUserInteractionEnabled = true
            tmp.append(img)
            if index == 0 {
                _ = img.sd_layout()?
                    .centerXEqualToView(imgView)?
                    .topSpaceToView(imgView,0)?
                    .widthIs(GET_SIZE * 700)?
                    .heightIs(GET_SIZE * 560)
            }else {
                _ = img.sd_layout()?
                    .centerXEqualToView(imgView)?
                    .topSpaceToView(imgView,GET_SIZE * CGFloat(584 * index))?
                    .widthIs(GET_SIZE * 700)?
                    .heightIs(GET_SIZE * 560)
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        rebuildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func rebuildUI() {
        
        //移除不需要的东西
        thumb.removeFromSuperview()
        thumbsIMG.removeFromSuperview()
        thumbs.removeFromSuperview()
        watchIMG.removeFromSuperview()
        watch.removeFromSuperview()
        reward.removeFromSuperview()
        rewardViwe.removeFromSuperview()
    }
}
