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

//#MARK:22.已完成的免费整形订单返现详情:
let user_OrderCashBack = baseUrl + "business/userOrderCashBack"




//#MARK:66.我的消息点赞记录列表接口:(详情跳入用户详情信息)
let kApi_thumbList = baseUrl + "notify/thumbList"

//#MARK:67删除点赞记录)
let kApi_delThumb = baseUrl + "notify/delThumb"

//#MARK:68.我的新粉丝通知列表:(不能删除)(详情跳入用户详情信息)
let kApi_followList = baseUrl + "notify/followList"

//#MARK:69.任务中心数据:
let kApi_taskCenter = baseUrl + "creditrule/taskCenter"

//#MARK:70.积分明细接口
let kApi_integralDetail = baseUrl + "creditrule/integralDetail"

//#MARK:71. 转盘抽奖奖项列表
let kApi_prizeList = baseUrl + "creditrule/prizeList"

//#MARK:72.用户抽奖
let kApi_prize = baseUrl + "creditrule/prize"

//#MARK:73.限量抢兑商品列表:无分页
let kApi_commoditys = baseUrl + "creditrule/commoditys"

//#MARK:74.积分商品详情前判断商品是不是上架状态:
let kApi_checkStatus = baseUrl + "creditrule/checkStatus"

//#MARK:75.积分商品详情接口:(采用H5)
let kApi_commodity = baseUrl + "creditrule/commodity"

//#MARK:76.商品图文信息接口:（H5
let kApi_imageText = baseUrl + "creditrule/imageText"

//#MARK:77.商品产品参数接口:(H5)
let kApi_commodityParam = baseUrl + "creditrule/commodityParam"

//#MARK:78.用户抽奖奖品列表:
let kApi_userPrizes = baseUrl + "creditrule/userPrizes"

//#MARK:79.用户领取实物奖励接口:
let kApi_collarPrize = baseUrl + "creditrule/collarPrize"

//#MARK:80.积分商品订单确认页面:
let kApi_confirm = baseUrl + "creditrule/confirm"

//#MARK:81.积分商品兑换提交接口:(之前需调用支付密码验证接口)
let kApi_exchange = baseUrl + "creditrule/exchange"

//#MARK:82.积分订单兑换邮费支付界面接口:
let kApi_payPostage = baseUrl + "creditrule/payPostage"

//#MARK:83.余额支付接口:
let kApi_payByBalance = baseUrl + "creditrule/payByBalance"

//#MARK:85.支付宝支付接口::
let kApi_payByAlipay = baseUrl + "creditrule/payByAlipay"

//#MARK:86.微信支付接口:
let kApi_payByWechat = baseUrl + "creditrule/payByWechat"

//#MARK:87.积分订单列表接口:(无分页):
let kApi_orderList = baseUrl + "creditrule/orderList"

//#MARK:88.积分订单详情:
let kApi_order = baseUrl + "creditrule/order"

//#MARK:89.取消积分订单接口:（待支付时可以取消)
let kApi_cancel = baseUrl + "creditrule/cancel"

//#MARK:90.确认收货接口:
let kApi_receipt = baseUrl + "creditrule/receipt"

//#MARK:91.消息列表接口:(不含通知类消息)
let kApi_useMessages = baseUrl + "notify/useMessages"

//#MARK:92.通知类消息列表接口:
let kApi_useNotifies = baseUrl + "notify/useNotifies"

//#MARK:93.点击通知详情更改通知已读状态:
let kApi_readNotify = baseUrl + "notify/readNotify"

//#MARK:94.用户未读消息数量:
let kApi_getMessageCount = baseUrl + "notify/getMessageCount"

//#MARK:95.搜索接口:
let kApi_serch = baseUrl + "notify/serch"

//#MARK:96.首页图标接口:
let kApi_getIcons = baseUrl + "banner/getIcons"

//#MARK:97.余额明细列表接口:
let kApi_accountList = baseUrl + "business/accountList"


//#MARK:*************庄熊飞广告接口**************
//#MARK:*************庄熊飞广告接口**************
//#MARK:*************庄熊飞广告接口**************
//#MARK:*************庄熊飞广告接口**************
//#MARK:*************庄熊飞广告接口**************

let baseUrlZXF = "http://192.168.1.214:8080/madical/m/rongxing/"
//#MARK:首页广告展示:(无分页)
let kApi_getBanners = baseUrlZXF + "banner/getBanners"


class APIUrls: NSObject {

}
