//
//  wx_GlobalEnumSwiftFile.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/11.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

//我的首页   按钮  tag值枚举
enum MineList_MeCellBtnTag : NSInteger{
    
    //设置
    case set = 100
    //我 关注 粉丝 日记 收藏
    case me, follow, fans, note, collection
    
    //消息的更多
    case messageMore = 200
    //私信 评论 赞 新粉丝 通知
    case privateLetter,discuss,assist,newFans,notice
    
    //订单更多
    case orderMore = 300
    //全部 待付款 待使用 待写日志 退款
    case all,waitPay,waitUse,waitWrite,drawBack
    
    //积分商城
    case store = 400
    //任务中心 分销商 我的团队
    case job, bussness, famary
}

//我的首页 订单状态 枚举
enum MineOrderStateEnum : NSInteger {
    
    //状态枚举
    //所有，等待支付，待使用，待写日记，退款
    case all,waitPay,waitUse,waitWrite,drawBack
    
    //按钮tag枚举
    case cancelPayBtn = 800
    case wantPayBtn,wantDrawBackBtn,equalOrderBtn,payOtherBtn,deleteOrderBtn,writeNoteBtn,connectionBtn
}

//3-2-1-1的程度星级枚举
enum swelling_pain_car : NSInteger {
    
    //肿胀度 疼痛度 疤痕
    case swelling,pain,scar
}

enum StoreListViewControllerCurrentBtnTag : NSInteger {
    case project = 100
    case example
}

class wx_GlobalEnumSwiftFile: NSObject {

}
