//
//  NewReturnPicTableViewCell.swift
//  healthAndBeautyUser
//
//  Created by 丿番茄 on 2017/11/23.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

var NewReturnPicTableViewCell_Image = [UIImage]()

class NewReturnPicTableViewCell: UITableViewCell,TZImagePickerControllerDelegate {

    @IBOutlet weak var pic1: UIButton!
    @IBOutlet weak var pic2: UIButton!
    @IBOutlet weak var pic3: UIButton!

    var btnArr = [UIButton]()
    
    var currentBtn = UIButton()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewRadius(pic1, 5.0, 0.5, lineColor)
        viewRadius(pic2, 5.0, 0.5, lineColor)
        viewRadius(pic3, 5.0, 0.5, lineColor)
        btnArr = [pic1,pic2,pic3]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func click(_ sender: UIButton) {
        
        currentBtn = sender
        let max = pic3.tag - sender.tag + 1
        delog(max)
        if !sender.isSelected {
            
            let personView = TZImagePickerController.init(maxImagesCount: max, delegate: self)
            personView?.navigationBar.barTintColor = tabbarColor
            personView?.naviTitleColor = UIColor.white
            
            personView?.allowPickingVideo = false
            personView?.allowPickingGif = false
            personView?.sortAscendingByModificationDate = false
            viewController()?.present(personView!, animated: true, completion: nil)
        }else {
            
            let personView = TZImagePickerController.init(maxImagesCount: 1, delegate: self)
            personView?.navigationBar.barTintColor = tabbarColor
            personView?.naviTitleColor = UIColor.white
            
            personView?.allowPickingVideo = false
            personView?.allowPickingGif = false
            personView?.sortAscendingByModificationDate = false
            viewController()?.present(personView!, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: TZImagePickerController!,
                               didFinishPickingPhotos photos: [UIImage]!,
                               sourceAssets assets: [Any]!,
                               isSelectOriginalPhoto: Bool) {
        
        for pic in photos {
            if pic == photos.first {
                currentBtn.setImage(pic, for: .normal)
                currentBtn.isSelected = true
                currentBtn.layer.cornerRadius = 5.0
            }else {
                let tmpBtn = self.viewWithTag(currentBtn.tag + 1) as! UIButton
                tmpBtn.setImage(pic, for: .normal)
                tmpBtn.isSelected = true
                tmpBtn.isHidden = false
                currentBtn = tmpBtn
            }
        }
        
        NewReturnPicTableViewCell_Image.removeAll()
        for btn in btnArr {
            if btn.isSelected {
                NewReturnPicTableViewCell_Image.append(btn.imageView!.image!)
            }
        }
    }
}
