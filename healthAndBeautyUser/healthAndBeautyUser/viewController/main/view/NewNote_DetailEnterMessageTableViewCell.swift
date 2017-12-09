//
//  NewNote_DetailEnterMessageTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/9/26.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import Kingfisher

class NewNote_DetailEnterMessageTableViewCell: Wx_baseTableViewCell {
    
    var arr = [String]()
    var btnArr = [UIButton]()
    
    private var _model : NewNoteEnterDetail_2Model?
    var model : NewNoteEnterDetail_2Model? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    
    private func didSetModel(_ model: NewNoteEnterDetail_2Model) {
        
        var sizes = CGSize()
        
        head.kf.setImage(with: StringToUTF_8InUrl(str: model.personal.photo))
        head.contentMode = .scaleAspectFill

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
        
        //移除所有数据
        for sub in tagLab.subviews {
            sub.removeFromSuperview()
        }
        btnArr.removeAll()
        arr.removeAll()
        
        // 中文逗号  不是英文逗号
        for index in model.dicTags {
            arr.append(index.tarContent)
        }
        for index in 0..<arr.count {
            
            let btn = UIButton()
            btn.setTitle(arr[index], for: .normal)
            btn.setTitleColor(getColorWithNotAlphe(0x757575), for: .normal)
            btn.backgroundColor = backGroundColor
            btn.titleLabel?.font = UIFont.systemFont(ofSize: GET_SIZE * 24)
            btnArr.append(btn)
            sizes = getSizeOnLabel(btn.titleLabel!)
            tagLab.addSubview(btn)
            if index == 0 {
                _ = btn.sd_layout()?
                    .centerYEqualToView(tagLab)?
                    .leftSpaceToView(tagLab,GET_SIZE * 14)?
                    .widthIs(sizes.width+30)?
                    .heightIs(GET_SIZE * 44)
            }else {
                _ = btn.sd_layout()?
                    .centerYEqualToView(tagLab)?
                    .leftSpaceToView(btnArr[index-1],GET_SIZE * 14)?
                    .widthIs(sizes.width+30)?
                    .heightIs(GET_SIZE * 44)
            }
            viewRadius(btn, 7.0, 0.5, lightText)
        }
        
        var doctorString = String()
        for index in model.docotrs {
            doctorString += "\(index.doctorName)  "
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

    let tagLab = UIScrollView()
    let line2 = UIView()

    var doctorIMG = UIImageView()
    var doctor = UILabel()
    var more = UIImageView()
    var line4 = UIView()
    
    var noteBtn = UIButton()
    var doctorBtn = UIButton()

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
        
        //标签
        tagLab.backgroundColor = backGroundColor
        contentView.addSubview(tagLab)
        _ = tagLab.sd_layout()?
            .topSpaceToView(line1,0)?
            .leftSpaceToView(contentView,0)?
            .widthIs(WIDTH)?
            .heightIs(GET_SIZE * 72)
        
        line2.backgroundColor = lineColor
        contentView.addSubview(line2)
        _ = line2.sd_layout()?
            .topSpaceToView(tagLab,0)?
            .leftSpaceToView(contentView,0)?
            .widthIs(WIDTH)?
            .heightIs(0.5)
        
//        //日记本
//        noteBooK.image = UIImage(named:"DiaryBook_icon_default")
//        contentView.addSubview(noteBooK)
//        _ = noteBooK.sd_layout()?
//            .topSpaceToView(line2,GET_SIZE * 26)?
//            .leftSpaceToView(contentView,GET_SIZE * 26)?
//            .widthIs(GET_SIZE * 36)?
//            .heightIs(GET_SIZE * 36)
//        viewRadius(noteBooK, Float(noteBooK.width/2), 0.5, UIColor.clear)
//
//        //name
//        note.text = "查看她的日记本"
//        note.textColor = lightText
//        note.font = UIFont.systemFont(ofSize: GET_SIZE * 32)
//        contentView.addSubview(note)
//        _ = note.sd_layout()?
//            .centerYEqualToView(noteBooK)?
//            .leftSpaceToView(noteBooK,GET_SIZE * 24)?
//            .widthIs(WIDTH/2)?
//            .heightIs(GET_SIZE * 34)
//
//        noteMore.image = UIImage(named:"00_go_icon_default")
//        contentView.addSubview(noteMore)
//        _ = noteMore.sd_layout()?
//            .centerYEqualToView(noteBooK)?
//            .rightSpaceToView(contentView,GET_SIZE * 24)?
//            .widthIs(GET_SIZE * 14)?
//            .heightIs(GET_SIZE * 26)
//
//        //name
//        noteCount.textColor = redText
//        noteCount.font = UIFont.systemFont(ofSize: GET_SIZE * 28)
//        noteCount.textAlignment = .right
//        contentView.addSubview(noteCount)
//        _ = noteCount.sd_layout()?
//            .centerYEqualToView(noteBooK)?
//            .rightSpaceToView(noteMore,GET_SIZE * 12)?
//            .widthIs(WIDTH/2)?
//            .heightIs(GET_SIZE * 34)
//
//        line3.backgroundColor = lineColor
//        contentView.addSubview(line3)
//        _ = line3.sd_layout()?
//            .topSpaceToView(noteBooK,GET_SIZE * 26)?
//            .leftSpaceToView(contentView,GET_SIZE * 26)?
//            .widthIs(WIDTH)?
//            .heightIs(0.5)
        
        //图像
        doctorIMG.image = UIImage(named:"Doctor_icon_default")
        contentView.addSubview(doctorIMG)
        _ = doctorIMG.sd_layout()?
            .topSpaceToView(line2,GET_SIZE * 26)?
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
        
        line4.backgroundColor = lineColor
        contentView.addSubview(line4)
        _ = line4.sd_layout()?
            .bottomSpaceToView(contentView,0)?
            .leftSpaceToView(contentView,GET_SIZE * 26)?
            .widthIs(WIDTH)?
            .heightIs(0.5)
        
        contentView.addSubview(doctorBtn)
        _ = doctorBtn.sd_layout()?
            .bottomSpaceToView(contentView,0)?
            .leftSpaceToView(contentView,GET_SIZE * 26)?
            .widthIs(WIDTH)?
            .topSpaceToView(line2,0)

        doctorBtn.addTarget(self, action: #selector(click), for: .touchUpInside)
    }

    //暂时没有点击事件
    @objc private func click() {

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
    @objc private func gotoUser() {
        
        let me = newMineMeViewController()
        me.id = _model!.personal.id
        me.isMe = false
        viewController()?.navigationController?.pushViewController(me, animated: true)
    }
}

