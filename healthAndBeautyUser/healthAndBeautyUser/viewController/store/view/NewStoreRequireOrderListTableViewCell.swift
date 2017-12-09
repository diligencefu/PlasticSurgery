//
//  NewStoreRequireOrderListTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/9/4.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewStoreRequireOrderListTableViewCell: Wx_baseTableViewCell {

    private var _model : NewStoreRequireOrderModel?
    var model : NewStoreRequireOrderModel? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    
    private func didSetModel(_ model: NewStoreRequireOrderModel) {
        
        img.image = UIImage(named:model.thumbnail)
        title.text = model.productName
        hospital.text = "\(model.productSource) \(model.doctorName)"
        newPrice.text = "￥ \(model.payPrice)"
        countLab.text = "* \(model.num)"
        
//        productType 商品类型  1:项目产品  2:普通商品
        if model.productType == "1" {
            price1.text = "预约金小计: ￥\(model.payPrice * 0.1)"
            price2.text = "尾款小计: ￥\(model.payPrice * 0.9)"

                book1.text = "点击选择优惠券"
                book1.textColor = lightText

                book2.text = "点击选择优惠券"
                book2.textColor = lightText
        }else {
            price1.text = "小计: ￥\(model.payPrice)"

                book1.text = "点击选择优惠券"
                book1.textColor = lightText
        }
    }
    let img = UIImageView()

    let title = UILabel()
    let hospital = UILabel()
    let newPrice = UILabel()
    let countLab = UILabel()
    let line = UIView()
    
    //优惠券小计1
    let line1 = UIView()
    let view1 = UIView()//点击区域
    let price1 = UILabel()
    let book1 = UILabel()
    let more1 = UIImageView()
    
    //优惠券小计2
    let line2 = UIView()
    let view2 = UIView()//点击区域
    let price2 = UILabel()
    let book2 = UILabel()
    let more2 = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func buildUI() {

        //图像
        contentView.addSubview(img)
        _ = img.sd_layout()?
            .topSpaceToView(contentView,GET_SIZE * 24)?
            .leftSpaceToView(contentView,GET_SIZE * 32)?
            .widthIs(GET_SIZE * 200)?
            .heightIs(GET_SIZE * 200)
        viewRadius(img, 5.0, 0.5, lineColor)
        
        //标签
        title.textColor = darkText
        title.numberOfLines = 0
        title.font = UIFont.systemFont(ofSize: TEXT32)
        contentView.addSubview(title)
        _ = title.sd_layout()?
            .topSpaceToView(contentView,GET_SIZE * 30)?
            .leftSpaceToView(img,GET_SIZE * 24)?
            .rightSpaceToView(contentView,GET_SIZE * 30)?
            .heightIs(GET_SIZE * 78)
        
        //医院
        hospital.textColor = lightText
        hospital.font = UIFont.systemFont(ofSize: TEXT24)
        contentView.addSubview(hospital)
        _ = hospital.sd_layout()?
            .topSpaceToView(title,6)?
            .leftSpaceToView(img,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 300)?
            .heightIs(GET_SIZE * 26)
        
        //价格
        newPrice.textColor = redText
        newPrice.font = UIFont.systemFont(ofSize: GET_SIZE * 40)
        contentView.addSubview(newPrice)
        _ = newPrice.sd_layout()?
            .topSpaceToView(contentView,GET_SIZE * 175)?
            .leftSpaceToView(img,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 200)?
            .heightIs(GET_SIZE * 44)
        
        //数量
        countLab.textColor = lightText
        countLab.font = UIFont.systemFont(ofSize: GET_SIZE * 30)
        countLab.textAlignment = .center
        contentView.addSubview(countLab)
        _ = countLab.sd_layout()?
            .centerYEqualToView(newPrice)?
            .rightSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 72)?
            .heightIs(GET_SIZE * 44)
        
        //最底部的线条
        line.backgroundColor = lineColor
        contentView.addSubview(line)
        _ = line.sd_layout()?
            .bottomSpaceToView(contentView,0)?
            .leftSpaceToView(contentView,0)?
            .widthIs(WIDTH)?
            .heightIs(0.5)
        
        
        //分割线条1
        line1.backgroundColor = lineColor
        contentView.addSubview(line1)
        _ = line1.sd_layout()?
            .topSpaceToView(img,GET_SIZE * 24)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(WIDTH)?
            .heightIs(0.5)
        //分割线条2
        line2.backgroundColor = lineColor
        contentView.addSubview(line2)
        _ = line2.sd_layout()?
            .topSpaceToView(line1,GET_SIZE * 80)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(WIDTH)?
            .heightIs(0.5)
        
        //点击区域1
        view1.backgroundColor = backGroundColor
        contentView.addSubview(view1)
        _ = view1.sd_layout()?
            .topSpaceToView(line1,0)?
            .bottomSpaceToView(line1,0)?
            .leftSpaceToView(contentView,0)?
            .rightSpaceToView(contentView,0)
        let tap1 = UITapGestureRecognizer.init(target: self, action: #selector(viewClick(_:)))
        view1.addGestureRecognizer(tap1)
        
        //点击区域2
        view2.backgroundColor = backGroundColor
        contentView.addSubview(view2)
        _ = view2.sd_layout()?
            .topSpaceToView(line2,0)?
            .bottomSpaceToView(line,0)?
            .leftSpaceToView(contentView,0)?
            .rightSpaceToView(contentView,0)
        let tap2 = UITapGestureRecognizer.init(target: self, action: #selector(viewClick(_:)))
        view2.addGestureRecognizer(tap2)
        
        //小计
        price1.textColor = lightText
        price1.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        price1.textAlignment = .left
        view1.addSubview(price1)
        _ = price1.sd_layout()?
            .centerYEqualToView(view1)?
            .leftSpaceToView(view1,GET_SIZE * 24)?
            .widthIs(WIDTH/2)?
            .heightIs(GET_SIZE * 44)
        
        //优惠券
        book1.textColor = lightText
        book1.font = UIFont.systemFont(ofSize: GET_SIZE * 30)
        book1.textAlignment = .right
        view1.addSubview(book1)
        _ = book1.sd_layout()?
            .centerYEqualToView(view1)?
            .rightSpaceToView(view1,GET_SIZE * 60)?
            .widthIs(WIDTH/2)?
            .heightIs(GET_SIZE * 44)
        
        //切换图像
        more1.image = UIImage(named:"03_go_icon_default")
        view1.addSubview(more1)
        _ = more1.sd_layout()?
            .centerYEqualToView(view1)?
            .rightSpaceToView(view1,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 14)?
            .heightIs(GET_SIZE * 26)
        
        //下面的
        //小计
        price2.textColor = lightText
        price2.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        price2.textAlignment = .left
        view2.addSubview(price2)
        _ = price2.sd_layout()?
            .centerYEqualToView(view2)?
            .leftSpaceToView(view2,GET_SIZE * 24)?
            .widthIs(WIDTH/2)?
            .heightIs(GET_SIZE * 44)
        
        //优惠券
        book2.textColor = lightText
        book2.font = UIFont.systemFont(ofSize: GET_SIZE * 30)
        book2.textAlignment = .right
        view2.addSubview(book2)
        _ = book2.sd_layout()?
            .centerYEqualToView(view2)?
            .rightSpaceToView(view2,GET_SIZE * 60)?
            .widthIs(WIDTH/2)?
            .heightIs(GET_SIZE * 44)
        
        //切换图像
        more2.image = UIImage(named:"03_go_icon_default")
        view2.addSubview(more2)
        _ = more2.sd_layout()?
            .centerYEqualToView(view2)?
            .rightSpaceToView(view2,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 14)?
            .heightIs(GET_SIZE * 26)
    }
    
    @objc private func viewClick(_ tap:UITapGestureRecognizer) {
        
        if tap.view == view1 {
            
            //点击上面
            delog("上面")
        }else {
            
            //点击下面
            delog("下面")
        }
    }
}
