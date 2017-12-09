//
//  NewMeDetailTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 丿番茄 on 2017/11/4.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

var NewMeDetailTableViewCellName = String()
var NewMeDetailTableViewCellSex = String()
var NewMeDetailTableViewCellBirthday = String()
var NewMeDetailTableViewCellArea = String()

class NewMeDetailTableViewCell: UITableViewCell {

    private var _model : NewEditMeModel?
    var model : NewEditMeModel? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    
    private func didSetModel(_ model: NewEditMeModel) {
        
        NewMeDetailTableViewCellName = model.nickName
        NewMeDetailTableViewCellSex = model.gender
        NewMeDetailTableViewCellBirthday = model.birthday
        NewMeDetailTableViewCellArea = model.area
        
        tf.text = model.nickName
        tf.delegate = self
        sex.text = model.gender == "1" ? "男" : "女"
        birthday.text = model.birthday
        area.text = model.area
        let tap1 = UITapGestureRecognizer.init(target: self, action: #selector(click(_:)))
        niceView.addGestureRecognizer(tap1)
        let tap2 = UITapGestureRecognizer.init(target: self, action: #selector(click(_:)))
        sexView.addGestureRecognizer(tap2)
        let tap3 = UITapGestureRecognizer.init(target: self, action: #selector(click(_:)))
        birthdayView.addGestureRecognizer(tap3)
        let tap4 = UITapGestureRecognizer.init(target: self, action: #selector(click(_:)))
        areaView.addGestureRecognizer(tap4)
        
    }
    
    @objc private func click(_ tap: UITapGestureRecognizer) {
        
        switch tap.view! {
        case niceView:
            tf.becomeFirstResponder()
            break
        case sexView:
            tf.resignFirstResponder()
            selectSex()
            break
        case birthdayView:
            tf.resignFirstResponder()
            selectDay()
            break
        case areaView:
            tf.resignFirstResponder()
            selectArea()
            break
        default:
            break
        }
    }
    
    private func selectSex() {
        
        let arr = ["男","女"]
        BRStringPickerView.showStringPicker(withTitle: "性别选择",
                                            dataSource: arr,
                                            defaultSelValue: arr.first,
                                            isAutoSelect: true) { (test) in
                                                NewMeDetailTableViewCellSex = "\(arr.index(of: test as! String)! + 1)"
                                                self.sex.text = test as! String
        }
    }
    
    private func selectDay() {
        BRDatePickerView.showDatePicker(withTitle: "生日选择",
                                        dateType: .date,
                                        defaultSelValue: nil,
                                        minDateStr: nil,
                                        maxDateStr: nil,
                                        isAutoSelect: false) { (time) in
                                            NewMeDetailTableViewCellBirthday = time as! String
                                            self.birthday.text = time as! String
        }
    }
    
    
    private func selectArea() {
        
        BRAddressPickerView.showAddressPicker(withDefaultSelected: nil, isAutoSelect: false) { (tmp) in
            let city = tmp as! [String]
            NewMeDetailTableViewCellArea = "\(city[0])\(city[1])"
            self.area.text = "\(city[0])\(city[1])"
        }
    }
    
    @IBOutlet weak var tf: UITextField!
    @IBOutlet weak var niceView: UIView!
    
    @IBOutlet weak var sex: UILabel!
    @IBOutlet weak var sexView: UIView!
    
    @IBOutlet weak var birthday: UILabel!
    @IBOutlet weak var birthdayView: UIView!
    
    @IBOutlet weak var area: UILabel!
    @IBOutlet weak var areaView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension NewMeDetailTableViewCell: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        NewMeDetailTableViewCellName = textField.text!
    }
}
