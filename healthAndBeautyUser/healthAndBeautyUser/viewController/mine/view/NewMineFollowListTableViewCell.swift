

//
//  newMineFollowListTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/16.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewMineFollowListTableViewCell: Wx_baseTableViewCell {
        
    private var _model : NewMineFollowListModel?
    var model : NewMineFollowListModel? {
        didSet {
            _model = model
            self.didSetModel(_model!)
        }
    }
    
    private func didSetModel(_ model: NewMineFollowListModel) {
        
        if model.isUser {
            
            icon.kf.setImage(with: StringToUTF_8InUrl(str: model.photo))
            name.text = model.nickName
            age.text = model.age + "岁"
            city.text = "用户"
            let sizes = getSizeOnLabel(name)
            _ = name.sd_layout()?
                .bottomSpaceToView(age,2)?
                .leftSpaceToView(icon,6)?
                .widthIs(sizes.width)?
                .heightIs(GET_SIZE * 30)
            if model.gender == "1" {
                sex.image = UIImage(named:"na")
            }else {
                sex.image = UIImage(named:"nv")
            }
            _ = sex.sd_layout()?
                .centerYEqualToView(name)?
                .leftSpaceToView(name,GET_SIZE * 10)?
                .widthIs(GET_SIZE * 28)?
                .heightIs(GET_SIZE * 28)
        }else {
            icon.kf.setImage(with: StringToUTF_8InUrl(str: model.headImage))
            name.text = model.doctorName
            age.text = model.currentPosition + "-" + model.education
            city.text = model.doctorPrensent
            let sizes = getSizeOnLabel(name)
            _ = name.sd_layout()?
                .bottomSpaceToView(age,2)?
                .leftSpaceToView(icon,6)?
                .widthIs(sizes.width)?
                .heightIs(GET_SIZE * 30)
            if model.sex == "1" {
                sex.image = UIImage(named:"na")
            }else {
                sex.image = UIImage(named:"nv")
            }
            _ = sex.sd_layout()?
                .centerYEqualToView(name)?
                .leftSpaceToView(name,GET_SIZE * 10)?
                .widthIs(GET_SIZE * 28)?
                .heightIs(GET_SIZE * 28)
        }
        
        if model.isFollow {
            self.follow.setTitle("已关注", for: .normal)
            self.follow.setTitleColor(tabbarColor, for: .normal)
            self.follow.layer.borderColor = tabbarColor.cgColor
        }else {
            self.follow.setTitle("+ 关注", for: .normal)
            self.follow.setTitleColor(getColorWithNotAlphe(0xB2B2B2), for: .normal)
            self.follow.layer.borderColor = getColorWithNotAlphe(0xB2B2B2).cgColor
        }
    }
    
    let icon = UIImageView()
    
    let name = UILabel()
    let sex = UIImageView()

    let age = UILabel()
    
    let cityIMG = UIImageView()
    let city = UILabel()
    
    let follow = UIButton()
    
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
        
        contentView.addSubview(icon)
        icon.contentMode = .scaleAspectFill
        _ = icon.sd_layout()?
            .centerYEqualToView(contentView)?
            .leftSpaceToView(contentView,GET_SIZE * 21)?
            .widthIs(GET_SIZE * 88)?
            .heightIs(GET_SIZE * 88)
        viewRadius(icon, Float(icon.width/2), 0.5, lightText)
        
        follow.setTitle("已关注", for: .normal)
        follow.backgroundColor = backGroundColor
        follow.titleLabel?.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        viewRadius(follow, 5.0, 0.5, tabbarColor)
        contentView.addSubview(follow)
        _ = follow.sd_layout()?
            .centerYEqualToView(contentView)?
            .rightSpaceToView(contentView,GET_SIZE * 44)?
            .widthIs(GET_SIZE * 120)?
            .heightIs(GET_SIZE * 48)
        follow.setTitleColor(tabbarColor, for: .normal)
        follow.layer.borderColor = tabbarColor.cgColor
        follow.addTarget(self, action: #selector(followController), for: .touchUpInside)
        
        age.textColor = darkText
        age.font = UIFont.systemFont(ofSize: GET_SIZE * 26)
        age.textAlignment = .left
        contentView.addSubview(age)
        _ = age.sd_layout()?
            .centerYEqualToView(contentView)?
            .leftSpaceToView(icon,GET_SIZE * 18)?
            .widthIs(GET_SIZE * 250)?
            .heightIs(GET_SIZE * 28)
        
        name.textColor = darkText
        name.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        name.textAlignment = .left
        contentView.addSubview(name)
        _ = name.sd_layout()?
            .bottomSpaceToView(age,3)?
            .leftSpaceToView(icon,6)?
            .widthIs(GET_SIZE * 250)?
            .heightIs(GET_SIZE * 30)

        contentView.addSubview(sex)
        _ = sex.sd_layout()?
            .centerYEqualToView(name)?
            .leftSpaceToView(name,GET_SIZE * 10)?
            .widthIs(GET_SIZE * 28)?
            .heightIs(GET_SIZE * 28)
        
        cityIMG.image = UIImage(named:"wz")
        contentView.addSubview(cityIMG)
        _ = cityIMG.sd_layout()?
            .topSpaceToView(age, 3)?
            .leftSpaceToView(icon,6)?
            .widthIs(GET_SIZE * 19)?
            .heightIs(GET_SIZE * 22)
        
        city.textColor = darkText
        city.font = UIFont.systemFont(ofSize: GET_SIZE * 26)
        city.textAlignment = .left
        contentView.addSubview(city)
        _ = city.sd_layout()?
            .centerYEqualToView(cityIMG)?
            .leftSpaceToView(cityIMG,3)?
            .rightSpaceToView(follow, GET_SIZE * 24)?
            .heightIs(GET_SIZE * 30)
        
        let line = UIView()
        line.backgroundColor = lineColor
        contentView.addSubview(line)
        _ = line.sd_layout()?
            .bottomSpaceToView(contentView,0)?
            .leftSpaceToView(contentView,0)?
            .widthIs(WIDTH)?
            .heightIs(0.5)
    } 
    
    @objc private func followController() {
        
        //    allowFollow  是否允许关注 true允许  false 不允许(即日记文章的作者为登录对象,自己不允许关注自己)
        //    follow       是否关注过  true已关注 false 未关注

        var up = [String : Any]()

        if Defaults.hasKey("SESSIONID") {
            up["mobileCode"] = Defaults["mobileCode"].stringValue
            up["SESSIONID"] = Defaults["SESSIONID"].stringValue
        }else {
            SVPwillShowAndHide("请登陆后重试")
            return
        }

        if _model!.isUser {
            up["followType"] = "1"
            up["concernedBy"] = _model!.userId
        }else {
            up["followType"] = "2"
            up["concernedBy"] = _model!.doctorId
        }

        var url = String()

        if !_model!.isFollow {
            url = addFollowJoggle
        }else {
            url = getUnfollowJoggle
        }
        SVPWillShow("载入中...")
        delog(up)

        Net.share.getRequest(urlString: url, params: up, success: { (datas) in
            let json = JSON(datas)
            delog(json)
            SVPHide()
            if json["code"].int == 1 {
                if !self._model!.isFollow {
                    SVPwillSuccessShowAndHide("关注成功")
                    self.follow.setTitle("已关注", for: .normal)
                    self.follow.setTitleColor(tabbarColor, for: .normal)
                    self.follow.layer.borderColor = tabbarColor.cgColor

                    self._model!.isFollow = true
                }else {
                    SVPwillSuccessShowAndHide("取消关注成功")
                    self.follow.setTitle("+ 关注", for: .normal)
                    self.follow.setTitleColor(getColorWithNotAlphe(0xB2B2B2), for: .normal)
                    self.follow.layer.borderColor = getColorWithNotAlphe(0xB2B2B2).cgColor
                    
                    self._model!.isFollow = false
                }
            }else {
                SVPwillShowAndHide(json["message"].string!)
            }
        }) { (error) in
            delog(error)
            SVPwillShowAndHide("请检查您的网路")
        }
    }
}
