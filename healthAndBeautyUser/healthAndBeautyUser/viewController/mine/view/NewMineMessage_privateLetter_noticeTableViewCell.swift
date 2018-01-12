//
//  newMineMessage_privateLetter_noticeTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/17.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewMineMessage_privateLetter_noticeTableViewCell: Wx_baseTableViewCell {

    private var _model : NewMineMessageModel?
    var model : NewMineMessageModel? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    
    var whereCome = 1
    var mainModel = NewMineMessageAssitModel()
    
    
    let head = UIImageView()
    let title = UILabel()
    let detail = UILabel()
    let time = UILabel()
    
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
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildUI() {
        
        contentView.addSubview(head)
        _ = head.sd_layout()?
            .centerYEqualToView(contentView)?
            .leftSpaceToView(contentView,GET_SIZE * 44)?
            .widthIs(GET_SIZE * 88)?
            .heightIs(GET_SIZE * 88)
        viewRadius(head, Float(head.width/2), 0.5, UIColor.black)

        title.textColor = UIColor.blue
        title.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        title.textAlignment = .left
        contentView.addSubview(title)
        _ = title.sd_layout()?
            .topSpaceToView(contentView,GET_SIZE * 24)?
            .leftSpaceToView(head,GET_SIZE * 24)?
            .widthIs(WIDTH/2)?
            .heightIs(GET_SIZE * 30)
        
        detail.textColor = UIColor.blue
        detail.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        detail.textAlignment = .left
        contentView.addSubview(detail)
        _ = detail.sd_layout()?
            .topSpaceToView(title,4)?
            .leftSpaceToView(head,GET_SIZE * 24)?
            .minWidthIs(GET_SIZE * 600)?
            .heightIs(GET_SIZE * 30)
        
        time.textColor = UIColor.blue
        time.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        time.textAlignment = .right
        contentView.addSubview(time)
        _ = time.sd_layout()?
            .topSpaceToView(contentView,GET_SIZE * 24)?
            .rightSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(WIDTH/2)?
            .heightIs(GET_SIZE * 30)
        
        let line = UIView()
        line.backgroundColor = lineColor
        contentView.addSubview(line)
        _ = line.sd_layout()?
            .bottomSpaceToView(contentView,0)?
            .leftSpaceToView(contentView,0)?
            .widthIs(WIDTH)?
            .heightIs(0.5)
        head.isUserInteractionEnabled = true
        title.isUserInteractionEnabled = true
        let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(moveToBigImage(tap:)))
        head.addGestureRecognizer(tapGes)
        let tapGes1 = UITapGestureRecognizer.init(target: self, action: #selector(moveToBigImage(tap:)))
        title.addGestureRecognizer(tapGes1)
        
    }
    
    @objc func moveToBigImage(tap:UITapGestureRecognizer) {
        let me = newMineMeViewController()
        if whereCome == 0 {
//            me.id = _model!.
            me.isMe = false
        }else{
            me.id = mainModel.personal.id
            me.isMe = false
        }
        viewController()?.navigationController?.pushViewController(me, animated: true)
    }

    private func didSetModel(_ model: NewMineMessageModel) {
        whereCome = 1
        head.image = UIImage(named:model.head)
        
        time.text = model.time
        detail.text = model.detail
        title.text = model.name
    }
    
//    新粉丝
    func SetValueWithModel(model: NewMineMessageAssitModel) {
//        whereCome = 2
//        mainModel = model
//        head.kf.setImage(with:  StringToUTF_8InUrl(str:model.personal.photo))
//        time.text = model.createDate
//        detail.text = "关注了您"
//        title.text = model.personal.nickName
    }
    
}
