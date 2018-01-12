//
//  newMineNoteListTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/16.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftyJSON

var tmpImg = UIImage()

class NewMineNoteListTableViewCell: Wx_baseTableViewCell {
    
    private var _model : NewMain_NoteListModel?
    var model : NewMain_NoteListModel? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    
    private func didSetModel(_ model: NewMain_NoteListModel) {

        head.kf.setImage(with: URL.init(string: model.photo))
        
        name.text = model.nickName
        time.text = model.createDate
        
        if model.allowFollow {
            if model.follow {
                follow.setTitle("已关注", for: .normal)
                follow.setTitleColor(getColorWithNotAlphe(0xB2B2B2), for: .normal)
                follow.layer.borderColor = getColorWithNotAlphe(0xB2B2B2).cgColor
            }else {
                follow.setTitle("+ 关注", for: .normal)
                follow.setTitleColor(tabbarColor, for: .normal)
                follow.layer.borderColor = tabbarColor.cgColor
            }
        }else {
            follow.isHidden = true
        }
        
        note.text = model.content
        detail.text = model.content
        
        leftImg.kf.setImage(with: URL.init(string: model.preopImages))
        rightImg.kf.setImage(with: URL.init(string: model.images))
        
        name.text = model.nickName
        btnArr[0].setImage(UIImage(named:"24_browse_icon_default"), for: .normal)
        btnArr[0].setTitle("浏览 · \(model.hits)", for: .normal)
        btnArr[0].layoutButton(with: .left, imageTitleSpace: 5)
        
        btnArr[1].setImage(UIImage(named:"25_comment_icon_default"), for: .normal)
        btnArr[1].setTitle("评论 · \(model.comments)", for: .normal)
        btnArr[1].layoutButton(with: .left, imageTitleSpace: 5)
        
        //选中后  23_appreciate_icon_pressed
        btnArr[2].setImage(UIImage(named:"22_appreciate_icon_default"), for: .normal)
        btnArr[2].setTitle("赞 · \(model.thumbs)", for: .normal)
        btnArr[2].layoutButton(with: .left, imageTitleSpace: 5)
    }
    
    let head = UIImageView()
    let name = UILabel()
    let time = UILabel()
    let follow = UIButton()
    
    let imgView = UIView()
    let note = UILabel()
    
    let detailImg = UIImageView()
    let detail = UILabel()
    
    let line = UIView()
    
    let reView = UIButton()
    let comment = UIButton()
    let assit = UIButton()
    
    let leftImg = UIImageView()
    let leftLabel = UIImageView()
    let rightImg = UIImageView()
    let rightLabel = UIImageView()
    
    let line2 = UIView()
    
    let bottomLine = UIView()

    var imgArr = [UIImageView]()
    var btnArr = [UIButton(),UIButton(),UIButton()]

