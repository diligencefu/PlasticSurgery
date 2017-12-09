//
//  NewMineBookModel.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/18.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

class NewMineBookModel: NSObject {

//    41.我的优惠券列表接口:
//    http://192.168.1.104:8080/madical/m/rongxing/coupon/userCoupons
//    提交方式：get
//    请求参数:
//    SESSIONID  登录成功返回的sessionId
//    mobileCode 手机识别码
//    type 优惠券类型 1：预约  2：尾款
//    pageNo 分页
//
//    {"code":1,"data":{"userCoupons":[{"id":"e0e55220538a4b1391bb69f920edda61","createDate":"2017-10-25 18:06:29","counponId":"4b6f2291e11443dda63829d1258d22ae","receiveNum":5,"userNum":0,"coupon":{"id":"4b6f2291e11443dda63829d1258d22ae","createDate":"2017-10-24 20:04:02","updateDate":"2017-10-24 20:04:02","couponName":"冬季优惠卡","counponAmount":66.0,"couponEndDate":"2017-10-31 20:03:50","counponStartDate":"2017-10-24 20:03:48","counponKind":"2","counponUsingRange":"2","counponExplain":"满499.0元减66.0元","meetPrice":499.0,"collarNum":5,"projectNames":"开外眼角,韩式割眼角"},"status":"1"},{"id":"d62be4cb17e64fc08ea9870c94bbf108","createDate":"2017-10-25 18:18:24","counponId":"ff47fee909da40c4b1d9a6795642fda4","receiveNum":1,"userNum":0,"coupon":{"id":"ff47fee909da40c4b1d9a6795642fda4","createDate":"2017-10-25 14:56:11","updateDate":"2017-10-25 14:56:11","couponName":"万圣大酬宾","counponAmount":500.0,"couponEndDate":"2017-11-04 14:55:57","counponStartDate":"2017-10-27 14:55:53","counponKind":"2","counponUsingRange":"1","counponExplain":"满88.0元减500.0元","meetPrice":88.0,"collarNum":3},"status":"2"}],"totalPage":1}}
//    counponId 优惠券编号
//    status 优惠券状态  1：可使用状态  2：优惠券不可使用(未到使用开始时间) 3：优惠券已失效
//    receiveNum 领取数量
//    userNum 使用数量  (同一张优惠券可使用的数量=领取数量-使用数量，不存在可用数量为零，已做判断处理)
//    coupon 优惠券信息
//    id  优惠券编号 和counponId值一样
//    couponName 优惠券名称
//    counponAmount 优惠券面额
//    counponStartDate 优惠券生效开始时间
//    couponEndDate    优惠券过期时间
//    counponKind 优惠券种类 1.预约 2.尾款
//    counponUsingRange 优惠券类型:1.项目产品通用类（适合所有项目产品）2.项目产品类
//    projectNames 优惠券相关项目(优惠券类型为项目产品类时才有该字段)
//    counponExplain 优惠券说明
//    meetPrice 优惠券使用满足条件(满多少钱可以使用)
//    totalPage 总页数
    var counponId = String()
    var status = String()
    var receiveNum = Int()
    var userNum = Int()
    var couponName = String()
    var counponAmount = Float()
    var counponStartDate = String()
    var couponEndDate = String()
    var counponKind = String()
    var counponUsingRange = String()
    var projectNames = String()
    var counponExplain = String()
    var meetPrice = Float()
    
    //领券中心新增
    var collarNum = Int()
    var isCenter = Bool()
}
