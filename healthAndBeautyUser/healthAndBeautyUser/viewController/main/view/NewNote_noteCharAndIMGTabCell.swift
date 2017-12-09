//
//  NewNote_noteCharAndIMGTabCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/9/26.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewNote_noteCharAndIMGTabCell: Wx_baseTableViewCell {
    
    //点击事件
    typealias swiftBlock = (_ type:String) -> Void
    var willClick : swiftBlock? = nil
    func callBackBlock(block: @escaping (_ type:String) -> Void ) {
        willClick = block
    }
    
    var arr = [String]()
    var imgArr = [UIImageView]()

    private var _model : NewNoteEnterDetail_2Model?
    var model : NewNoteEnterDetail_2Model? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    
    private func didSetModel(_ model: NewNoteEnterDetail_2Model) {
        
        date.text = model.article.title
        
        //日记内容尺寸
        detail.text = model.article.content
        let size = getSizeOnString(model.article.content, 14)
        _ = detail.sd_layout()?
            .topSpaceToView(date,GET_SIZE * 24)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 700)?
            .heightIs(size.height + 5)
        
        if model.isThumb {
            thumbsIMG.image = UIImage(named:"red_zan")
        }else {
            thumbsIMG.image = UIImage(named:"zan")
        }
        thumbs.text = "\(model.article.thumbs)"
        
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
            .heightIs(GET_SIZE * CGFloat(584 * model.article.imageList.count))
        tmp.removeAll()
        
        for index in 0..<model.article.imageList.count {
            
            let img = UIImageView()
            img.kf.setImage(with: StringToUTF_8InUrl(str: model.article.imageList[index]))
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
        
        //浏览数目
//        watchIMG.image = UIImage(named:"24_browse_icon_default")
//        _ = watchIMG.sd_layout()?
//            .topSpaceToView(imgView,0)?
//            .rightSpaceToView(contentView,GET_SIZE * 150)?
//            .widthIs(GET_SIZE * 36)?
//            .heightIs(GET_SIZE * 36)
//
//        watch.text = "浏览 · \(model.article.hits)"
//        _ = watch.sd_layout()?
//            .centerYEqualToView(watchIMG)?
//            .leftSpaceToView(watchIMG,2)?
//            .rightSpaceToView(contentView,GET_SIZE * 28)?
//            .heightIs(GET_SIZE * 30)
        
        if model.isMe {
            
            reward.isHidden = true
            thumb.isHidden = true
        }else {
            
            reward.isHidden = false
            
            _ = reward.sd_layout()?
                .topSpaceToView(imgView,GET_SIZE * 54)?
                .centerXEqualToView(contentView)?
                .widthIs(GET_SIZE * 240)?
                .heightIs(GET_SIZE * 72)
            viewRadius(reward, 5.0, 0.5, redText)
            
            thumb.isHidden = false
        }
        
        if model.personals.count != 0 {
            
            rewardViwe = UIView()
            contentView.addSubview(rewardViwe)
            _ = rewardViwe.sd_layout()?
                .topSpaceToView(reward,GET_SIZE * 24)?
                .centerXEqualToView(contentView)?
                .widthIs(WIDTH)?
                .heightIs(GET_SIZE * 108)
            
            let head = UIImageView()
            head.kf.setImage(with: StringToUTF_8InUrl(str: model.personals[0].photo))
            head.contentMode = .scaleAspectFill
            rewardViwe.addSubview(head)
            _ = head.sd_layout()?
                .centerYEqualToView(rewardViwe)?
                .centerXEqualToView(rewardViwe)?
                .widthIs(GET_SIZE * 88)?
                .heightIs(GET_SIZE * 88)
            viewRadius(head, Float(GET_SIZE * 44), 0.5, lineColor)
            
            let more = UIImageView()
            more.image = UIImage(named:"00_go_icon_default")
            rewardViwe.addSubview(more)
            _ = more.sd_layout()?
                .centerYEqualToView(rewardViwe)?
                .rightSpaceToView(rewardViwe,GET_SIZE * 24)?
                .widthIs(GET_SIZE * 14)?
                .heightIs(GET_SIZE * 26)
            
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(clickRewardMen))
            rewardViwe.addGestureRecognizer(tap)
        }
    }
    
    @objc private func clickRewardMen() {
        
        let rewardList = NewAllRewarderMenViewController.init(nibName: "NewAllRewarderMenViewController", bundle: nil)
        rewardList.id = _model!.article.id
        viewController()?.navigationController?.pushViewController(rewardList, animated: true)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let date = UILabel()
    let thumb = UIButton()
    let thumbsIMG = UIImageView()
    let thumbs = UILabel()
    let detail = UILabel()
    let watchIMG = UIImageView()
    let watch = UILabel()
    let reward = UIButton()
    
    let imgView = UIView()
    
    var rewardViwe = UIView()
    
    let line = UIView()
    var tmp = [UIImageView]()
    
    private func buildUI() {
        
        //日期 术后第几天
        #if DEBUG
            detail.text = "金坷垃，种庄稼，不流失不蒸发，吸收5米以下氮磷钾，亩产1800，8000名美国特种兵日夜守候，美国上帝压狗。。金坷垃，种庄稼，不流失不蒸发，吸收5米以下氮磷钾，亩产1800，8000名美国特种兵日夜守候，美国上帝压狗。。金坷垃，种庄稼，不流失不蒸发，吸收5米以下氮磷钾，亩产1800，8000名美国特种兵日夜守候，美国上帝压狗。。金坷垃，种庄稼，不流失不蒸发，吸收5米以下氮磷钾，亩产1800，8000名美国特种兵日夜守候，美国上帝压狗"
        #endif
        date.textColor = UIColor.white
        date.backgroundColor = redText
        date.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        date.textAlignment = .center
        contentView.addSubview(date)
        _ = date.sd_layout()?
            .topSpaceToView(contentView,GET_SIZE * 24)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 210)?
            .heightIs(GET_SIZE * 48)
        viewRadius(date, Float(date.height/2), 0.5, redText)
        
        //点赞数
        thumbsIMG.image = UIImage(named:"23_appreciate_icon_pressed")
        contentView.addSubview(thumbsIMG)
        _ = thumbsIMG.sd_layout()?
            .centerYEqualToView(date)?
            .rightSpaceToView(contentView,GET_SIZE * 110)?
            .widthIs(GET_SIZE * 22)?
            .heightIs(GET_SIZE * 23)
        
        thumbs.textColor = lightText
        thumbs.font = UIFont.systemFont(ofSize: GET_SIZE * 24)
        thumbs.textAlignment = .left
        contentView.addSubview(thumbs)
        _ = thumbs.sd_layout()?
            .centerYEqualToView(thumbsIMG)?
            .leftSpaceToView(thumbsIMG,7)?
            .rightSpaceToView(contentView,GET_SIZE * 28)?
            .heightIs(GET_SIZE * 26)
        
        thumb.addTarget(self, action: #selector(thumbClick), for: .touchUpInside)
        contentView.addSubview(thumb)
        _ = thumb.sd_layout()?
            .centerYEqualToView(thumbsIMG)?
            .rightSpaceToView(contentView,GET_SIZE * 20)?
            .widthIs(WIDTH/4)?
            .heightIs(GET_SIZE * 62)
        
        //日记内容尺寸
        detail.textColor = darkText
        detail.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        detail.textAlignment = .left
        contentView.addSubview(detail)
        _ = detail.sd_layout()?
            .topSpaceToView(date,GET_SIZE * 24)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 700)?
            .heightIs(GET_SIZE * 120)
        detail.numberOfLines = 0
        detail.lineBreakMode = .byCharWrapping
        
        contentView.addSubview(imgView)
        contentView.addSubview(watchIMG)
        watch.textColor = lightText
        watch.font = UIFont.systemFont(ofSize: GET_SIZE * 18)
        watch.textAlignment = .left
        contentView.addSubview(watch)
        
        reward.setTitle("打赏", for: .normal)
        reward.backgroundColor = redText
        reward.setTitleColor(UIColor.white, for: .normal)
        reward.addTarget(self, action: #selector(reWardClick), for: .touchUpInside)
        contentView.addSubview(reward)
        
        line.backgroundColor = lineColor
        contentView.addSubview(line)
        _ = line.sd_layout()?
            .bottomSpaceToView(contentView,0)?
            .leftSpaceToView(contentView,0)?
            .widthIs(WIDTH)?
            .heightIs(10)
    }
    
    @objc private func reWardClick() {
        
        if willClick != nil {
            willClick!("reward")
        }
    }
    
    @objc private func thumbClick() {

        if !Defaults.hasKey("SESSIONID") {
            SVPwillShowAndHide("请登陆后重试")
            return
        }

        var up = ["mobileCode":Defaults["mobileCode"].stringValue,
                  "SESSIONID":Defaults["SESSIONID"].stringValue,
                  "id":_model!.article.id,
                  "type":"1"]
            as [String: Any]
        
        delog(up)
        SVPWillShow("载入中...")
        
        if self._model!.isThumb {
            up["flag"] = "false"
        }else {
            up["flag"] = "true"
        }
        
        Net.share.postRequest(urlString: CBBChangeThumbJoggle, params: up, success: { (datas) in
            let json = JSON(datas)
            delog(json)
            SVPHide()
            if json["code"].int == 1 {
                
                if self._model!.isThumb {
                    self.thumbsIMG.image = UIImage(named:"zan")
                    self._model!.isThumb = false
                    self.model!.article.thumbs = "\(Int(self.model!.article.thumbs)!-1)"
                    self.thumbs.text = self.model!.article.thumbs
                    SVPwillSuccessShowAndHide("取消点赞成功")
                }else {
                    self.thumbsIMG.image = UIImage(named:"red_zan")
                    self._model!.isThumb = true
                    self.model!.article.thumbs = "\(Int(self.model!.article.thumbs)!+1)"
                    self.thumbs.text = self.model!.article.thumbs
                    SVPwillSuccessShowAndHide("点赞成功")
                }
            }else {
                SVPwillShowAndHide("数据错误")
            }
        }) { (error) in
            delog(error)
        }
    }

    @objc public func click(_ tap: UITapGestureRecognizer) {
        
        var itemArr = [KSPhotoItem]()
        
        for index in 0..<tmp.count {
            
            let watchIMGItem = KSPhotoItem.init(sourceView: tmp[index], image: tmp[index].image)
            itemArr.append(watchIMGItem!)
        }
        
        let watchIMGView = KSPhotoBrowser.init(photoItems: itemArr,
                                               selectedIndex: UInt((tap.view?.tag)! - 900))
        watchIMGView?.dismissalStyle = .scale
        watchIMGView?.backgroundStyle = .blurPhoto
        watchIMGView?.loadingStyle = .indeterminate
        watchIMGView?.pageindicatorStyle = .text
        watchIMGView?.bounces = false
        watchIMGView?.show(from: viewController()!)
    }

}
