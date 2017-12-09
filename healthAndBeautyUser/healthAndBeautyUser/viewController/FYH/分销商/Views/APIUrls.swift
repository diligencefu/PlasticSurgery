//
//  APIUrls.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/6.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

let baseUrl = "http://192.168.1.104:8080/madical/m/rongxing/"

//#MARK:1.会员产品列表接口:
let member_List = baseUrl + "distribution/memberList"

//#MARK2.立即购买接口:
let buy_api = baseUrl + "distribution/buy"

//#MARK:3.会员产品支付页数据接口:
let pay_Data = baseUrl + "distribution/payData"

//#MARK:4.支付宝加签接口:
let pay_ByAlipay = baseUrl + "distribution/payByAlipay"

//#MARK:5.微信加签接口:
let pay_ByWechat = baseUrl + "distribution/payByWechat"

//#MARK:6余额支付接口:(调用前使用以前判断是否设置支付密码和验证支付密码接口)
let pay_ByBalance = baseUrl + "distribution/payByBalance"

//#MARK:7.分销商信息接口
let user_Info = baseUrl + "distribution/userInfo"

//#MARK:8.星级奖励接口:
let vip_Stars = baseUrl + "distribution/vipStars"

//#MARK:9.我的推荐团队接口:(只针对直接下属)
let recommend_Users = baseUrl + "distribution/recommendUsers"

//#MARK:10.分销明细列表接口:
let commissions_api = baseUrl + "distribution/commissions"

//#MARK:11.删除分销明细:
let del_Commission = baseUrl + "distribution/delCommission"

//#MARK:12.会费返现记录列表:
let user_VipCashBacks = baseUrl + "distribution/userVipCashBacks"

//#MARK:13.会费返现详情:
let user_VipCashBack = baseUrl + "distribution/userVipCashBack"

//#MARK:14.支付宝充值加签接口:
let recharge_ByAlipay = baseUrl + "business/rechargeByAlipay"

//#MARK:15.微信充值加签操作:
let recharge_ByWechat = baseUrl + "business/rechargeByWechat"

//#MARK:16.充值记录列表:
let recharge_List = baseUrl + "business/rechargeList"

//#MARK:17.删除充值记录
let del_Recharge = baseUrl + "business/delRecharge"

//#MARK:18.提现页面信息：(支付宝和微信页面一样
let withdraw_Info = baseUrl + "business/withdrawInfo"

//#MARK:19.支付宝提现操作接口:
let withdraw_ByAlipay = baseUrl + "business/withdrawByAlipay"

//#MARK:20.提现记录列表:
let present_RecordList = baseUrl + "business/presentRecordList"

//#MARK:21.删除提现记录:
let del_PresentRecord = baseUrl + "business/delPresentRecord"

class APIUrls: NSObject {

}
