//
//  NewNoteRewardView.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/10/21.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewNoteRewardView: UIView,UITextFieldDelegate {
    
    private var _model : NewRewardDetailDataModel?
    var model : NewRewardDetailDataModel? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    private func didSetModel(_ model: NewRewardDetailDataModel) {
        
        head.kf.setImage(with: StringToUTF_8InUrl(str: model.praissedByPhoto))
        head.contentMode = .scaleAspectFill
        
        name.text = model.praissedByNickName
        money.placeholder = "\(model.minPrice)-\(model.maxPrice)"
        money.text = "￥\(model.randomMoney)元"
        terraceLab.text = "账户余额: \(model.balance)元"
        price = model.randomMoney
    }
    
    var price = Float()
    var payWhat : NSInteger = 0
    
    let cleanView = UIView()
    let whiteView = UIView()

    let head = UIImageView()
    let name = UILabel()
    let money = UITextField()
    
    let line1 = UIView()
    let aliPayIMG = UIImageView()
    let aliPayLab = UILabel()
    let aliPayAelect = UIImageView()
    let aliPayBtn = UIButton()
    
    let line2 = UIView()
    let weiChatIMG = UIImageView()
    let weiChatLab = UILabel()
    let weiChatAelect = UIImageView()
    let weiChatBtn = UIButton()
    
    let line3 = UIView()
    let terraceIMG = UIImageView()
    let terraceLab = UILabel()
    let terraceAelect = UIImageView()
    let terraceBtn = UIButton()
    
    let line4 = UIView()
    let payBtn = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.init(white: 0, alpha: 0.5)
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc private func hide() {
        
        UIView.animate(withDuration: 0.3) {
            self.alpha = 0
        }
    }
    
    private func buildUI() {
        
        self.addSubview(cleanView)
        _ = cleanView.sd_layout()?
            .topSpaceToView(self,0)?
            .leftSpaceToView(self,0)?
            .widthIs(WIDTH)?
            .heightIs(GET_SIZE * 420)
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(hide))
        cleanView.addGestureRecognizer(tap)
        
        whiteView.backgroundColor = backGroundColor
        self.addSubview(whiteView)
        _ = whiteView.sd_layout()?
            .topSpaceToView(self,GET_SIZE * 420)?
            .leftSpaceToView(self,0)?
            .widthIs(WIDTH)?
            .bottomSpaceToView(self,0)
        
        head.image = UIImage(named:"banner_240")
        whiteView.addSubview(head)
        _ = head.sd_layout()?
            .centerXEqualToView(whiteView)?
            .topSpaceToView(whiteView,-35)?
            .widthIs(90)?
            .heightIs(90)
        viewRadius(head, 45, 0.5, UIColor.clear)
        
        name.textColor = darkText
        name.font = UIFont.systemFont(ofSize: GET_SIZE * 32)
        name.textAlignment = .center
        whiteView.addSubview(name)
        _ = name.sd_layout()?
            .centerXEqualToView(whiteView)?
            .topSpaceToView(head,5)?
            .widthIs(WIDTH/2)?
            .heightIs(GET_SIZE * 34)
        
        whiteView.addSubview(money)
        money.borderStyle = .none
        money.keyboardType = .decimalPad
        money.textAlignment = .center
        money.textColor = tabbarColor
        money.delegate = self
        _ = money.sd_layout()?
            .centerXEqualToView(whiteView)?
            .topSpaceToView(name,14)?
            .widthIs(GET_SIZE * 500)?
            .heightIs(GET_SIZE * 68)
        
        line1.backgroundColor = lineColor
        whiteView.addSubview(line1)
        _ = line1.sd_layout()?
            .leftSpaceToView(whiteView,0)?
            .topSpaceToView(money,14)?
            .widthIs(WIDTH)?
            .heightIs(0.5)
