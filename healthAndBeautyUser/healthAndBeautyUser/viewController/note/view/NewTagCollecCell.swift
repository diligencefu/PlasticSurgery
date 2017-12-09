//
//  NewTagCollecCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/9/28.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewTagCollecCell: UICollectionViewCell {

    private var _model : articleTagsAndArticleSymptomsModel?
    var model : articleTagsAndArticleSymptomsModel? {
        didSet {
            _model = model
            self.didSetModel(model!)
        }
    }
    
    private func didSetModel(_ model: articleTagsAndArticleSymptomsModel) {
        
        main.setTitle(model.tarContentOrSymptomInfo, for: .normal)
    }
    
    @IBOutlet weak var main: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let seizs = getSizeOnLabel(main.titleLabel!)
        
        main.layer.cornerRadius = (seizs.height + 10)/2
        main.layer.masksToBounds = true
        main.layer.borderColor = lightText.cgColor
        main.layer.borderWidth = 0.5
    }
    
    @IBAction func click(_ sender: UIButton) {
        
        let controller = viewController() as! NewNoteCreateViewController
        
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            
            main.layer.borderColor = tabbarColor.cgColor
            main.backgroundColor = tabbarColor
            if controller.isTag {
                
                let arr = controller.tagArr.filter() {
                    $0.range(of: (sender.titleLabel?.text)!) != nil
                }
                if arr.count == 0 {
                    controller.tagArr.append(_model!.id)
                }
            }else {
                
                let arr = controller.semeiography.filter() {
                    $0.range(of: (sender.titleLabel?.text)!) != nil
                }
                if arr.count == 0 {
                    controller.semeiography.append(_model!.id)
                }
            }
        }else {
            
            main.layer.borderColor = lightText.cgColor
            main.backgroundColor = UIColor.white
            if controller.isTag {
                
                for index in 0..<controller.tagArr.count {
                    if controller.tagArr[index] == _model!.id {
                        controller.tagArr.remove(at: index)
                        break
                    }
                }
            }else {
                
                for index in 0..<controller.semeiography.count {
                    if controller.semeiography[index] == _model!.id {
                        controller.semeiography.remove(at: index)
                        break
                    }
                }
            }
        }
        
        if controller.isTag {
            delog("标签")
            delog(controller.tagArr)
        }else {
            delog("症状")
            delog(controller.semeiography)
        }
    }
}
