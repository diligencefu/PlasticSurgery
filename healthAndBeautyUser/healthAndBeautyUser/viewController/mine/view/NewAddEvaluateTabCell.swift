//
//  NewAddEvaluateTabCell.swift
//  healthAndBeautyUser
//
//  Created by 丿番茄 on 2017/11/11.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewAddEvaluateTabCell: UITableViewCell {

    private var _model : NewGoodsDetailModel?
    var model : NewGoodsDetailModel? {
        didSet {
            self.didSetModel(model!)
            _model = model
        }
    }
    
    private func didSetModel(_ model: NewGoodsDetailModel) {
        
        head.kf.setImage(with: StringToUTF_8InUrl(str: model.thumbnail))
        head.contentMode = .scaleAspectFill
        viewRadius(head, 3.0, 0.5, lineColor)
        
        titles.text = "【\(model.goodName)】\(model.goodChildName)"
        
        count.text = "x\(model.num)"
        
        type.text = "商品单价："
        detail.text = "￥ \(model.goodPrice)"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var head: UIImageView!
    @IBOutlet weak var titles: UILabel!
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var detail: UILabel!
    
    @IBOutlet weak var tv: UITextView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        tv.becomeFirstResponder()
    }
}

extension NewAddEvaluateTabCell: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.text == "撰写评论" {
            textView.text = ""
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text == "" {
            textView.text = "撰写评论"
        }
    }
}
