//
//  NewMain_NoteListModel.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/9/22.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewMain_NoteListModel: NSObject {
    
//    articleList  日记文章信息（默认最新时间排列）
//    id 日记本编号
//    preopImages 术前照片(只有一张)
//    allowFollow  是否允许关注 true允许  false 不允许(即日记文章的作者为登录对象,自己不允许关注自己)
//    follow       是否关注过  true已关注 false 未关注
//    personal  日记作者信息
//    nickName 昵称
//    photo 头像
//    gender 性别
//    article 最新日记文章信息
//    id  日记文章编号
//    content 日记文章内容
//    images  日记文章图片(术后照片只有一张)
//    createDate 日记文章新建时间
//    comments  评论数
//    thumbs 点赞数
//    hits  浏览数
//    totalPage  日记文章分页总页数
    
    var id = String()
    var preopImages = String()
    var allowFollow = Bool()
    var follow = Bool()
//    var personal = String()
        var nickName = String()
        var personald = String()
        var photo = String()
        var gender = String()
//    var article = String()
        var aId = String()
        var content = String()
        var images = String()
        var createDate = String()
        var comments = String()
        var thumbs = String()
        var hits = String()
}
