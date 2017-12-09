//
//  NewCBBJoggle.swift
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/9/2.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit

let cbbNew = "http://192.168.1.104:8080/"
//let cbbNew = "http://47.93.220.246:8088/"

//  MARK: - 基本接口-》新医美接口文档.txt
//  1.发送验证码接口:
let getSmsJoggle = "\(cbbNew)madical/m/rongxing/user/getSms"

//  2.登录接口:
let loginJoggle = "\(cbbNew)madical/a/login?_ajax=true"

//  3.注册找回密码接口:
let operationUserJoggle = "\(cbbNew)madical/m/rongxing/user/operationUser"

//  4.修改密码接口:--->未实现
let updatePasswordJoggle = "\(cbbNew)madical/m/rongxing/user/updatePassword"

//  5.生成邀请推荐码接口:--->未实现
let createReferralCodeJoggle = "\(cbbNew)madical/m/rongxing/user/createReferralCode"

//  6.整形百科页面数据接口:
let getProjects_06_joggle = "\(cbbNew)madical/m/rongxing/project/getProjects"

//  7.整形百科项目详情页数据接口:
let getprojectJoggle = "\(cbbNew)madical/m/rongxing/project/getproject"

//  7.1. 关注接口:
let addFollowJoggle = "\(cbbNew)madical/m/rongxing/user/addFollow"

//  7.2. 用户关注列表:
let followListJoggle = "\(cbbNew)madical/m/rongxing/user/followList"

//  7.3. 取消关注接口:
let getUnfollowJoggle = "\(cbbNew)madical/m/rongxing/user/getUnfollow"

//  7.4.普通用户个人资料接口：
let getPersonalInfoJoggle = "\(cbbNew)madical/m/rongxing/user/getPersonalInfo"

//  7.5.普通用户发表的日记列表接口：
let getUserArticlesJoggle = "\(cbbNew)madical/m/rongxing/user/getUserArticles"

//  7.6.用户粉丝列表接口：
let fanListJoggle = "\(cbbNew)madical/m/rongxing/user/fanList"

//  7.7. 我的个人主页数据接口：
let getInfoJoggle = "\(cbbNew)madical/m/rongxing/user/getInfo"

//  7.8. 收藏或取消收藏接口:
let saveEnshrineJoggle = "\(cbbNew)madical/m/rongxing/user/saveEnshrine"

//  7.9. 我的收藏列表接口:
let getEnshrinesJoggle = "\(cbbNew)madical/m/rongxing/user/getEnshrines"

//  8.项目详情页面了解更多信息接口:(返回H5页面)
let getProjectContentJoggle = "\(cbbNew)madical/m/rongxing/project/getProjectContent"

//  7.加入购物车接口:（项目产品和普通产品统称商品）
let addShopCar_07_joggle = "\(cbbNew)madical/m/rongxing/shopCar/addShopCar"

//  8.购物车列表接口:
let shopCarList_08_joggle = "\(cbbNew)madical/m/rongxing/shopCar/shopCarList"

//  9.普通商品列表接口:
let goodItemList_09_joggle = "\(cbbNew)madical/m/rongxing/good/goodItemList"

//  10.普通商品详情:
let getGoodItem_10_joggle = "\(cbbNew)madical/m/rongxing/good/getGoodItem"

//  11.普通商品评论列表:
let goodCommentList_11_joggle = "\(cbbNew)madical/m/rongxing/good/goodCommentList"

//  12.项目产品列表接口:
let productList_12_joggle = "\(cbbNew)madical/m/rongxing/product/productList"

//  13.项目产品详情页面:
let getProduct_13_joggle = "\(cbbNew)madical/m/rongxing/product/getProduct"

//  14.项目产品日记列表接口:
let getProductArticles_14_joggle = "\(cbbNew)madical/m/rongxing/product/getProductArticles"

//  15.立即购物接口:
let buy_15_joggle = "\(cbbNew)madical/m/rongxing/shopCar/buy"

//  16.加入购物车接口:（项目产品和普通产品统称商品）
let addShopCar_16_joggle = "\(cbbNew)madical/m/rongxing/shopCar/addShopCar"

//  17.购物车列表接口:
let shopCarList_17_joggle = "\(cbbNew)madical/m/rongxing/shopCar/shopCarList"