//        let aliPayIMG = UIImageView()
//        let aliPayLab = UILabel()
//        let aliPayAelect = UIImageView()
//        let aliPayBtn = UIButton()
        
        //88高度
        aliPayIMG.image = UIImage(named:"01_alipay_head_default")
        whiteView.addSubview(aliPayIMG)
        _ = aliPayIMG.sd_layout()?
            .leftSpaceToView(whiteView,12)?
            .topSpaceToView(line1,10)?
            .widthIs(44)?
            .heightIs(44)
        
        aliPayLab.text = "支付宝"
        aliPayLab.textColor = darkText
        aliPayLab.font = UIFont.systemFont(ofSize: GET_SIZE * 32)
        aliPayLab.textAlignment = .left
        whiteView.addSubview(aliPayLab)
        _ = aliPayLab.sd_layout()?
            .leftSpaceToView(aliPayIMG,12)?
            .centerYEqualToView(aliPayIMG)?
            .widthIs(WIDTH/2)?
            .heightIs(GET_SIZE * 34)
        
        //88高度
        aliPayAelect.image = UIImage(named:"selector_selector_default")
        whiteView.addSubview(aliPayAelect)
        _ = aliPayAelect.sd_layout()?
            .rightSpaceToView(whiteView,12)?
            .centerYEqualToView(aliPayIMG)?
            .widthIs(18)?
            .heightIs(18)
        
        aliPayBtn.backgroundColor = UIColor.clear
        aliPayBtn.tag = 101
        whiteView.addSubview(aliPayBtn)
        aliPayBtn.addTarget(self, action: #selector(click(_:)), for: .touchUpInside)
        _ = aliPayBtn.sd_layout()?
            .topSpaceToView(line1,0)?
            .leftSpaceToView(whiteView,0)?
            .widthIs(WIDTH)?
            .heightIs(68)
        
        line2.backgroundColor = lineColor
        whiteView.addSubview(line2)
        _ = line2.sd_layout()?
            .leftSpaceToView(whiteView,0)?
            .topSpaceToView(line1,68)?
            .widthIs(WIDTH)?
            .heightIs(0.5)
        //88高度
        weiChatIMG.image = UIImage(named:"03_wechat_head_default")
        whiteView.addSubview(weiChatIMG)
        _ = weiChatIMG.sd_layout()?
            .leftSpaceToView(whiteView,12)?
            .topSpaceToView(line2,10)?
            .widthIs(44)?
            .heightIs(44)
        
        weiChatLab.text = "微信"
        weiChatLab.textColor = darkText
        weiChatLab.font = UIFont.systemFont(ofSize: GET_SIZE * 32)
        weiChatLab.textAlignment = .left
        whiteView.addSubview(weiChatLab)
        _ = weiChatLab.sd_layout()?
            .leftSpaceToView(weiChatIMG,12)?
            .centerYEqualToView(weiChatIMG)?
            .widthIs(WIDTH/2)?
            .heightIs(GET_SIZE * 34)
        
        //88高度
        weiChatAelect.image = UIImage(named:"selector_selector_default")
        whiteView.addSubview(weiChatAelect)
        _ = weiChatAelect.sd_layout()?
            .rightSpaceToView(whiteView,12)?
            .centerYEqualToView(weiChatIMG)?
            .widthIs(18)?
            .heightIs(18)
        
        weiChatBtn.backgroundColor = UIColor.clear
        weiChatBtn.tag = 102
        whiteView.addSubview(weiChatBtn)
        weiChatBtn.addTarget(self, action: #selector(click(_:)), for: .touchUpInside)
        _ = weiChatBtn.sd_layout()?
            .topSpaceToView(line2,0)?
            .leftSpaceToView(whiteView,0)?
            .widthIs(WIDTH)?
            .heightIs(68)
        
        
        line3.backgroundColor = lineColor
        whiteView.addSubview(line3)
        _ = line3.sd_layout()?
            .leftSpaceToView(whiteView,0)?
            .topSpaceToView(line2,68)?
            .widthIs(WIDTH)?
            .heightIs(0.5)
        
        //88高度
        terraceIMG.image = UIImage(named:"02_Balancepay_head_default")
        whiteView.addSubview(terraceIMG)
        _ = terraceIMG.sd_layout()?
            .leftSpaceToView(whiteView,12)?
            .topSpaceToView(line3,10)?
            .widthIs(44)?
            .heightIs(44)
        
        terraceLab.text = "账户余额"
        terraceLab.textColor = darkText
        terraceLab.font = UIFont.systemFont(ofSize: GET_SIZE * 32)
        terraceLab.textAlignment = .left
        whiteView.addSubview(terraceLab)
        _ = terraceLab.sd_layout()?
            .leftSpaceToView(terraceIMG,12)?
            .centerYEqualToView(terraceIMG)?
            .widthIs(WIDTH/2)?
            .heightIs(GET_SIZE * 34)
        
        //88高度
        terraceAelect.image = UIImage(named:"selector_selector_default")
        whiteView.addSubview(terraceAelect)
        _ = terraceAelect.sd_layout()?
            .rightSpaceToView(whiteView,12)?
            .centerYEqualToView(terraceIMG)?
            .widthIs(18)?
            .heightIs(18)
        
        terraceBtn.backgroundColor = UIColor.clear
        terraceBtn.tag = 103
        terraceBtn.addTarget(self, action: #selector(click(_:)), for: .touchUpInside)
        whiteView.addSubview(terraceBtn)
        _ = terraceBtn.sd_layout()?
            .topSpaceToView(line3,0)?
            .leftSpaceToView(whiteView,0)?
            .widthIs(WIDTH)?
            .heightIs(68)
        
        line4.backgroundColor = lineColor
        whiteView.addSubview(line4)
        _ = line4.sd_layout()?
            .leftSpaceToView(whiteView,0)?
            .topSpaceToView(line3,68)?
            .widthIs(WIDTH)?
            .heightIs(0.5)
        
        payBtn.setTitle("确认支付", for: .normal)
        payBtn.tag = 104
        payBtn.backgroundColor = tabbarColor
        payBtn.setTitleColor(UIColor.white, for: .normal)
        payBtn.titleLabel?.font = UIFont.systemFont(ofSize: GET_SIZE * 32)
        payBtn.addTarget(self, action: #selector(click(_:)), for: .touchUpInside)
        whiteView.addSubview(payBtn)
        _ = payBtn.sd_layout()?
            .centerXEqualToView(whiteView)?
            .bottomSpaceToView(whiteView,38)?
            .widthIs(GET_SIZE * 600)?
            .heightIs(GET_SIZE * 88)
        viewRadius(payBtn, 5.0, 0.5, tabbarColor)
    }
    
    @objc private func click(_ btn: UIButton) {
        
        switch btn.tag {
        case 101:
            payWhat = 1
            aliPayBtn.isSelected = true
            weiChatBtn.isSelected = false
            terraceBtn.isSelected = false
            aliPayAelect.image = UIImage(named:"selector_selector_pressed")
            weiChatAelect.image = UIImage(named:"selector_selector_default")
            terraceAelect.image = UIImage(named:"selector_selector_default")
            break
        case 102:
            payWhat = 2
            aliPayBtn.isSelected = false
            weiChatBtn.isSelected = true
            terraceBtn.isSelected = false
            aliPayAelect.image = UIImage(named:"selector_selector_default")
            weiChatAelect.image = UIImage(named:"selector_selector_pressed")
            terraceAelect.image = UIImage(named:"selector_selector_default")
            break
        case 103:
            payWhat = 3
            aliPayBtn.isSelected = false
            weiChatBtn.isSelected = false
            terraceBtn.isSelected = true
            aliPayAelect.image = UIImage(named:"selector_selector_default")
            weiChatAelect.image = UIImage(named:"selector_selector_default")
            terraceAelect.image = UIImage(named:"selector_selector_pressed")
            break
        case 104:
            pay()
            break
        default:
            break
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if textField.text == "" {
            money.text = "￥\(_model!.randomMoney)元"
            return true
        }
        if Float(textField.text!)! < _model!.minPrice {
            money.text = "￥\(_model!.randomMoney)元"
            SVPwillShowAndHide("您输入的打赏金额不能小于\(_model!.minPrice)")
            return true
        }
        if Float(textField.text!)! > _model!.maxPrice {
            money.text = "￥\(_model!.randomMoney)元"
            SVPwillShowAndHide("您输入的打赏金额不能大于\(_model!.maxPrice)")
            return true
        }
        price = Float(textField.text!)!
        money.text = "￥\(textField.text!)元"
        return true
    }
    
    private func pay() {
        
        if price == 0 {
            SVPwillShowAndHide("您不能为该用户打赏0元")
            return
        }
        if payWhat == 0 {
            SVPwillShowAndHide("请选择支付方式")
            return
        }
        if payWhat == 1 {
            SVPwillShowAndHide("支付宝支付暂未开放")
            return
        }
        if payWhat == 2 {
            SVPwillShowAndHide("微信支付暂未开放")
            return
        }
        if _model!.balance < price {
            SVPwillShowAndHide("您当前余额不足，请充值后重试")
            return
        }
        delog("打赏")
    }
}
