//
//  NewNoteRepeatModel.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/10/11.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewNoteRepeatModel: NSObject {
    
    var isMe = Bool()
    
    var comment_id = String()
    var comment_datea = String()
    var comment_photo = String()
    var comment_content = String()
    var my_comment = String()
    var comment_userId = String()
    var comment_name = String()
    
    var replys = [reply]()
}

class reply: NSObject {
    
    var reply_name = String()
    var my_reply = String()
    var reply_id = String()
    var reply_userId = String()
    var commentId = String()
    var reply_content = String()
}
