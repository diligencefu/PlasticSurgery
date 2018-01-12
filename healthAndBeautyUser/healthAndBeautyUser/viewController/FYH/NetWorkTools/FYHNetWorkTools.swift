//
//  FYHNetWorkTools.swift
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/16.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


//MARK:66.我的消息点赞记录列表接口:(详情跳入用户详情信息)
public func NetWorkForthumbList(params:[String:Any],callBack:((Array<Any>,String,Bool)->())?) ->  Void {
    var dataArr = [NewMineMessageAssitModel]()
    Alamofire.request(kApi_thumbList,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].intValue
                                let pageNum = JSOnDictory["data"]["totalPage"].stringValue
                                let data = JSOnDictory["data"]["thumbList"].arrayValue

                                if code == 1 {
                                    for index in 0..<data.count {
                                        let json = JSON(data[index])
                                        let model = NewMineMessageAssitModel.setValueForNewMineMessageAssitModel(json: json)
                                        dataArr.append(model)
                                    }
                                    callBack!(dataArr,pageNum,true)
                                }else{
                                    SVPwillShowAndHide(JSOnDictory["message"].string!)
                                    if code == 2 {
                                        Defaults.remove("SESSIONID")
                                    }
                                    callBack!(dataArr,pageNum,false)
                                }
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr,"pageNum",false)
                        }
    }
}


//MARK:67.删除点赞记录
public func NetWorkForDeletethumbList(params:[String:Any],callBack:((Bool)->())?) ->  Void {
    Alamofire.request(kApi_delThumb,
                      method: .post, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].intValue
                                if code == 1 {
                                    callBack!(true)
                                }else{
                                    callBack!(false)
                                }
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(false)
                        }
    }
}

//MARK:68.我的新粉丝通知列表:(不能删除)(详情跳入用户详情信息)
public func NetWorkForNewFansList(params:[String:Any],callBack:((Array<Any>,String,Bool)->())?) ->  Void {
    var dataArr = [FYHMineMessgeAllModel]()
    Alamofire.request(kApi_followList,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].intValue
                                let pageNum = JSOnDictory["data"]["totalPage"].stringValue
                                let data = JSOnDictory["data"]["followList"]

                                if code == 1 {
                                    for index in 0..<data.count {
                                        let json = JSON(data[index])
                                        let model = FYHMineMessgeAllModel.setValueForFYHMineMessgeAllModel(json: json)
                                        dataArr.append(model)
                                    }
                                    callBack!(dataArr,pageNum,true)
                                }else{
                                    callBack!(dataArr,pageNum,false)
                                }
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr,"pageNum",false)
                        }
    }
}


//MARK:69.任务中心数据:)
public func NetWorkFortaskCenter(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {
    var dataArr = [NewMineMessageAssitModel]()
    Alamofire.request(kApi_taskCenter,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].intValue
                                let data = JSOnDictory["data"]["thumbList"].arrayValue
                                
                                if code == 1 {
                                    for index in 0..<data.count {
                                        let json = JSON(data[index])
                                        let model = NewMineMessageAssitModel.setValueForNewMineMessageAssitModel(json: json)
                                        dataArr.append(model)
                                    }
                                    callBack!(dataArr,true)
                                }else{
                                    callBack!(dataArr,false)
                                }
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr,false)
                        }
    }
}


//MARK:70.积分明细接口:
public func NetWorkForIntegralDetail(params:[String:Any],callBack:((Array<Any>,String,Bool)->())?) ->  Void {
    var dataArr = [NewMineMessageAssitModel]()
    Alamofire.request(kApi_integralDetail,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].intValue
                                let pageNum = JSOnDictory["data"]["totalPage"].stringValue
                                let data = JSOnDictory["data"]["thumbList"].arrayValue
                                
                                if code == 1 {
                                    for index in 0..<data.count {
                                        let json = JSON(data[index])
                                        let model = NewMineMessageAssitModel.setValueForNewMineMessageAssitModel(json: json)
                                        dataArr.append(model)
                                    }
                                    callBack!(dataArr,pageNum,true)
                                }else{
                                    callBack!(dataArr,pageNum,false)
                                }
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr,"pageNum",false)
                        }
    }
}


