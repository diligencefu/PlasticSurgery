//
//  NewMainMe_meTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/26.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewMainMe_meTableViewCell: Wx_baseTableViewCell {
    
    var isMe = false
    
    private var _model : NewMineMeModel?
    var model : NewMineMeModel? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    
    private func didSetModel(_ model: NewMineMeModel) {
        
        head.kf.setImage(with: StringToUTF_8InUrl(str: model.photo))
        name.text = model.nickName
        followLab.text = "关注 \(model.follow)"
        fansLab.text = "粉丝 \(model.fans)"
        
        if isMe {
            
            follow.isHidden = true
            sendMessage.isHidden = true
        }else {
            
            follow.isHidden = false
            sendMessage.isHidden = false
            if model.isFollow {
                follow.setTitle("已关注", for: .normal)
                follow.backgroundColor = UIColor.white
                follow.setTitleColor(lightText, for: .normal)
                follow.layer.borderColor = lightText.cgColor
            }else {
                follow.setTitle("+ 关注", for: .normal)
                follow.backgroundColor = tabbarColor
                follow.setTitleColor(UIColor.white, for: .normal)
                follow.layer.borderColor = tabbarColor.cgColor
            }
        }
    }
    
    let head = UIImageView()
    
    let name = UILabel()
    
    let followLab = UILabel()
    let line = UIView()
    let fansLab = UILabel()
    
    let follow = UIButton()
    let sendMessage = UIButton()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.white
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func buildUI() {
        
        head.contentMode = .scaleAspectFill
        head.image = UIImage(named:"UserHead_icon_default_66")
        viewRadius(head, Float(GET_SIZE * 80), 0.5, lightText)
        contentView.addSubview(head)
        _ = head.sd_layout()?
            .centerXEqualToView(contentView)?
            .topSpaceToView(contentView,4)?
            .widthIs(GET_SIZE * 160)?
            .heightIs(GET_SIZE * 160)
        
        name.textColor = darkText
        name.font = UIFont.systemFont(ofSize: GET_SIZE * 36)
        name.textAlignment = .center
        contentView.addSubview(name)
        _ = name.sd_layout()?
            .centerXEqualToView(contentView)?
            .topSpaceToView(head,GET_SIZE * 10)?
            .widthIs(WIDTH/2)?
            .heightIs(GET_SIZE * 38)
        
        line.backgroundColor = lightText
        contentView.addSubview(line)
        _ = line.sd_layout()?
            .topSpaceToView(name,GET_SIZE * 24)?
            .centerXEqualToView(contentView)?
            .widthIs(0.5)?
            .heightIs(GET_SIZE * 32)
        
        followLab.textColor = lightText
        followLab.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        followLab.textAlignment = .right
        contentView.addSubview(followLab)
        _ = followLab.sd_layout()?
            .centerYEqualToView(line)?
            .rightSpaceToView(line,GET_SIZE * 24)?
            .widthIs(WIDTH/4)?
            .heightIs(GET_SIZE * 30)
        
        fansLab.textColor = lightText
        fansLab.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        fansLab.textAlignment = .left
        contentView.addSubview(fansLab)
        _ = fansLab.sd_layout()?
            .centerYEqualToView(line)?
            .leftSpaceToView(line,GET_SIZE * 24)?
            .widthIs(WIDTH/4)?
            .heightIs(GET_SIZE * 30)
        
        follow.setTitle("关注", for: .normal)
        follow.setTitleColor(UIColor.white, for: .normal)
        follow.addTarget(self, action: #selector(followAction), for: .touchUpInside)
        contentView.addSubview(follow)
        _ = follow.sd_layout()?
            .centerXEqualToView(followLab)?
            .topSpaceToView(followLab,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 149)?
            .heightIs(GET_SIZE * 48)
        follow.layer.cornerRadius = 5.0
        follow.titleLabel?.font = UIFont.systemFont(ofSize: GET_SIZE * 26)
        follow.layer.borderWidth = 0.5
        
        sendMessage.setTitle("私信他", for: .normal)
        sendMessage.setTitleColor(lightText, for: .normal)
        sendMessage.addTarget(self, action: #selector(sendMessageClick), for: .touchUpInside)
        contentView.addSubview(sendMessage)
        _ = sendMessage.sd_layout()?
            .centerXEqualToView(fansLab)?
            .topSpaceToView(fansLab,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 149)?
            .heightIs(GET_SIZE * 48)
        sendMessage.layer.cornerRadius = 5.0
        sendMessage.backgroundColor = UIColor.white
        sendMessage.layer.borderColor = lightText.cgColor
        sendMessage.layer.borderWidth = 0.5
        sendMessage.titleLabel?.font = UIFont.systemFont(ofSize: GET_SIZE * 26)
    }
    
    //返回上一级
    @objc private func back() {
        viewController()?.navigationController?.popViewController(animated: true)
    }
    
    @objc private func editClick() {
        
    }
    
    @objc private func followClick() {
        
        var up = [String : Any]()
        
        if Defaults.hasKey("SESSIONID") {
            up["mobileCode"] = Defaults["mobileCode"].stringValue
            up["SESSIONID"] = Defaults["SESSIONID"].stringValue
        }else {
            SVPwillShowAndHide("请登陆后重试")
            return
        }
        
        up["concernedBy"] = _model!.id
        up["followType"] = "1"
        
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
                    self.follow.setTitleColor(getColorWithNotAlphe(0xB2B2B2), for: .normal)
                    self.follow.layer.borderColor = getColorWithNotAlphe(0xB2B2B2).cgColor
                    self._model!.isFollow = true
                }else {
                    SVPwillSuccessShowAndHide("取消关注成功")
                    self.follow.setTitle("+ 关注", for: .normal)
                    self.follow.setTitleColor(tabbarColor, for: .normal)
                    self.follow.layer.borderColor = tabbarColor.cgColor
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
    
    func followAction() {
        
        if _model!.isFollow {
            
            
            let alert = UIAlertController.init(title: "提示", message: "确定要取消关注吗？", preferredStyle: .alert)
            
            let action1 = UIAlertAction.init(title: "确定", style: .destructive) { (alertAction) in
                self.followClick()
            }
            let action2 = UIAlertAction.init(title: "取消", style: .cancel) { (alertAction) in
                return
            }
            
            alert.addAction(action1)
            alert.addAction(action2)
            
            viewController()?.present(alert, animated: true, completion: nil)
            
        }else{
            followClick()
        }
    }
    

    
    
    @objc private func sendMessageClick() {
        
    }
}