    let Vline1 = UIView()
    let Vline2 = UIView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildUI() {
        
        //图像
        contentView.addSubview(head)
        head.contentMode = .scaleAspectFill
        _ = head.sd_layout()?
            .topSpaceToView(contentView,GET_SIZE * 24)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 90)?
            .heightIs(GET_SIZE * 90)
        viewRadius(head, Float(head.width/2), 0.5, lineColor)
        head.isUserInteractionEnabled = true
        let toUser = UITapGestureRecognizer.init(target: self, action: #selector(gotoUser))
        head.addGestureRecognizer(toUser)
        
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
        
        //关注
        follow.setTitle("关注+", for: .normal)
        follow.backgroundColor = backGroundColor
        follow.setTitleColor(tabbarColor, for: .normal)
        follow.titleLabel?.font = UIFont.systemFont(ofSize: GET_SIZE * 32)
        follow.addTarget(self, action: #selector(followAction), for: .touchUpInside)
        viewRadius(follow, 5.0, 0.5, tabbarColor)
        contentView.addSubview(follow)
        _ = follow.sd_layout()?
            .centerYEqualToView(head)?
            .rightSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 150)?
            .heightIs(GET_SIZE * 64)
        
        //日记具体内容
        note.textColor = UIColor.black
        note.numberOfLines = 3
        note.font = UIFont.systemFont(ofSize: GET_SIZE * 26)
        contentView.addSubview(note)
        _ = note.sd_layout()?
            .topSpaceToView(head,5)?
            .leftSpaceToView(contentView,GET_SIZE * 30)?
            .rightSpaceToView(contentView,GET_SIZE * 30)?
            .maxHeightIs(GET_SIZE * 95)
//        .bottomSpaceToView(leftImg.top_sd,5)
        
        leftImg.contentMode = .scaleAspectFill
        leftImg.tag = 100
        leftImg.layer.masksToBounds = true
//        leftImg.frame = CGRect.init(x: 50, y: 50, width: 150, height: 150)
        contentView.addSubview(leftImg)
        _ = leftImg.sd_layout()?
            .topSpaceToView(note,12)?
            .leftSpaceToView(contentView,GET_SIZE * 25)?
            .widthIs(GET_SIZE * 340)?
            .heightIs(GET_SIZE * 300)
        leftLabel.image = UIImage(named:"41_before_tag_default")
        leftImg.addSubview(leftLabel)
        _ = leftLabel.sd_layout()?
            .bottomSpaceToView(leftImg,0)?
            .leftSpaceToView(leftImg,0)?
            .widthIs(GET_SIZE * 80)?
            .heightIs(GET_SIZE * 28)
        
        rightImg.contentMode = .scaleAspectFill
        rightImg.tag = 101
        rightImg.layer.masksToBounds = true
        contentView.addSubview(rightImg)
        _ = rightImg.sd_layout()?
            .topSpaceToView(note,12)?
            .rightSpaceToView(contentView,GET_SIZE * 25)?
            .widthIs(GET_SIZE * 340)?
            .heightIs(GET_SIZE * 300)
        rightLabel.image = UIImage(named:"37_after_tag_default")
        rightImg.addSubview(rightLabel)
        _ = rightLabel.sd_layout()?
            .bottomSpaceToView(rightImg,0)?
            .leftSpaceToView(rightImg,0)?
            .widthIs(GET_SIZE * 80)?
            .heightIs(GET_SIZE * 28)
        
        //所做的项目
        // 暂时隐藏了  暂时取消这个 这里应该是用作 所做的项目
        detailImg.image = UIImage(named:"26_tag_icon_default")
        contentView.addSubview(detailImg)
        _ = detailImg.sd_layout()?
            .topSpaceToView(leftImg,4)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 30)?
            .heightIs(GET_SIZE * 30)
        detailImg.isHidden = true
        
        detail.textColor = UIColor.black
        detail.font = UIFont.systemFont(ofSize: GET_SIZE * 26)
        contentView.addSubview(detail)
        _ = detail.sd_layout()?
            .centerYEqualToView(detailImg)?
            .leftSpaceToView(detailImg,4)?
            .rightSpaceToView(contentView,GET_SIZE * 24)?
            .heightIs(GET_SIZE * 28)
        detail.isHidden = true

        line2.backgroundColor = lineColor
        contentView.addSubview(line2)
        _ = line2.sd_layout()?
            .topSpaceToView(leftImg,12)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(WIDTH)?
            .heightIs(0.5)
        
        for index in 0..<btnArr.count {
            
            contentView.addSubview(btnArr[index])
            btnArr[index].titleLabel?.font = UIFont.systemFont(ofSize: GET_SIZE * 20)
            btnArr[index].setTitleColor(UIColor.black, for: .normal)
            _ = btnArr[index].sd_layout()?
                .topSpaceToView(line2,0)?
                .leftSpaceToView(contentView,WIDTH/3*CGFloat(index))?
                .widthIs(WIDTH/3)?
                .bottomSpaceToView(contentView,1)
        }
        
        Vline1.backgroundColor = lineColor
        contentView.addSubview(Vline1)
        _ = Vline1.sd_layout()?
            .centerYEqualToView(btnArr[0])?
            .leftSpaceToView(contentView,WIDTH/3)?
            .widthIs(1)?
            .heightIs(GET_SIZE * 33)
        
