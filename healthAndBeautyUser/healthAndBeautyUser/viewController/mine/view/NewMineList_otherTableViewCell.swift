//
//  newMineList_otherTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/15.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewMineList_otherTableViewCell: Wx_baseTableViewCell {

    var chooseAction:((String)->())?  //声明闭包

    private var _model : String?
    var model : String? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    private func didSetModel(_ model: String) {
//        //积分商城
//        case store = 400
//        //任务中心 分销商 会员中心
//        case job, bussness, famary
        if model == "0" {
            
            leftBtn.setTitle("积分商城", for: .normal)
            righrBtn.setTitle("任务中心", for: .normal)
            leftBtn.setImage(UIImage(named:"integral-mall"), for: .normal)
            righrBtn.setImage(UIImage(named:"task-center"), for: .normal)
            leftBtn.tag = MineList_MeCellBtnTag.store.rawValue
            righrBtn.tag = MineList_MeCellBtnTag.job.rawValue
            
            leftBtn.layoutButton(with: .left, imageTitleSpace: 15)
            righrBtn.layoutButton(with: .left, imageTitleSpace: 15)
        }else {
            
            leftBtn.setTitle("分销商  ", for: .normal)
            righrBtn.setTitle("会员中心", for: .normal)
            leftBtn.setImage(UIImage(named:"distributor"), for: .normal)
            righrBtn.setImage(UIImage(named:"member-center"), for: .normal)
            leftBtn.tag = MineList_MeCellBtnTag.bussness.rawValue
            righrBtn.tag = MineList_MeCellBtnTag.famary.rawValue
            
            leftBtn.layoutButton(with: .left, imageTitleSpace: 15)
            righrBtn.layoutButton(with: .left, imageTitleSpace: 15)
        }
    }
    
    let leftBtn = UIButton()
    let righrBtn = UIButton()
    let line = UIView()
    let Vline = UIView()

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
        
        leftBtn.setTitle("积分商城", for: .normal)
        leftBtn.setTitleColor(lightText, for: .normal)
        leftBtn.titleLabel?.font = UIFont.systemFont(ofSize: GET_SIZE * 32)
        contentView.addSubview(leftBtn)
        _ = leftBtn.sd_layout()?
            .topSpaceToView(contentView,0)?
            .leftSpaceToView(contentView,0)?
            .widthIs(WIDTH/2-0.5)?
            .bottomSpaceToView(contentView,0)
        leftBtn.addTarget(self, action: #selector(click(_:)), for: .touchUpInside)
        
        righrBtn.setTitle("任务中心", for: .normal)
        righrBtn.setTitleColor(lightText, for: .normal)
        righrBtn.titleLabel?.font = UIFont.systemFont(ofSize: GET_SIZE * 32)
        contentView.addSubview(righrBtn)
        _ = righrBtn.sd_layout()?
            .topSpaceToView(contentView,0)?
            .rightSpaceToView(contentView,0)?
            .widthIs(WIDTH/2-0.5)?
            .bottomSpaceToView(contentView,0)
        righrBtn.addTarget(self, action: #selector(click(_:)), for: .touchUpInside)
        
        Vline.backgroundColor = lineColor
        contentView.addSubview(Vline)
        _ = Vline.sd_layout()?
            .centerYEqualToView(leftBtn)?
            .leftSpaceToView(leftBtn,0)?
            .widthIs(1)?
            .heightIs(50)
        
        line.backgroundColor = lineColor
        contentView.addSubview(line)
        _ = line.sd_layout()?
            .bottomSpaceToView(contentView,0)?
            .leftSpaceToView(contentView,0)?
            .widthIs(WIDTH)?
            .heightIs(0.5)
    }
    
    @objc private func click(_ btn: UIButton) {
        
        delog(btn.tag)
        if chooseAction != nil{
            chooseAction!(String(btn.tag))
        }

        switch btn.tag {
        case MineList_MeCellBtnTag.store.rawValue:
            break
        case MineList_MeCellBtnTag.job.rawValue:
            break
        case MineList_MeCellBtnTag.bussness.rawValue:
            
            break
        case MineList_MeCellBtnTag.famary.rawValue:
            
            break
        default:
            break
        }
    }
}
