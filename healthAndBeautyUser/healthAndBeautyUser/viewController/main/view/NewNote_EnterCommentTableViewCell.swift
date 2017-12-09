//
//  NewNote_EnterCommentTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/9/26.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewNote_EnterCommentTableViewCell: Wx_baseTableViewCell {
    
    //点击事件
    typealias swiftBlock = (_ type:String, _ id:String) -> Void
    var willClick : swiftBlock? = nil
    func callBackBlock(block: @escaping (_ type:String, _ id:String) -> Void ) {
        willClick = block
    }
    
    private var _model : NewNoteEnterDetail_2Model_Comments?
    var model : NewNoteEnterDetail_2Model_Comments? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    
    private func didSetModel(_ model: NewNoteEnterDetail_2Model_Comments) {
        
        var sizes = CGSize()

        head.kf.setImage(with: StringToUTF_8InUrl(str: model.personal.photo))

        name.text = model.personal.nickName
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
        
        for index in 0..<model.replys.count {

            let tmp = "\(model.replys[index].userName)回复\(model.personal.nickName): \(model.replys[index].content)"

            let attributeString = NSMutableAttributedString(string:tmp)
            //设置字体颜色
            attributeString.addAttribute(NSForegroundColorAttributeName,
                                         value: tabbarColor,
                                         range: NSMakeRange(0,
                                                            model.replys[index].userName.count))
            attributeString.addAttribute(NSForegroundColorAttributeName,
                                         value: getColorWithNotAlphe(0x747474),
                                         range: NSMakeRange(model.replys[index].userName.count,
                                                            2))
            attributeString.addAttribute(NSForegroundColorAttributeName,
                                         value: tabbarColor,
                                         range: NSMakeRange(model.replys[index].userName.count + 2,
                                                            model.personal.nickName.count))
            attributeString.addAttribute(NSForegroundColorAttributeName,
                                         value: getColorWithNotAlphe(0x747474),
                                         range: NSMakeRange("\(model.replys[index].userName)回复\(model.personal.nickName)".count,
                                                            tmp.count-"\(model.replys[index].userName)回复\(model.personal.nickName)".count))
            let repeats = UILabel()
            repeats.attributedText = attributeString
            repeats.backgroundColor = getColorWithNotAlphe(0xF4F4F4)
            repeats.numberOfLines = 0
            repeats.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
            repeats.tag = 1024 + index
            repeats.layer.cornerRadius = 4.0
            repeats.layer.masksToBounds = true
            contentView.addSubview(repeats)
            sizes = getSizeOnString(tmp, 14)
            if index == 0 {
                _ = repeats.sd_layout()?
                    .topSpaceToView(detail,6)?
                    .leftSpaceToView(contentView,GET_SIZE * 30)?
                    .rightSpaceToView(contentView,GET_SIZE * 30)?
                    .heightIs(sizes.height + 15)
            }else {
                _ = repeats.sd_layout()?
                    .topSpaceToView(repeatsArr.last,3)?
                    .leftSpaceToView(contentView,GET_SIZE * 30)?
                    .rightSpaceToView(contentView,GET_SIZE * 30)?
                    .heightIs(sizes.height + 15)
            }
            repeatsArr.append(repeats)
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let head = UIImageView()
    let name = UILabel()
    let time = UILabel()
    
    let detail = UILabel()
    
    let line = UIView()
    
    var repeatsArr = [UILabel]()
    
    private func buildUI() {
        
        //图像
        contentView.addSubview(head)
        head.contentMode = .scaleAspectFill
        _ = head.sd_layout()?
            .topSpaceToView(contentView,GET_SIZE * 24)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 90)?
            .heightIs(GET_SIZE * 90)
        viewRadius(head, Float(head.width/2), 0.5, lightText)
        
        //标签
        name.textColor = UIColor.black
        name.numberOfLines = 0
        name.font = UIFont.systemFont(ofSize: GET_SIZE * 30)
        contentView.addSubview(name)
        _ = name.sd_layout()?
            .topSpaceToView(contentView,GET_SIZE * 32)?
            .leftSpaceToView(head,GET_SIZE * 24)?
            .widthIs(WIDTH/2)?
            .heightIs(GET_SIZE * 30)
        
        //时间
        time.textColor = UIColor.black
        time.font = UIFont.systemFont(ofSize: GET_SIZE * 22)
        contentView.addSubview(time)
        _ = time.sd_layout()?
            .topSpaceToView(name,GET_SIZE * 14)?
            .leftSpaceToView(head,GET_SIZE * 24)?
            .widthIs(WIDTH/2)?
            .heightIs(GET_SIZE * 24)
        
        //日记具体内容
        detail.textColor = getColorWithNotAlphe(0x656565)
        detail.numberOfLines = 0
        detail.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        contentView.addSubview(detail)
        
        line.backgroundColor = lineColor
        contentView.addSubview(line)
        _ = line.sd_layout()?
            .bottomSpaceToView(contentView,0)?
            .leftSpaceToView(contentView,0)?
            .rightSpaceToView(contentView,0)?
            .heightIs(1)
    }
}

