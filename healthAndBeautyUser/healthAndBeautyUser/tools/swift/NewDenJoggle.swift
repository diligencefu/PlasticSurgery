//
//  NewFuJoggle.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/9/2.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

let DenNew = cbbNew
let DenImg = cbbNew
let Den2New = cbbNew

// MARK: - 第一部分-122IP
// 2.获取项目分类对应的日记本列表 ,不传参数表示获取所有数据,传参数，则根据参数来筛选查询相应的数据（从我的窗口点击进入日记）
let get_diary_classifyJoggle = "\(DenNew)/madical/m/rongxing/log/get_diary_classify"

// 3.点赞接口
let doThumbsJoggle = "\(DenNew)/madical/m/rongxing/log/doThumbs"

// 4.根据日记本id获取日记本对应的个人信息,医生，产品信息 以及包含的所有简版日记（从首页我进入的）
let userListJoggle = "\(DenNew)/madical/m/rongxing/log/userList"

// 5.点击简版日记获取详细日记，以及对应的评论等，同时修改该篇日记的浏览数
let resolveJoggle = "\(DenNew)/madical/m/rongxing/log/resolve"

// 6.获取医生的详情接口
let getDoctorJoggle = "\(DenNew)/madical/m/rongxing/log/getDoctor"

// 8.从首页的日记本入口，展示日记本栏目里面所有的我的日记本列表
let getMylogJoggle = "\(DenNew)/madical/m/rongxing/log/getMylog"

// 9.从首页的日记本入口，获取日记本对应的日记列表
let getMyDiaryJoggle = "\(DenNew)/madical/m/rongxing/log/getMyDiary"

// 10.新建日记本
let insertlogJoggle = "\(DenNew)/madical/m/rongxing/log/insertlog"

// 11.获取所有订单编号及相关商品信息
let getOrderJoggle = "\(DenNew)/madical/m/rongxing/log/getOrder"

// 12.个人信息
let get_MydataJoggle = "\(DenNew)/madical/m/rongxing/log/get_Mydata"

// 13.获取医生页面
let getDoctorPageJoggle = "\(DenNew)/madical/m/rongxing/log/getDoctorPage"

// MARK: - 第二部分-102IP
// 1.写日记的模板信息
let ModeleArticleJoggle = "\(DenNew)/madical/m/rongxing/InfoArticle/ModeleArticle"

// 2.写日记
let buildArticleJoggle = "\(DenNew)/madical/m/rongxing/InfoArticle/buildArticle"

// 4.评论日记
let ContontArticleJoggle = "\(DenNew)/madical/m/rongxing/InfoArticle/ContontArticle"

// 5.删除评论
let DeleteContontJoggle = "\(DenNew)/madical/m/rongxing/InfoArticle/DeleteContont"

// 6.评论回复
let ReplyContontJoggle = "\(DenNew)/madical/m/rongxing/InfoArticle/ReplyContont"

// 7.删除评论回复
let DeleteReplyJoggle = "\(DenNew)/madical/m/rongxing/InfoArticle/DeleteReply"