        Vline2.backgroundColor = lineColor
        contentView.addSubview(Vline2)
        _ = Vline2.sd_layout()?
            .centerYEqualToView(btnArr[0])?
            .leftSpaceToView(contentView,WIDTH/3*2)?
            .widthIs(1)?
            .heightIs(GET_SIZE * 28)
        
        bottomLine.backgroundColor = lineColor
        contentView.addSubview(bottomLine)
        _ = bottomLine.sd_layout()?
            .bottomSpaceToView(contentView,0)?
            .leftSpaceToView(contentView,0)?
            .widthIs(WIDTH)?
            .heightIs(1)
        
//        /Users/wuxuan/Desktop/heathAndBeauty/healthAndBeautyUser/Pods/Pods.xcodeproj Couldn't load project
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(showImageView(_:)))
        leftImg.addGestureRecognizer(tap)
        leftImg.isUserInteractionEnabled = true
        
        let tap2 = UITapGestureRecognizer.init(target: self, action: #selector(showImageView(_:)))
        rightImg.addGestureRecognizer(tap2)
        rightImg.isUserInteractionEnabled = true
    }
    
    @objc private func showImageView(_ sender: UITapGestureRecognizer) {

        let watchIMGItem = KSPhotoItem.init(sourceView: leftImg, image: leftImg.image)
        let watchIMGItem2 = KSPhotoItem.init(sourceView: rightImg, image: rightImg.image)
        let watchIMGView = KSPhotoBrowser.init(photoItems: [watchIMGItem!,watchIMGItem2!],
                                               selectedIndex: (sender.view?.tag == 100) ? 0 : 1)
        watchIMGView?.dismissalStyle = .scale
        watchIMGView?.backgroundStyle = .blurPhoto
        watchIMGView?.loadingStyle = .indeterminate
        watchIMGView?.pageindicatorStyle = .text
        watchIMGView?.bounces = false
        watchIMGView?.show(from: viewController()!)
    }
    
    @objc private func followController() {
        
        var up = [String : Any]()
        
        if Defaults.hasKey("SESSIONID") {
            up["mobileCode"] = Defaults["mobileCode"].stringValue
            up["SESSIONID"] = Defaults["SESSIONID"].stringValue
        }else {
            SVPwillShowAndHide("请登陆后重试")
            return
        }
        
        up["concernedBy"] = _model!.personald
        up["followType"] = "1"
        
        var url = String()

        if !_model!.follow {
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
                if !self._model!.follow {
                    SVPwillSuccessShowAndHide("关注成功")
                    self.follow.setTitle("已关注", for: .normal)
                    self.follow.setTitleColor(getColorWithNotAlphe(0xB2B2B2), for: .normal)
                    self.follow.layer.borderColor = getColorWithNotAlphe(0xB2B2B2).cgColor
                    self._model!.follow = true
                }else {
                    SVPwillSuccessShowAndHide("取消关注成功")
                    self.follow.setTitle("+ 关注", for: .normal)
                    self.follow.setTitleColor(tabbarColor, for: .normal)
                    self.follow.layer.borderColor = tabbarColor.cgColor
                    self._model!.follow = false
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
        
        if _model!.follow {
            
            let alert = UIAlertController.init(title: "提示", message: "确定要取消关注吗？", preferredStyle: .alert)
            
            let action1 = UIAlertAction.init(title: "确定", style: .destructive) { (alertAction) in
                self.followController()
            }
            let action2 = UIAlertAction.init(title: "取消", style: .cancel) { (alertAction) in
                return
            }
            
            alert.addAction(action1)
            alert.addAction(action2)
            
            viewController()?.present(alert, animated: true, completion: nil)
            
        }else{
            followController()
        }
    }

    
    
    @objc private func gotoUser() {
        
        let me = newMineMeViewController()
        me.id = _model!.personald
        me.isMe = false
        viewController()?.navigationController?.pushViewController(me, animated: true)
    }
}
