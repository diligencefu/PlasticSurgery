//
//  NewOperationTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 丿番茄 on 2017/11/24.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewOperationTableViewCell: UITableViewCell {
    
    //回调
    typealias callBack = (_ isPlayer : Bool) -> Void
    var didClick : callBack? = nil
    func willClick(block: @escaping(_ isPlayer : Bool) -> Void) {
        didClick = block
    }

    private var _model : IndexPath?
    var model : IndexPath? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    
    private func didSetModel(_ model: IndexPath) {
        
        icon.kf.setImage(with: StringToUTF_8InUrl(str: "\(NewMain_operationViewController_dateSource[model.row].path)\(NewMain_operationViewController_dateSource[model.row].headImage)"))
        viewRadius(icon, 24, 0.5, lineColor)
        
        name.text = NewMain_operationViewController_dateSource[model.row].doctorName
        time.text = NewMain_operationViewController_dateSource[model.row].createDate
        content.text = NewMain_operationViewController_dateSource[model.row].content
        content.updateLayout()
        
        watch.setTitle("浏览·\(NewMain_operationViewController_dateSource[model.row].rewards)", for: .normal)
        comment.setTitle("评论·\(NewMain_operationViewController_dateSource[model.row].comments)", for: .normal)
        up.setTitle("赞·\(NewMain_operationViewController_dateSource[model.row].hits)", for: .normal)
        
        if NewMain_operationViewController_dateSource[model.row].image != nil {
            img.image = NewMain_operationViewController_dateSource[model.row].image!
        }else {
            let url = URL.init(string: NewMain_operationViewController_dateSource[model.row].path + NewMain_operationViewController_dateSource[model.row].video)
            NewMain_operationViewController_dateSource[model.row].image = img.firstFrame(withVideoURL: url, img: img)
            img.image = NewMain_operationViewController_dateSource[model.row].image
        }
        
        img.updateLayout()
        startPlayer.frame = CGRect.init(x: (WIDTH-48-44)/2, y: (img.height-44)/2, width: 44, height: 44)
        startPlayer.setImage(UIImage(named:"PlayVideo_icon_default"), for: .normal)
        startPlayer.addTarget(self, action: #selector(clickPlayer), for: .touchUpInside)
        img.addSubview(startPlayer)
        img.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action:  #selector(clickPlayer))
        img.addGestureRecognizer(tap)
    }
    
    @objc private func clickPlayer() {
        
        if didClick != nil {
            didClick!(true)
        }
    }
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var follow: UIButton!
    @IBOutlet weak var content: UILabel!
    
    @IBOutlet weak var watch: UIButton!
    @IBOutlet weak var comment: UIButton!
    @IBOutlet weak var up: UIButton!
    
    @IBOutlet weak var img: UIImageView!
    var startPlayer = UIButton()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func click(_ sender: UIButton) {
    }
}
