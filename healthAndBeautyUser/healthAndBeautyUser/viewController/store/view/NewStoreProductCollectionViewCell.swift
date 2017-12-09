//
//  NewStoreProductCollectionViewCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/18.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewStoreProductCollectionViewCell: UICollectionViewCell {

//    private var _model : NewStoreProductModel?
//    var model : NewStoreProductModel? {
//        didSet {
//            _model = model
//            self.didSetModel(model!)
//        }
//    }
////    var img = String()
////    var title = String()
////    var price = String()
////    var sellCount = String()
////    var book = String()
////    var score = String()
//    private func didSetModel(_ model: NewStoreProductModel) {
//
//        icon.image = UIImage(named:model.img)
//
//        title.text = model.title
//        title.numberOfLines = 0
//        title.lineBreakMode = .byCharWrapping
//
//        price.text = "￥ \(model.price)"
//        count.text = "已售 \(model.sellCount)"
//        book.text = model.book
//        score.text = model.score
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    let icon = UIImageView()
    let title = UILabel()
    let lines = UIView()
    let price = UILabel()
    let count = UILabel()
    
    let bookIMG = UIImageView()
    let book = UILabel()
    
    let scoreIMG = UIImageView()
    let score = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = backGroundColor
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildUI() {
        
        contentView.addSubview(icon)
        _ = icon.sd_layout()?
            .topSpaceToView(contentView,GET_SIZE * 24)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .rightSpaceToView(contentView,GET_SIZE * 14)?
            .heightIs(GET_SIZE * 240)
        
        title.textColor = UIColor.black
        title.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        title.textAlignment = .left
        contentView.addSubview(title)
        _ = title.sd_layout()?
            .topSpaceToView(contentView,GET_SIZE * 270)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .rightSpaceToView(contentView,GET_SIZE * 24)?
            .heightIs(GET_SIZE * 70)
        
        lines.backgroundColor = lineColor
        contentView.addSubview(lines)
        _ = lines.sd_layout()?
            .topSpaceToView(title,5)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .rightSpaceToView(contentView,GET_SIZE * 24)?
            .heightIs(0.5)
        
        price.textColor = UIColor.red
        price.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        price.textAlignment = .left
        contentView.addSubview(price)
        _ = price.sd_layout()?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .topSpaceToView(lines,5)?
            .widthIs(contentView.width)?
            .heightIs(GET_SIZE * 30)
        
        count.textColor = UIColor.black
        count.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        count.textAlignment = .right
        contentView.addSubview(count)
        _ = count.sd_layout()?
            .rightSpaceToView(contentView,GET_SIZE * 24)?
            .topSpaceToView(lines,5)?
            .widthIs(contentView.width)?
            .heightIs(GET_SIZE * 30)
        
        bookIMG.image = UIImage(named:"Selected")
        contentView.addSubview(bookIMG)
        _ = bookIMG.sd_layout()?
            .topSpaceToView(price,GET_SIZE * 10)?
            .leftSpaceToView(contentView,GET_SIZE * 12)?
            .widthIs(GET_SIZE * 30)?
            .heightIs(GET_SIZE * 30)
        
        book.textColor = UIColor.black
        book.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        book.textAlignment = .left
        contentView.addSubview(book)
        _ = book.sd_layout()?
            .leftSpaceToView(bookIMG,5)?
            .centerYEqualToView(bookIMG)?
            .rightSpaceToView(contentView,0)?
            .heightIs(GET_SIZE * 30)
        
        scoreIMG.image = UIImage(named:"Selected")
        contentView.addSubview(scoreIMG)
        _ = scoreIMG.sd_layout()?
            .topSpaceToView(bookIMG,GET_SIZE * 10)?
            .leftSpaceToView(contentView,GET_SIZE * 12)?
            .widthIs(GET_SIZE * 30)?
            .heightIs(GET_SIZE * 30)
        
        score.textColor = UIColor.black
        score.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        score.textAlignment = .left
        contentView.addSubview(score)
        _ = score.sd_layout()?
            .leftSpaceToView(scoreIMG,5)?
            .centerYEqualToView(scoreIMG)?
            .rightSpaceToView(contentView,0)?
            .heightIs(GET_SIZE * 30)
    }
}