//  18.删除购物车接口:
let delShopCar_18_joggle = "\(cbbNew)madical/m/rongxing/shopCar/delShopCar"

//  19.购物车分开结算页面接口:(购物车里面存在不同类型商品时应分开结算,根据列表中goodType判断,同一类型商品结算不调用此接口)
let shopCar_19_joggle = "\(cbbNew)madical/m/rongxing/shopCar/shopCar"

//  20.确认订单页面数据接口:
let confirmOrder_20_joggle = "\(cbbNew)madical/m/rongxing/shopCar/confirmOrder"

//  22.新增或修改订单收货地址接口:(最多新增10个)
let saveDeliveryAddress_22_joggle = "\(cbbNew)madical/m/rongxing/shopCar/saveDeliveryAddress"

//  23.用户订单收货地址列表接口:(无分页)
let deliveryAddressList_23_joggle = "\(cbbNew)madical/m/rongxing/shopCar/deliveryAddressList"

//  24.用户删除订单收货地址接口:
let daleteDeliveryAddress_24_joggle = "\(cbbNew)madical/m/rongxing/shopCar/daleteDeliveryAddress"

//  25.提交订单接口:(普通商品不传优惠券信息)
let createOrder_25_joggle = "\(cbbNew)madical/m/rongxing/order/createOrder"

//  26.支付页面数据接口:
let pay_26_joggle = "\(cbbNew)madical/m/rongxing/order/pay"

//  27.取消订单接口:
let cancleOrder_27_joggle = "\(cbbNew)madical/m/rongxing/order/cancleOrder"

//  28.选中余额支付时判断用于有没有设置支付密码:
let checkBalance_28_joggle = "\(cbbNew)madical/m/rongxing/order/checkBalance"

//  29.余额支付验证支付密码接口:
let checkPayPwd_29_joggle = "\(cbbNew)madical/m/rongxing/order/checkPayPwd"

//  30.余额支付成功接口:
let payByBalance_30_joggle = "\(cbbNew)madical/m/rongxing/order/payByBalance"

//  31.支付宝支付加签操作接口:
let payByAlipay_31_joggle = "\(cbbNew)madical/m/rongxing/order/payByAlipay"

//  32.微信支付加签操作接口:
let payByWechat_32_joggle = "\(cbbNew)madical/m/rongxing/order/payByWechat"

//  33.支付宝支付成功同步通知支付结果接口:
let synchronization_33_joggle = "\(cbbNew)madical/m/rongxing/alipay/synchronization"

//  34.微信支付查询支付结果接口:
let orderPayQuery_34_joggle = "\(cbbNew)madical/m/rongxing/wechat/orderPayQuery"

//  35.用户设置余额支付密码:
let setPayPwd_35_joggle = "\(cbbNew)madical/m/rongxing/user/setPayPwd"

//  36.用户修改支付密码:
let updatePayPwd_36_joggle = "\(cbbNew)madical/m/rongxing/user/updatePayPwd"

//  37.用户个人资料接口:
let getUserInfo_37_joggle = "\(cbbNew)madical/m/rongxing/user/getUserInfo"

//  38.个人资料修改接口:
let updateUserInfo_38_joggle = "\(cbbNew)madical/m/rongxing/user/updateUserInfo"

//  39.优惠券中心待领取的优惠券列表:
let couponList_39_joggle = "\(cbbNew)madical/m/rongxing/coupon/couponList"

//  40.用户领取优惠券:
let receiveCoupon_40_joggle = "\(cbbNew)madical/m/rongxing/coupon/receiveCoupon"

//  41.我的优惠券列表接口:
let userCoupons_41_joggle = "\(cbbNew)madical/m/rongxing/coupon/userCoupons"

//  42.待付款的项目订单列表:无分页
let stayOrderList_42_joggle = "\(cbbNew)madical/m/rongxing/order/stayOrderList"

//  43.待付款的项目订单详情:
let stayOrder_43_joggle = "\(cbbNew)madical/m/rongxing/order/stayOrder"

//  44.用户项目订单列表:（待确认  已支付   已完成）
let productOrders_44_joggle = "\(cbbNew)madical/m/rongxing/order/productOrders"

//  45.项目订单详情信息接口:
let productOrder_45_joggle = "\(cbbNew)madical/m/rongxing/order/productOrder"