//MARK:71. 转盘抽奖奖项列表
public func NetWorkForPrizeList(params:[String:Any],callBack:((Array<Any>,String,String,String,Bool)->())?) ->  Void {
    var dataArr = [FYHIntegralModel]()
    Alamofire.request(kApi_prizeList,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].intValue
                                let consumptionIntegral = JSOnDictory["data"]["consumptionIntegral"].stringValue
                                let times = JSOnDictory["data"]["times"].stringValue
                                let integral = JSOnDictory["data"]["integral"].stringValue
                                let data = JSOnDictory["data"]["prizes"].arrayValue
                                
                                if code == 1 {
                                    for index in 0..<data.count {
                                        let json = JSON(data[index])
                                        let model = FYHIntegralModel.setValueForFYHIntegralModel(json: json)
                                        dataArr.append(model)
                                    }
                                    callBack!(dataArr,times,consumptionIntegral,integral,true)
                                }else{
                                    callBack!(dataArr,times,times,times,false)
                                }
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr,"pageNum","pageNum","pageNum",false)
                        }
    }
}



//MARK:72.用户抽奖:
public func NetWorkForChoujiangJieGuo(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {
    var dataArr = [FYHIntegralModel]()
    Alamofire.request(kApi_prize,
                      method: .post, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].intValue
                                let data = JSOnDictory["data"]["prize"]
                                
                                if code == 1 {
                                    let model = FYHIntegralModel.setValueForFYHIntegralModel(json: data)
                                    dataArr.append(model)
                                    callBack!(dataArr,true)
                                }else{
                                    callBack!(dataArr,false)
                                }
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr,false)
                        }
    }
}


//MARK:73.限量抢兑商品列表:无分页
public func NetWorkForCommoditys(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {
    var dataArr = [FYHConvertGoodsModel]()
    Alamofire.request(kApi_commoditys,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].intValue
                                let data = JSOnDictory["data"]["commoditys"].arrayValue
                                if code == 1 {
                                    for index in 0..<data.count {
                                        let json = JSON(data[index])
                                        let model = FYHConvertGoodsModel.setValueForFYHConvertGoodsModel(json: json)
                                        dataArr.append(model)
                                    }
                                    callBack!(dataArr,true)
                                }else{
                                    callBack!(dataArr,false)
                                }
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr,false)
                        }
    }
}

//MARK:78.用户抽奖奖品列表:
public func NetWorkForUserPrizes(params:[String:Any],callBack:((Array<Any>,Int,Bool)->())?) ->  Void {
    var dataArr = [FYHShowGetGoodsModel]()
    Alamofire.request(kApi_userPrizes,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].intValue
                                let totalPage =  JSOnDictory["data"]["totalPage"].intValue
                                let data = JSOnDictory["data"]["userPrizes"].arrayValue
                                if code == 1 {
                                    for index in 0..<data.count {
                                        let json = JSON(data[index])
                                        let model = FYHShowGetGoodsModel.setValueForFYHShowGetGoodsModel(json: json)
                                        dataArr.append(model)
                                    }
                                    callBack!(dataArr,totalPage,true)
                                }else{
                                    callBack!(dataArr,totalPage,false)
                                }
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr,1,false)
                        }
    }
}


//MARK:79.用户领取实物奖励接口:
public func NetWorkForCollarPrize(params:[String:Any],callBack:((Bool)->())?) ->  Void {
    Alamofire.request(kApi_collarPrize,
                      method: .post, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].intValue
                                if code == 1 {
                                    callBack!(true)
                                }else{
                                    callBack!(false)
                                    SVPwillShowAndHide(JSOnDictory["message"].stringValue)
                                }
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(false)
                        }
    }
}


