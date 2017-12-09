//
//  newMineList_MeTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/15.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewMineList_MeTableViewCell: Wx_baseTableViewCell {
    
    private var _model : NewMainModel?
    var model : NewMainModel? {
        didSet {
            _model = model
            self.setModels(model!)
        }
    }
    
    private func setModels(_ model: NewMainModel) {
        
        if model.photo.count == 0 {
            head.image = UIImage(named:"Initialization_icon_default_66")
        }else {
            head.kf.setImage(with: URL.init(string: model.photo))
        }
        name.text = model.nickName
        let sizes = getSizeOnLabel(name)
        _ = name.sd_layout()?
            .centerYEqualToView(meView)?
            .leftSpaceToView(head,GET_SIZE * 44)?
            .widthIs(sizes.width)?
            .heightIs(GET_SIZE * 32)
        
        if model.gender == "1" {
            sex.image = UIImage(named:"nan_icon_default")
        }else {
            sex.image = UIImage(named:"nv_icon_default")
        }
        _ = sex.sd_layout()?
            .centerYEqualToView(meView)?
            .leftSpaceToView(name,GET_SIZE * 12)?
            .widthIs(GET_SIZE * 32)?
            .heightIs(GET_SIZE * 32)
        
        followLab.text = "\(model.follow)\n关注"
        fansLab.text = "\(model.fans)\n粉丝"
        noteLab.text = "\(model.article)\n日志"
    }
    
    let back = UIImageView()
    
    let setting = UIButton()
    
    let meView = UIImageView()
    let head = UIImageView()
    let name = UILabel()
    let sex = UIImageView()
    let goOn = UIImageView()

    let follow = UIButton()
    let fans = UIButton()
    let note = UIButton()
    let collection = UIButton()
    
    let followLab = UILabel()
    let fansLab = UILabel()
    let noteLab = UILabel()
    let collectionLab = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildUI() {
        
        back.image = getChangeIMG(NSInteger(GET_SIZE * 440))
        back.isUserInteractionEnabled = true
        contentView.addSubview(back)
        _ = back.sd_layout()?
            .topSpaceToView(contentView,0)?
            .rightSpaceToView(contentView,0)?
            .widthIs(WIDTH)?
            .heightIs(GET_SIZE * 400 + (HEIGHT == 812 ? 44 : 20))
        
        setting.setImage(UIImage(named:"set-up"), for: .normal)
        setting.addTarget(self, action: #selector(click(_:)), for: .touchUpInside)
        setting.tag = MineList_MeCellBtnTag.set.rawValue
        back.addSubview(setting)
        _ = setting.sd_layout()?
            .topSpaceToView(back,(HEIGHT == 812 ? 44 : 20))?
            .rightSpaceToView(back,GET_SIZE * 30)?
            .widthIs(44)?
            .heightIs(44)
        
        meView.isUserInteractionEnabled = true
        meView.image = getChangeIMG(NSInteger(GET_SIZE * 132))
        back.addSubview(meView)
        _ = meView.sd_layout()?
            .topSpaceToView(back,(HEIGHT == 812 ? 44 : 20) + 44)?
            .leftSpaceToView(back,0)?
            .widthIs(WIDTH)?
            .heightIs(GET_SIZE * 132)
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(touchMe))
        meView.addGestureRecognizer(tap)
        
        head.contentMode = .scaleAspectFill
        head.layer.cornerRadius = GET_SIZE * 96/2
        head.layer.masksToBounds = true
        meView.addSubview(head)
        head.image = UIImage(named:"UserHead_icon_default_66")
        _ = head.sd_layout()?
            .centerYEqualToView(meView)?
            .leftSpaceToView(meView,GET_SIZE * 32)?
            .widthIs(GET_SIZE * 96)?
            .heightIs(GET_SIZE * 96)
        
        name.textColor = UIColor.white
        name.font = UIFont.systemFont(ofSize: GET_SIZE * 46)
        name.textAlignment = .left
        meView.addSubview(name)
        _ = name.sd_layout()?
            .centerYEqualToView(meView)?
            .leftSpaceToView(head,GET_SIZE * 44)?
            .widthIs(WIDTH/2)?
            .heightIs(GET_SIZE * 32)
        
        //性别标记
        meView.addSubview(sex)
        _ = sex.sd_layout()?
            .centerYEqualToView(meView)?
            .leftSpaceToView(name,GET_SIZE * 12)?
            .widthIs(GET_SIZE * 24)?
            .heightIs(GET_SIZE * 24)
        
        goOn.image = UIImage(named:"go_icon_b")
        meView.addSubview(goOn)
        _ = goOn.sd_layout()?
            .centerYEqualToView(meView)?
            .rightSpaceToView(meView,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 14)?
            .heightIs(GET_SIZE * 26)
        
        for index in 0..<3 {
            let btn = UIButton()
            btn.tag = 102 + index
            btn.setTitleColor(UIColor.white, for: .normal)
            btn.addTarget(self, action: #selector(click(_:)), for: .touchUpInside)
            back.addSubview(btn)
            _ = btn.sd_layout()?
                .leftSpaceToView(back,WIDTH/3 * CGFloat(index))?
                .bottomSpaceToView(back,0)?
                .widthIs(WIDTH/3)?
                .heightIs(GET_SIZE * 180)
        }
    }
        
    @objc private func click(_ btn: UIButton) {
        
//        //设置
//        case set = 100
//        //我 关注 粉丝 日记 收藏
//        case me, follow, fans, note, collection
        switch btn.tag {
            
            //设置
        case MineList_MeCellBtnTag.set.rawValue:
            let view = NewSettingsViewController()
            viewController()?.navigationController?.pushViewController(view, animated: true)
            break
            
        case MineList_MeCellBtnTag.follow.rawValue:
            let view = NewMineFollowViewController()
            view.type = MineList_MeCellBtnTag.follow
            viewController()?.navigationController?.pushViewController(view, animated: true)
            break
            
            
        case MineList_MeCellBtnTag.fans.rawValue:
            let view = NewMineFollowViewController()
            view.type = MineList_MeCellBtnTag.fans
            viewController()?.navigationController?.pushViewController(view, animated: true)
            break
            
            
        case MineList_MeCellBtnTag.note.rawValue:
            let view = NewMineNoteViewController()
            viewController()?.navigationController?.pushViewController(view, animated: true)
            break
            
            
        case MineList_MeCellBtnTag.collection.rawValue:
            let view = NewMineCollectionViewController()
            viewController()?.navigationController?.pushViewController(view, animated: true)
            break
            
            
        default:
            break
        }
    }
    
    @objc private func touchMe() {
        let me = newMineMeViewController()
        me.id = _model!.id
        me.isMe = true
        viewController()?.navigationController?.pushViewController(me, animated: true)
    }
    
    func buildData() {
        
        name.text = "李柏林"
        
        var btn = viewWithTag(MineList_MeCellBtnTag.follow.rawValue) as! UIButton
        followLab.textColor = UIColor.white
        followLab.font = UIFont.systemFont(ofSize: GET_SIZE * 42)
        followLab.textAlignment = .center
        btn.addSubview(followLab)
        _ = followLab.sd_layout()?
            .topSpaceToView(btn,0)?
            .leftSpaceToView(btn,0)?
            .rightSpaceToView(btn,0)?
            .bottomSpaceToView(btn,0)
        followLab.lineBreakMode = .byWordWrapping
        followLab.numberOfLines = 0
        followLab.text = "20\n关注"
        
        btn = viewWithTag(MineList_MeCellBtnTag.fans.rawValue) as! UIButton
        fansLab.textColor = UIColor.white
        fansLab.font = UIFont.systemFont(ofSize: GET_SIZE * 42)
        fansLab.textAlignment = .center
        btn.addSubview(fansLab)
        _ = fansLab.sd_layout()?
            .topSpaceToView(btn,0)?
            .leftSpaceToView(btn,0)?
            .rightSpaceToView(btn,0)?
            .bottomSpaceToView(btn,0)
        fansLab.lineBreakMode = .byWordWrapping
        fansLab.numberOfLines = 0
        fansLab.text = "20\n粉丝"
        
        btn = viewWithTag(MineList_MeCellBtnTag.note.rawValue) as! UIButton
        noteLab.textColor = UIColor.white
        noteLab.font = UIFont.systemFont(ofSize: GET_SIZE * 42)
        noteLab.textAlignment = .center
        btn.addSubview(noteLab)
        _ = noteLab.sd_layout()?
            .topSpaceToView(btn,0)?
            .leftSpaceToView(btn,0)?
            .rightSpaceToView(btn,0)?
            .bottomSpaceToView(btn,0)
        noteLab.lineBreakMode = .byWordWrapping
        noteLab.numberOfLines = 0
        noteLab.text = "20\n日志"
    }
}
