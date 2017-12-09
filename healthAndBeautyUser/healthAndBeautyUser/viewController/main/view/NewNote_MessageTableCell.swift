//
//  NewNote_MessageTableCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/9/25.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import Kingfisher

class NewNote_MessageTableCell: Wx_baseTableViewCell {
    
    var arr = [String]()
    var btnArr = [UIButton]()
    private var _model : NewNoteDetail_2Model?
    var model : NewNoteDetail_2Model? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    
    private func didSetModel(_ model: NewNoteDetail_2Model) {
        
        var sizes = CGSize()
        
        head.kf.setImage(with: StringToUTF_8InUrl(str: model.personal.photo))
        
        name.text = model.personal.nickName
        sizes = getSizeOnLabel(name)
        _ = name.sd_layout()?
            .topSpaceToView(contentView,GET_SIZE * 32)?
            .leftSpaceToView(head,GET_SIZE * 24)?
            .widthIs(sizes.width+5)?
            .heightIs(GET_SIZE * 30)
        
        if model.personal.gender == "1" {
            sex.image = UIImage(named:"nan_icon_default")
        }else {
            sex.image = UIImage(named:"nv_icon_default")
        }
        _ = sex.sd_layout()?
            .centerYEqualToView(name)?
            .leftSpaceToView(name,3)
        
        location.text = "\(model.personal.age)岁"
        
        var doctorString = String()
        for index in model.docotrs {
            doctorString += index.doctorName
            doctorString += "  "
        }
        doctor.text = doctorString
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
    let sex = UIImageView()
    let location = UILabel()
    let line1 = UIView()
    let clickMen = UIButton()

    var doctorIMG = UIImageView()
    var doctor = UILabel()
    var more = UIImageView()
    var line3 = UIView()
    
    let doctorBtn = UIButton()
    
    private func buildUI() {
        
        //图像
        contentView.addSubview(head)
        _ = head.sd_layout()?
            .topSpaceToView(contentView,GET_SIZE * 15)?
            .leftSpaceToView(contentView,GET_SIZE * 28)?
            .widthIs(GET_SIZE * 98)?
            .heightIs(GET_SIZE * 98)
        viewRadius(head, Float(head.width/2), 0.5, lightText)
        
        //name
        name.textColor = darkText
        name.font = UIFont.systemFont(ofSize: GET_SIZE * 36)
        contentView.addSubview(name)
        _ = name.sd_layout()?
            .topSpaceToView(contentView,GET_SIZE * 32)?
            .leftSpaceToView(head,GET_SIZE * 24)?
            .widthIs(WIDTH/2)?
            .heightIs(GET_SIZE * 30)
        
        //性别
        contentView.addSubview(sex)
        _ = sex.sd_layout()?
            .centerYEqualToView(name)?
            .leftSpaceToView(name,GET_SIZE * 28)?
            .widthIs(GET_SIZE * 32)?
            .heightIs(GET_SIZE * 32)
        viewRadius(sex, Float(sex.width/2), 0.5, UIColor.clear)
        
        //年纪和地区
        location.textColor = lightText
        location.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
        contentView.addSubview(location)
        _ = location.sd_layout()?
            .topSpaceToView(name,GET_SIZE * 12)?
            .leftSpaceToView(head,GET_SIZE * 24)?
            .widthIs(WIDTH/2)?
            .heightIs(GET_SIZE * 30)
        
        line1.backgroundColor = lineColor
        contentView.addSubview(line1)
        _ = line1.sd_layout()?
            .topSpaceToView(head,GET_SIZE * 15)?
            .leftSpaceToView(contentView,0)?
            .widthIs(WIDTH)?
            .heightIs(0.5)
        
        clickMen.addTarget(self, action: #selector(gotoUser), for: .touchUpInside)
        contentView.addSubview(clickMen)
        _ = clickMen.sd_layout()?
            .topSpaceToView(contentView,0)?
            .leftSpaceToView(contentView,0)?
            .widthIs(WIDTH)?
            .bottomSpaceToView(line1,0)
        
        //图像
        doctorIMG.image = UIImage(named:"Doctor_icon_default")
        contentView.addSubview(doctorIMG)
        _ = doctorIMG.sd_layout()?
            .topSpaceToView(line1,GET_SIZE * 26)?
            .leftSpaceToView(contentView,GET_SIZE * 26)?
            .widthIs(GET_SIZE * 36)?
            .heightIs(GET_SIZE * 36)
        viewRadius(doctorIMG, Float(doctorIMG.width/2), 0.5, UIColor.clear)
        
        //name
        doctor.textColor = darkText
        doctor.font = UIFont.systemFont(ofSize: GET_SIZE * 32)
        contentView.addSubview(doctor)
        _ = doctor.sd_layout()?
            .centerYEqualToView(doctorIMG)?
            .leftSpaceToView(doctorIMG,GET_SIZE * 24)?
            .widthIs(WIDTH/2)?
            .heightIs(GET_SIZE * 34)
        
        more.image = UIImage(named:"00_go_icon_default")
        contentView.addSubview(more)
        _ = more.sd_layout()?
            .centerYEqualToView(doctorIMG)?
            .rightSpaceToView(contentView,GET_SIZE * 24)?
            .widthIs(GET_SIZE * 14)?
            .heightIs(GET_SIZE * 26)
        
        line3.backgroundColor = lineColor
        contentView.addSubview(line3)
        _ = line3.sd_layout()?
            .bottomSpaceToView(contentView,0)?
            .leftSpaceToView(contentView,0)?
            .widthIs(WIDTH)?
            .heightIs(0.5)
        
        contentView.addSubview(doctorBtn)
        doctorBtn.addTarget(self, action: #selector(click(_:)), for: .touchUpInside)
        _ = doctorBtn.sd_layout()?
            .topSpaceToView(line1,GET_SIZE * 26)?
            .bottomSpaceToView(contentView,0.5)?
            .widthIs(WIDTH)?
            .leftSpaceToView(contentView,0)
    }
    
    @objc private func gotoUser() {
        
        let me = newMineMeViewController()
        me.id = _model!.personal.id
        me.isMe = false
        viewController()?.navigationController?.pushViewController(me, animated: true)
    }
    
    @objc private func click(_ click: UIButton) {
        
        if _model!.docotrs.count == 1 {
            let doctorView = NewDoctorMainPageViewController()
            doctorView.doctorID = _model!.docotrs[0].id
            viewController()?.navigationController?.pushViewController(doctorView, animated: true)
        }else {
            let arr = NSMutableArray()
            for index in _model!.docotrs {
                arr.add(index.doctorName)
            }
            BRStringPickerView.showStringPicker(withTitle: "选择医生",
                                                dataSource: arr as! [String],
                                                defaultSelValue: arr.firstObject,
                                                isAutoSelect: false) { (test) in
                                                    
                let doctorView = NewDoctorMainPageViewController()
                doctorView.doctorID = self._model!.docotrs[arr.index(of: test!)].id
                self.viewController()?.navigationController?.pushViewController(doctorView, animated: true)
            }
        }
    }
}
