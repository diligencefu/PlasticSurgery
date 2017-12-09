//
//  NewNoteEnterDetail_2Model.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/10/20.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewNoteEnterDetail_2Model: NSObject {

    var isMe = Bool()
    var isThumb = Bool()
    var isEnshrine = Bool()
    var isReword = Bool()
    var isFollow = Bool()
    
    var dicTags = [NewNoteEnterDetail_2Model_DicTags]()
    var comments = [NewNoteEnterDetail_2Model_Comments]()
    var product = NewNoteDetail_2Model_Product()
    var personal = NewNoteDetail_2Model_Personal()
    var personals = [NewNoteDetail_2Model_Personal]()
    var article = NewNoteDetail_2Model_Articles()
    var docotrs = [NewNoteDetail_2Model_docotrs]()
}

class NewNoteEnterDetail_2Model_Comments: NSObject {
    
    var id = String()
    var createDate = String()
    var content = String()
    var replyCount = Int()
    var commen = String()
    var personal = NewNoteDetail_2Model_Personal()
    var replys = [NewNoteEnterDetail_2Model_Replies]()
}

class NewNoteEnterDetail_2Model_Replies: NSObject {
//    "replies" : [
//    {
//    "id" : "1",
//    "createDate" : "2017-10-15 03:25:00",
//    "content" : "哈哈哈哈哈哈",
//    "commentId" : "1",
//    "user" : {
//    "id" : "e141de9481f8480eaab954e22b192092",
//    "roleNames" : "",
//    "admin" : false,
//    "name" : "李科"
//    }
//    },
//    {
//    "id" : "5ab60faa816f4044a14019b3f6e2c782",
//    "createDate" : "2017-10-17 20:14:31",
//    "content" : "是否想起那一刻的安宁",
//    "commentId" : "1",
//    "user" : {
//    "id" : "e141de9481f8480eaab954e22b192092",
//    "roleNames" : "",
//    "admin" : false,
//    "name" : "李科"
//    }
//    }
//    ],
    var id = String()
    var createDate = String()
    var content = String()
    var commentId = String()
    //
        var userId = String()
        var userName = String()
        var admin = Bool()
        var userRoleNames = String()
}

class NewNoteEnterDetail_2Model_DicTags: NSObject {
    
    var id = String()
    var tarContent = String()
}
