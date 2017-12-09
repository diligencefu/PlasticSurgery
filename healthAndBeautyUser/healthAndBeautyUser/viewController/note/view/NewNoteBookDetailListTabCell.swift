//
//  NewNoteBookDetailListTabCell.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/9/20.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewNoteBookDetailListTabCell: NewMineNoteListTableViewCell {
    
    private var _noteModel : NewNoteEnterListModel?
    var noteModel : NewNoteEnterListModel? {
        didSet {
            _noteModel = noteModel
            self.didSetModel(noteModel!)
        }
    }

    private func didSetModel(_ model: NewNoteEnterListModel) {
        follow.isHidden = true
        head.kf.setImage(with: URL.init(string: model.photo.first!))
    
        name.text = model.nick_name
        time.text = model.create_date
    
        note.text = model.content
        detail.text = model.content
    
        leftImg.kf.setImage(with: URL.init(string: model.preop_images))
        rightImg.kf.setImage(with: URL.init(string: model.images))
    
        btnArr[0].setImage(UIImage(named:"24_browse_icon_default"), for: .normal)
        btnArr[0].setTitle("浏览 · \(model.hits)", for: .normal)
        btnArr[0].layoutButton(with: .left, imageTitleSpace: 5)
    
        btnArr[1].setImage(UIImage(named:"25_comment_icon_default"), for: .normal)
        btnArr[1].setTitle("评论 · \(model.comments)", for: .normal)
        btnArr[1].layoutButton(with: .left, imageTitleSpace: 5)
        
        btnArr[2].setImage(UIImage(named:"22_appreciate_icon_default"), for: .normal)
        btnArr[2].setTitle("赞 · \(model.thumbs)", for: .normal)
        btnArr[2].layoutButton(with: .left, imageTitleSpace: 5)
    }
}
