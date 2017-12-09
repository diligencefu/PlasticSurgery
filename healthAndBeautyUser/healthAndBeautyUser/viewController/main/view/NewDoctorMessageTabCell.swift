//
//  NewDoctorMessageTabCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/9/27.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewDoctorMessageTabCell: UITableViewCell {

    private var _model : doctorPage?
    var model : doctorPage? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    private func didSetModel(_ model: doctorPage) {
        
        head.layer.cornerRadius = 30
        head.layer.masksToBounds = true
        head.layer.borderWidth = 0.5
        head.layer.borderColor = lineColor.cgColor
        
        head.kf.setImage(with: StringToUTF_8InUrl(str: model.headImage))
        head.contentMode = .scaleAspectFill
        
        doctor.text = model.doctorName + "    "
        position.text = model.currentPosition
        if model.sex == "1" {
            
            icon.image = UIImage(named:"na")
        }else {
            
            icon.image = UIImage(named:"nv")
        }
        
        yuyue.setTitle("\(model.bespoke)\n预约", for: .normal)
        yuyue.titleLabel?.lineBreakMode = .byWordWrapping
        yuyue.titleLabel?.numberOfLines = 0
        yuyue.titleLabel?.textAlignment = .center
        anli.setTitle("\(model.cases)\n案例", for: .normal)
        anli.titleLabel?.lineBreakMode = .byWordWrapping
        anli.titleLabel?.numberOfLines = 0
        anli.titleLabel?.textAlignment = .center
        zixun.setTitle("1\n咨询排行", for: .normal)
        zixun.titleLabel?.lineBreakMode = .byWordWrapping
        zixun.titleLabel?.numberOfLines = 0
        zixun.titleLabel?.textAlignment = .center
        
        follow.layer.cornerRadius = 5.0
        follow.layer.masksToBounds = true
        follow.layer.borderWidth = 0.5
        follow.layer.borderColor = tabbarColor.cgColor
        
        if model.isFollow {
            follow.setTitle("已关注", for: .normal)
        }else {
            follow.setTitle("+ 关注", for: .normal)
        }
    }
    
    @IBOutlet weak var head: UIImageView!
    @IBOutlet weak var doctor: UILabel!
    @IBOutlet weak var position: UILabel!
    @IBOutlet weak var follow: UIButton!
    @IBOutlet weak var icon: UIImageView!
    
    //懒得查了  预约 案例 咨询排行
    @IBOutlet weak var yuyue: UIButton!
    @IBOutlet weak var anli: UIButton!
    @IBOutlet weak var zixun: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func sender(_ sender: UIButton) {
        
        switch sender.tag {
        case 666:
            delog("关注按钮")
            followController()
            break
        case 667:
            delog("预约")
            let tmp = NewDoctorAppointtmentViewController.init(nibName: "NewDoctorAppointtmentViewController", bundle: nil)
            tmp.doctorID = _model!.id
            viewController()?.navigationController?.pushViewController(tmp, animated: true)
            break
        case 668:
            delog("案例")
            let tmp = NewDoctorProjectViewController.init(nibName: "NewDoctorProjectViewController", bundle: nil)
            tmp.doctorID = _model!.id
            viewController()?.navigationController?.pushViewController(tmp, animated: true)
            break
        case 669:
            delog("咨询排行")
            break
        default:
            break
        }
    }
    
    private func followController() {
        
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
        
        up["concernedBy"] = _model!.id
        up["followType"] = "2"
        
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
}