//MARK:87.积分订单列表接口:(无分页)
public func NetWorkForIntegralOrderList(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {
    var dataArr = [FYHIntergralGoodsModel]()
    Alamofire.request(kApi_orderList,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].intValue
                                let data = JSOnDictory["data"]["orderList"].arrayValue
                                
                                if code == 1 {
                                    for index in 0..<data.count {
                                        let json = JSON(data[index])
                                        let model = FYHIntergralGoodsModel.setValueForFYHIntergralGoodsModel(json: json)
                                        dataArr.append(model)
                                    }
                                    callBack!(dataArr,true)
                                }else{
                                    callBack!(dataArr,false)
                                }
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr,false)
                        }
    }
}




//MARK:91.消息列表接口:(不含通知类消息)
public func NetWorkForUseMessages(params:[String:Any],type:NSInteger,callBack:((Array<Any>,String,Bool)->())?) ->  Void {
    var dataArr = [FYHMineMessgeAllModel]()
    Alamofire.request(kApi_useMessages,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].intValue
//                                let data = JSOnDictory["data"]["bannerPositions"].arrayValue
                                let pageNum = JSOnDictory["data"]["totalPage"].stringValue

                                var data = JSOnDictory["data"]["messages"].arrayValue
                                
//                                if type == 3 {
//                                    data = JSOnDictory["data"]["followList"].arrayValue
//                                }
//                                
//                                if type == 2 {
//                                    data = JSOnDictory["data"]["followList"].arrayValue
//                                }
//                                
//                                if type == 1 {
//                                    data = JSOnDictory["data"]["followList"].arrayValue
//                                }

                                if code == 1 {
                                    for index in 0..<data.count {
                                        let json = JSON(data[index])
                                        let model = FYHMineMessgeAllModel.setValueForFYHMineMessgeAllModel(json: json)
                                        dataArr.append(model)
                                    }
                                    callBack!(dataArr,pageNum,true)
                                }else{
                                    callBack!(dataArr,pageNum,false)
                                }
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr,"",false)
                        }
    }
}

//MARK:92.通知类消息列表接口:
public func NetWorkForUseNotifies(params:[String:Any],callBack:((Array<Any>,String,Bool)->())?) ->  Void {
    var dataArr = [FYHShowNotiModel]()
    Alamofire.request(kApi_useNotifies,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].intValue
                                let data = JSOnDictory["data"]["notifies"].arrayValue
                                let pageNum = JSOnDictory["data"]["totalPage"].stringValue
                                if code == 1 {
                                    for index in 0..<data.count {
                                        let json = JSON(data[index])
                                        let model = FYHShowNotiModel.setValueForFYHShowNotiModel(json: json)
                                        dataArr.append(model)
                                    }
                                    callBack!(dataArr,pageNum,true)
                                }else{
                                    callBack!(dataArr,pageNum,false)
                                }
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr,"",false)
                        }
    }
}

//MARK:93.点击通知详情更改通知已读状态:
public func NetWorkForReadNotify(params:[String:Any],callBack:((Bool)->())?) ->  Void {
    Alamofire.request(kApi_readNotify,
                      method: .post, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].intValue
                                if code == 1 {
                                    callBack!(true)
                                }else{
                                    callBack!(false)
                                }
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(false)
                        }
    }
}