//  46.项目订单尾款支付页面接口:
let payRetainage_46_joggle = "\(cbbNew)madical/m/rongxing/order/payRetainage"

//  47.支付宝支付尾款接口：
let payRetainageByAlipay_47_joggle = "\(cbbNew)madical/m/rongxing/order/payRetainageByAlipay"

//  48.微信支付尾款接口:
let payRetainageByWechat_48_joggle = "\(cbbNew)madical/m/rongxing/order/payRetainageByWechat"

//  49.余额支付成功接口:(须调用前面余额密码验证接口)
let payRetainageByBalance_49_joggle = "\(cbbNew)madical/m/rongxing/order/payRetainageByBalance"

//  50.项目订单申请退预约金接口:
let refundProductOrder_50_joggle = "\(cbbNew)madical/m/rongxing/order/refundProductOrder"

//  51.项目退款订单列表：
let getRefundOrders_51_joggle = "\(cbbNew)madical/m/rongxing/order/getRefundOrders"

//  52.项目退款订单详情:
let getRefundOrder_52_joggle = "\(cbbNew)madical/m/rongxing/order/getRefundOrder"

//  53.删除项目订单接口:(只有已完成的订单和退款成功或退款失败的订单才允许删除)
let delProductOrder_53_joggle = "\(cbbNew)madical/m/rongxing/order/delProductOrder"

//  54.待付款的商品订单列表:(无分页)
let stayGoodOrderList_54_joggle = "\(cbbNew)madical/m/rongxing/order/stayGoodOrderList"

//  55.待付款的商品订单详情:
let stayGoodOrder_55_joggle = "\(cbbNew)madical/m/rongxing/order/stayGoodOrder"

//  56.商品订单列表(不含退货)：分页
let goodOrders_56_joggle = "\(cbbNew)madical/m/rongxing/order/goodOrders"

//  57.商品订单详情:(不包括退货)
let goodOrder_57_joggle = "\(cbbNew)madical/m/rongxing/order/goodOrder"

//  58.商品订单确认收货接口:
let confirmGoodOrder_58_joggle = "\(cbbNew)madical/m/rongxing/order/confirmGoodOrder"

//  59.商品订单评论接口:
let comment_59_joggle = "\(cbbNew)madical/m/rongxing/order/comment"

//  60.商品退货申请：
let CreateOrderReturns_60_joggle = "\(cbbNew)/madical/m/rongxing/order/CreateOrderReturns"

//  61.商品退货列表:
let orderReturnsList_61_joggle = "\(cbbNew)madical/m/rongxing/order/orderReturnsList"

//  62.商品退货详情:
let orderReturns_62_joggle = "\(cbbNew)madical/m/rongxing/order/orderReturns"

//  63.商品退货删除操作:
let delOrderReturns_63_joggle = "\(cbbNew)madical/m/rongxing/order/delOrderReturns"

//  63.5.首页项目类别接口
let getProjectClassify_6305_joggle = "\(cbbNew)madical/m/rongxing/project/getProjectClassify"

//  64.首页推荐项目列表接口:
let productReconmentList_64_joggle = "\(cbbNew)madical/m/rongxing/product/productReconmentList"

//  65.首页推荐日记列表接口:
let getProjectClassifyArticles_65_joggle = "\(cbbNew)madical/m/rongxing/log/getProjectClassifyArticles"


//  MARK: - 其他接口-》
//  10.确认订单页面数据接口:
let confirmOrder_10_joggle = "\(cbbNew)madical/m/rongxing/shopCar/confirmOrder"

//  11.提交订单选择优惠券列表接口:请求后放入缓存,选中本地更改优惠券状态，提交订单时清除缓存
let coupons_11_joggle = "\(cbbNew)madical/m/rongxing/coupon/coupons"

//  16.选中余额支付时判断用于有没有设置支付密码:
let checkBalance_16_joggle = "\(cbbNew)madical/m/rongxing/order/checkBalance"















let otherNew = "http://192.168.1.206:8080/"

//  68.获取手术动态视频list接口: wk
let getOperations__joggle = "\(otherNew)madical/m/rongxing/operation/getOperations"

//  69.获取手术动态单个视频接口: wk
let getOperation__joggle = "\(otherNew)madical/m/rongxing/operation/getOperation"


class NewCBBJoggle: NSObject {
    
    //Hello World
}
