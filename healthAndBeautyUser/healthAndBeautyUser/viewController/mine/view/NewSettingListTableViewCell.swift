//
//  newSettingListTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/14.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewSettingListTableViewCell: Wx_baseTableViewCell {

    private var _model : NewSettingListModel?
    var model : NewSettingListModel? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    
    let title = UILabel()
    let icon = UIImageView()
    let other = UILabel()
    
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
        
        title.textColor = darkText
        title.font = UIFont.systemFont(ofSize: GET_SIZE * 32)
        title.textAlignment = .left
        contentView.addSubview(title)
        _ = title.sd_layout()?
            .centerYEqualToView(contentView)?
            .leftSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(WIDTH/2)?
            .heightIs(32)
        
        icon.image = UIImage(named:"go_icon_g")
        contentView.addSubview(icon)
        _ = icon.sd_layout()?
            .centerYEqualToView(contentView)?
            .rightSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(5)?
            .heightIs(10)
        
        other.textColor = tabbarColor
        other.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        other.textAlignment = .right
        contentView.addSubview(other)
        _ = other.sd_layout()?
            .centerYEqualToView(contentView)?
            .rightSpaceToView(icon,8)?
            .widthIs(WIDTH/2)?
            .heightIs(GET_SIZE * 28)
        
        let line = UIView()
        line.backgroundColor = lineColor
        contentView.addSubview(line)
        _ = line.sd_layout()?
            .bottomSpaceToView(contentView,0)?
            .leftSpaceToView(contentView,0)?
            .widthIs(WIDTH)?
            .heightIs(0.5)
    }
    
    private func didSetModel(_ model: NewSettingListModel) {
        
        title.text = model.title
        other.text = model.detail
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        delog("点击设置事件")
        click()
    }
    
    private func click() {
        
//        let arr = ["修改密码","意见反馈","投诉","相关协议","关于新医美","清除缓存","当前版本","退出当前账号"]
        switch _model?.title {
        case "修改密码"?:
            let find = NewRegistViewController.init(nibName: "NewRegistViewController", bundle: nil)
            find.isExchange = true
            viewController()?.navigationController?.pushViewController(find, animated: true)
            break
        case "支付密码"?:
            let view = NewSetPasswordViewController.init(nibName: "NewSetPasswordViewController", bundle: nil)
            viewController()?.navigationController?.pushViewController(view, animated: true)
            break
        case "意见反馈"?:
            
            let view = NewSeting_ComplainViewController.init(nibName: "NewSeting_ComplainViewController", bundle: nil)
            viewController()?.navigationController?.pushViewController(view, animated: true)
            break
        case "相关协议"?:
            break
        case "关于我们"?:
            break
        case "清除缓存"?:
            SVPWillShow("清除中...")
            clearCache()
            let time : TimeInterval = 0.5
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
                SVPHide()
                (self.viewController()! as! NewSettingsViewController).buildData()
            }
            break
        case "当前版本"?:
            delog("当前版本")
            break
        case "收藏"?:
            delog("收藏")
            let view = NewMineCollectionViewController()
            viewController()?.navigationController?.pushViewController(view, animated: true)
            break
        case "优惠券"?:
            delog("优惠券")
            let view = NewMineBookViewController()
            viewController()?.navigationController?.pushViewController(view, animated: true)
            break
        case "客服电话"?:
            delog("客服电话")
            break
        default:
            break
        }
    }
}