//MARK:95.搜索接口:
public func NetWorkForSerchAll(params:[String:Any],callBack:((Array<Any>,String,Bool)->())?) ->  Void {
    
    var caseDataArr = [FYHShowNotiModel]()
    var projectDataArr = [FYHShowNotiModel]()
    var goodsDataArr = [FYHShowNotiModel]()
    var doctorDataArr = [FYHShowNotiModel]()
    var userDataArr = [FYHShowNotiModel]()
    
    Alamofire.request(kApi_serch,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].intValue
                                let pageNum = JSOnDictory["data"]["totalPage"].stringValue
                                
                                 var caseDatas = JSOnDictory["data"]["serchArticle"].arrayValue
                                 var projectDatas = JSOnDictory["data"]["serchProducts"].arrayValue
                                 var goodsDatas = JSOnDictory["data"]["serchGoods"].arrayValue
                                 var doctorDatas = JSOnDictory["data"]["serchDoctors"].arrayValue
                                 var userDatas = JSOnDictory["data"]["serchUsers"].arrayValue
                                
                                 if code == 1 {
 //                                   案例数据
                                    for index in 0..<caseDatas.count {
                                        let json = JSON(caseDatas[index])
                                        let model = FYHShowNotiModel.setValueForFYHShowNotiModel(json: json)
                                        caseDataArr.append(model)
                                    }
//                                    项目数据
                                    for index in 0..<projectDatas.count {
                                        let json = JSON(projectDatas[index])
                                        let model = FYHShowNotiModel.setValueForFYHShowNotiModel(json: json)
                                        projectDataArr.append(model)
                                    }
//                                    商品数据
                                    for index in 0..<goodsDatas.count {
                                        let json = JSON(goodsDatas[index])
                                        let model = FYHShowNotiModel.setValueForFYHShowNotiModel(json: json)
                                        goodsDataArr.append(model)
                                    }
//                                    医生数据
                                    for index in 0..<doctorDatas.count {
                                        let json = JSON(doctorDatas[index])
                                        let model = FYHShowNotiModel.setValueForFYHShowNotiModel(json: json)
                                        doctorDataArr.append(model)
                                    }
//                                    用户数据
                                    for index in 0..<userDatas.count {
                                        let json = JSON(userDatas[index])
                                        let model = FYHShowNotiModel.setValueForFYHShowNotiModel(json: json)
                                        userDataArr.append(model)
                                    }
                                    
                                    callBack!(userDataArr,pageNum,true)
                                }else{
                                    callBack!(userDataArr,pageNum,false)
                                }
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(userDataArr,"",false)
                        }
    }
}











//MARK:首页广告展示:(无分页)
public func NetWorkForUserbanner_getBanners(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {
    var dataArr = [FYHSowMainADModel]()
    Alamofire.request(kApi_getBanners,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].intValue
                                let data = JSOnDictory["data"]["bannerPositions"].arrayValue
                                if code == 1 {
                                    for index in 0..<data.count {
                                        let json = JSON(data[index])
                                        let model = FYHSowMainADModel.setValueForFYHSowMainADModel(json: json)
                                        dataArr.append(model)
                                    }
                                    callBack!(dataArr,true)
                                }else{
                                    callBack!(dataArr,false)
                                }
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr,false)
                        }
    }
}


//MARK:92.通知类消息列表接口:
public func NetWorkForMainADGroup(params:[String:Any],callBack:((Array<Any>,Bool)->())?) ->  Void {
    var dataArr = [iconModel]()
    Alamofire.request(kApi_getIcons,
                      method: .get, parameters: params,
                      encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
                        deBugPrint(item: response.result)
                        switch response.result {
                        case .success:
                            if let j = response.result.value {
                                //SwiftyJSON解析数据
                                let JSOnDictory = JSON(j)
                                let code =  JSOnDictory["code"].intValue
                                let data = JSOnDictory["data"]["icon"].dictionaryValue
                                if code == 1 {
                                    for sring in data.keys {
                                        let model = iconModel()
                                        model.title = kGetIconName(str: sring)
                                        model.img = (data[sring]?.stringValue)!
                                        dataArr.append(model)
                                    }
                                    callBack!(dataArr,true)
                                }else{
                                    callBack!(dataArr,false)
                                }
                            }
                            break
                        case .failure(let error):
                            deBugPrint(item: error)
                            callBack!(dataArr,false)
                        }
    }
}




class FYHNetWorkTools: NSObject {
    
}
