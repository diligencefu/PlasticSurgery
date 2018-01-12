

//
//  newMineList_MessageOrOrderTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/15.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewMineList_MessageOrOrderTableViewCell: Wx_baseTableViewCell {
    
    var isMessage = Bool()
    
    func buildData() {
        
        if isMessage {
            
            name.text = "我的消息"
            
            more.isHidden = false
            more.tag = MineList_MeCellBtnTag.messageMore.rawValue
            
            privateLetterLab.text = "私信"
            privateLetterIMG.image = UIImage(named:"private letter")
            privateLetter.tag = MineList_MeCellBtnTag.privateLetter.rawValue
            _ = privateLetterIMG.sd_layout()?
                .topSpaceToView(privateLetter,GET_SIZE * 25)?
                .centerXEqualToView(privateLetter)?
                .widthIs(GET_SIZE * 49)?
                .heightIs(GET_SIZE * 42)
            
            discussLab.text = "评论"
            discussIMG.image = UIImage(named:"comment")
            discuss.tag = MineList_MeCellBtnTag.discuss.rawValue
            _ = discussIMG.sd_layout()?
                .topSpaceToView(discuss,GET_SIZE * 25)?
                .centerXEqualToView(discuss)?
                .widthIs(GET_SIZE * 49)?
                .heightIs(GET_SIZE * 42)
            
            assistLab.text = "赞"
            assistIMG.image = UIImage(named:"fabulous")
            assist.tag = MineList_MeCellBtnTag.assist.rawValue
            _ = assistIMG.sd_layout()?
                .topSpaceToView(assist,GET_SIZE * 25)?
                .centerXEqualToView(assist)?
                .widthIs(GET_SIZE * 49)?
                .heightIs(GET_SIZE * 42)
            
            newFansLab.text = "新粉丝"
            newFansIMG.image = UIImage(named:"fans")
            newFans.tag = MineList_MeCellBtnTag.newFans.rawValue
            _ = newFansIMG.sd_layout()?
                .topSpaceToView(newFans,GET_SIZE * 25)?
                .centerXEqualToView(newFans)?
                .widthIs(GET_SIZE * 49)?
                .heightIs(GET_SIZE * 42)
            
            noticeLab.text = "通知"
            noticeIMG.image = UIImage(named:"notice")
            notice.tag = MineList_MeCellBtnTag.notice.rawValue
            _ = noticeIMG.sd_layout()?
                .topSpaceToView(notice,GET_SIZE * 25)?
                .centerXEqualToView(notice)?
                .widthIs(GET_SIZE * 49)?
                .heightIs(GET_SIZE * 42)
        }else {
            //        //订单更多
            //        case orderMore = 300
            //        //全部 待付款 待使用 待写日志 退款
            //        case all,waitPay,waitUse,waitWrite,drawBack
            name.text = "我的订单"
            
            more.isHidden = false
            more.tag = MineList_MeCellBtnTag.orderMore.rawValue

            privateLetterLab.text = "待付款"
            privateLetterIMG.image = UIImage(named:"pending payment")
            privateLetter.tag = MineList_MeCellBtnTag.all.rawValue
            _ = privateLetterIMG.sd_layout()?
                .topSpaceToView(privateLetter,GET_SIZE * 25)?
                .centerXEqualToView(privateLetter)?
                .widthIs(GET_SIZE * 67)?
                .heightIs(GET_SIZE * 45)
            
            discussLab.text = "待使用"
            discussIMG.image = UIImage(named:"pending use")
            discuss.tag = MineList_MeCellBtnTag.waitPay.rawValue
            _ = discussIMG.sd_layout()?
                .topSpaceToView(discuss,GET_SIZE * 25)?
                .centerXEqualToView(discuss)?
                .widthIs(GET_SIZE * 67)?
                .heightIs(GET_SIZE * 45)
            
            assistLab.text = "待写日记"
            assistIMG.image = UIImage(named:"keep a diary")
            assist.tag = MineList_MeCellBtnTag.waitUse.rawValue
            _ = assistIMG.sd_layout()?
                .topSpaceToView(assist,GET_SIZE * 25)?
                .centerXEqualToView(assist)?
                .widthIs(GET_SIZE * 67)?
                .heightIs(GET_SIZE * 45)
            
            newFansLab.text = "退款"
            newFansIMG.image = UIImage(named:"refund")
            newFans.tag = MineList_MeCellBtnTag.waitWrite.rawValue
            _ = newFansIMG.sd_layout()?
                .topSpaceToView(newFans,GET_SIZE * 25)?
                .centerXEqualToView(newFans)?
                .widthIs(GET_SIZE * 67)?
                .heightIs(GET_SIZE * 45)
            
            noticeLab.text = "商品"
            noticeIMG.image = UIImage(named:"commodity")
            notice.tag = MineList_MeCellBtnTag.drawBack.rawValue
            _ = noticeIMG.sd_layout()?
                .topSpaceToView(notice,GET_SIZE * 25)?
                .centerXEqualToView(notice)?
                .widthIs(GET_SIZE * 67)?
                .heightIs(GET_SIZE * 45)
        }
    }
    
    let colorView = UIView()
    
    let name = UILabel()
    let more = UIButton()
    
    let line = UIView()

    let privateLetter = UIButton()
    let privateLetterIMG = UIImageView()
    let privateLetterLab = UILabel()
    
    let discuss = UIButton()
    let discussIMG = UIImageView()
    let discussLab = UILabel()
    
    let assist = UIButton()
    let assistIMG = UIImageView()
    let assistLab = UILabel()
    
    let newFans = UIButton()
    let newFansIMG = UIImageView()
    let newFansLab = UILabel()
    
    let notice = UIButton()
    let noticeIMG = UIImageView()
    let noticeLab = UILabel()
    
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
        
        colorView.backgroundColor = tabbarColor
        contentView.addSubview(colorView)
        _ = colorView.sd_layout()?
            .topSpaceToView(contentView,GET_SIZE * 30)?
            .leftSpaceToView(contentView,GET_SIZE * 30)?
            .widthIs(3)?
            .heightIs(16)
        
        name.textColor = lightText
        name.font = UIFont.systemFont(ofSize: GET_SIZE * 32)
        name.textAlignment = .left
        contentView.addSubview(name)
        _ = name.sd_layout()?
            .centerYEqualToView(colorView)?
            .leftSpaceToView(colorView,GET_SIZE * 21)?
            .widthIs(WIDTH/2)?
            .heightIs(GET_SIZE * 45)
        
        more.setImage(UIImage(named:"go_icon_g"), for: .normal)
        more.setTitle("全部", for: .normal)
        more.setTitleColor(tabbarColor, for: .normal)
        more.titleLabel?.font = UIFont.systemFont(ofSize: GET_SIZE * 32)
        contentView.addSubview(more)
        _ = more.sd_layout()?
            .centerYEqualToView(colorView)?
            .rightSpaceToView(contentView,GET_SIZE * 32)?
            .widthIs(GET_SIZE * 98)?
            .heightIs(GET_SIZE * 60)
        more.addTarget(self, action: #selector(click(_:)), for: .touchUpInside)
        more.layoutButton(with: .right, imageTitleSpace: 12)
        
        line.backgroundColor = lineColor
        contentView.addSubview(line)
        _ = line.sd_layout()?
            .topSpaceToView(colorView,GET_SIZE * 30)?
            .leftSpaceToView(contentView,0)?
            .widthIs(WIDTH)?
            .heightIs(0.5)
        
        //按钮1
        contentView.addSubview(privateLetter)
        _ = privateLetter.sd_layout()?
            .topSpaceToView(line,0)?
            .leftSpaceToView(contentView,WIDTH/5*0)?
            .widthIs(WIDTH/5)?
            .bottomSpaceToView(contentView,0)
        privateLetter.addTarget(self, action: #selector(click(_:)), for: .touchUpInside)
        
        privateLetter.addSubview(privateLetterIMG)
        _ = privateLetterIMG.sd_layout()?
            .topSpaceToView(privateLetter,GET_SIZE * 25)?
            .centerXEqualToView(privateLetter)?
            .widthIs(GET_SIZE * 49)?
            .heightIs(GET_SIZE * 42)
        privateLetterLab.textColor = lightText
        privateLetterLab.textAlignment = .center
        privateLetterLab.font = UIFont.systemFont(ofSize: GET_SIZE * 32)
        privateLetter.addSubview(privateLetterLab)
        _ = privateLetterLab.sd_layout()?
            .bottomSpaceToView(privateLetter,GET_SIZE * 15)?
            .centerXEqualToView(privateLetter)?
            .widthIs(WIDTH/5)?
            .heightIs(GET_SIZE * 34)
        
        //按钮2
        contentView.addSubview(discuss)
        _ = discuss.sd_layout()?
            .topSpaceToView(line,0)?
            .leftSpaceToView(contentView,WIDTH/5*1)?
            .widthIs(WIDTH/5)?
            .bottomSpaceToView(contentView,0)
        discuss.addTarget(self, action: #selector(click(_:)), for: .touchUpInside)

        discuss.addSubview(discussIMG)
        _ = discussIMG.sd_layout()?
            .topSpaceToView(discuss,GET_SIZE * 25)?
            .centerXEqualToView(discuss)?
            .widthIs(GET_SIZE * 49)?
            .heightIs(GET_SIZE * 42)
        discussLab.textColor = lightText
        discussLab.textAlignment = .center
        discussLab.font = UIFont.systemFont(ofSize: GET_SIZE * 32)
        discuss.addSubview(discussLab)
        _ = discussLab.sd_layout()?
            .bottomSpaceToView(discuss,GET_SIZE * 15)?
            .centerXEqualToView(discuss)?
            .widthIs(WIDTH/5)?
            .heightIs(GET_SIZE * 34)

        //按钮3
        contentView.addSubview(assist)
        _ = assist.sd_layout()?
            .topSpaceToView(line,0)?
            .leftSpaceToView(contentView,WIDTH/5*2)?
            .widthIs(WIDTH/5)?
            .bottomSpaceToView(contentView,0)
        assist.addTarget(self, action: #selector(click(_:)), for: .touchUpInside)

        assist.addSubview(assistIMG)
        _ = assistIMG.sd_layout()?
            .topSpaceToView(assist,GET_SIZE * 25)?
            .centerXEqualToView(assist)?
            .widthIs(GET_SIZE * 49)?
            .heightIs(GET_SIZE * 42)
        assistLab.textColor = lightText
        assistLab.textAlignment = .center
        assistLab.font = UIFont.systemFont(ofSize: GET_SIZE * 32)
        assist.addSubview(assistLab)
        _ = assistLab.sd_layout()?
            .bottomSpaceToView(assist,GET_SIZE * 15)?
            .centerXEqualToView(assist)?
            .widthIs(WIDTH/5)?
            .heightIs(GET_SIZE * 34)

        //按钮4
        contentView.addSubview(newFans)
        _ = newFans.sd_layout()?
            .topSpaceToView(line,0)?
            .leftSpaceToView(contentView,WIDTH/5*3)?
            .widthIs(WIDTH/5)?
            .bottomSpaceToView(contentView,0)
        newFans.addTarget(self, action: #selector(click(_:)), for: .touchUpInside)

        newFans.addSubview(newFansIMG)
        _ = newFansIMG.sd_layout()?
            .topSpaceToView(newFans,GET_SIZE * 25)?
            .centerXEqualToView(newFans)?
            .widthIs(GET_SIZE * 49)?
            .heightIs(GET_SIZE * 42)
        newFansLab.textColor = lightText
        newFansLab.textAlignment = .center
        newFansLab.font = UIFont.systemFont(ofSize: GET_SIZE * 32)
        newFans.addSubview(newFansLab)
        _ = newFansLab.sd_layout()?
            .bottomSpaceToView(newFans,GET_SIZE * 15)?
            .centerXEqualToView(newFans)?
            .widthIs(WIDTH/5)?
            .heightIs(GET_SIZE * 34)
        
        //按钮5
        contentView.addSubview(notice)
        _ = notice.sd_layout()?
            .topSpaceToView(line,0)?
            .leftSpaceToView(contentView,WIDTH/5*4)?
            .widthIs(WIDTH/5)?
            .bottomSpaceToView(contentView,0)
        notice.addTarget(self, action: #selector(click(_:)), for: .touchUpInside)
        
        notice.addSubview(noticeIMG)
        _ = noticeIMG.sd_layout()?
            .topSpaceToView(notice,GET_SIZE * 25)?
            .centerXEqualToView(notice)?
            .widthIs(GET_SIZE * 49)?
            .heightIs(GET_SIZE * 42)
        noticeLab.textColor = lightText
        noticeLab.textAlignment = .center
        noticeLab.font = UIFont.systemFont(ofSize: GET_SIZE * 32)
        notice.addSubview(noticeLab)
        _ = noticeLab.sd_layout()?
            .bottomSpaceToView(notice,GET_SIZE * 15)?
            .centerXEqualToView(notice)?
            .widthIs(WIDTH/5)?
            .heightIs(GET_SIZE * 34)
    }

    
    @objc private func click(_ btn: UIButton) {
        
        delog(btn.tag)
            
        let view = NewMineMessageViewController()
        
        let view2 = NewMeOrderViewController()
//        //消息的更多
//        case messageMore = 200
//        //私信 评论 赞 新粉丝 通知
//        case privateLetter,discuss,assist,newFans,notice
//        
//        //订单更多
//        case orderMore = 300
//        // ["待付款","待付尾款","已支付","已完成","退款"]
//        case all,waitPay,waitUse,waitWrite,drawBack
        switch btn.tag {
            
        case MineList_MeCellBtnTag.messageMore.rawValue, MineList_MeCellBtnTag.privateLetter.rawValue:
            view.topView.currentBtn = 0
            viewController()?.navigationController?.pushViewController(view, animated: true)
            break
        case MineList_MeCellBtnTag.discuss.rawValue:
            view.topView.currentBtn = 1
            viewController()?.navigationController?.pushViewController(view, animated: true)
            break
        case MineList_MeCellBtnTag.assist.rawValue:
            view.topView.currentBtn = 2
            viewController()?.navigationController?.pushViewController(view, animated: true)
            break
        case MineList_MeCellBtnTag.newFans.rawValue:
            view.topView.currentBtn = 3
            viewController()?.navigationController?.pushViewController(view, animated: true)
            break
        case MineList_MeCellBtnTag.notice.rawValue:
            view.topView.currentBtn = 4
            viewController()?.navigationController?.pushViewController(view, animated: true)
            break
            
            // ["待付款","待付尾款","已支付","已完成","退款"]
            // 这里这么写的原因是 下一个页面的2 在这里没有直接关联的入口 待付尾款不属于首页的这几个按钮   商品是直接前往页面2
        case MineList_MeCellBtnTag.orderMore.rawValue, MineList_MeCellBtnTag.all.rawValue:
            view2.leftState = 0
            viewController()?.navigationController?.pushViewController(view2, animated: true)
            break
        case MineList_MeCellBtnTag.waitPay.rawValue:
            view2.leftState = 1
            viewController()?.navigationController?.pushViewController(view2, animated: true)
            break
        case MineList_MeCellBtnTag.waitUse.rawValue:
            view2.leftState = 4
            viewController()?.navigationController?.pushViewController(view2, animated: true)
            break
        case MineList_MeCellBtnTag.waitWrite.rawValue:
            view2.leftState = 5
            viewController()?.navigationController?.pushViewController(view2, animated: true)
            break
        case MineList_MeCellBtnTag.drawBack.rawValue:
            view2.rightState = 0
            viewController()?.navigationController?.pushViewController(view2, animated: true)
            break
        default:
            break
        }
    }
}
