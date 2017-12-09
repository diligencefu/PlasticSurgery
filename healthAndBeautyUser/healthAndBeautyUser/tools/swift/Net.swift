//
//  healthAndBeautyUser
//  healthAndBeautyUser
//
//  Created by 吴玄 on 2017/8/30.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

private let NetworkRequestShareInstance = Net()

class Net {
    class var share : Net {
        return NetworkRequestShareInstance
    }
}

extension Net {
    //MARK: - GET 请求

    func getRequest(urlString: String,
                    params : [String : Any]?,
                    success : @escaping (_ response : [String : AnyObject])->(),
                    failture : @escaping (_ error : Error)->()) {
        
        Alamofire.request(urlString, method: .get, parameters: params)
            .responseJSON { (response) in
                switch response.result {
                case .success(_):
                    if let value = response.result.value as? [String: AnyObject] {
                        success(value)
                    }
                case .failure(let error):
                    failture(error)
                    delog("error:\(error)")
                }
        }
    }
    
    //MARK: - POST 请求
    func postRequest(urlString : String,
                     params : [String : Any]?,
                     success : @escaping (_ response : [String : AnyObject])->(),
                     failture : @escaping (_ error : Error)->()) {
        
        Alamofire.request(urlString, method: HTTPMethod.post, parameters: params).responseJSON { (response) in
            switch response.result{
            case .success:
                if let value = response.result.value as? [String: AnyObject] {
                    success(value)
                }
            case .failure(let error):
                failture(error)
                delog("error:\(error)")
            }
        }
    }
    
    // 这里是创建日记本用
    func upLoadImageRequest(urlString : String,
                            params:[String:String]!,
                            data: [Data],
                            name: [String],
                            success : @escaping (_ response : [String : AnyObject])->(), failture : @escaping (_ error : Error)->()){
        
        let headers = ["content-type":"multipart/form-data"]
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                
                multipartFormData.append((params["SESSIONID"]!.data(using: String.Encoding.utf8)!),
                                         withName: "SESSIONID")
                multipartFormData.append((params["mobileCode"]!.data(using: String.Encoding.utf8)!),
                                         withName: "mobileCode")
                multipartFormData.append((params["completeDate"]!.data(using: String.Encoding.utf8)!),
                                         withName: "completeDate")
                multipartFormData.append((params["productId"]!.data(using: String.Encoding.utf8)!),
                                         withName: "productId")
                multipartFormData.append((params["orderId"]!.data(using: String.Encoding.utf8)!),
                                         withName: "orderId")
                multipartFormData.append((params["projectName"]!.data(using: String.Encoding.utf8)!),
                                         withName: "projectName")
                multipartFormData.append((params["projectId"]!.data(using: String.Encoding.utf8)!),
                                         withName: "projectId")
                multipartFormData.append((params["completeDate"]!.data(using: String.Encoding.utf8)!),
                                         withName: "completeDate")
                multipartFormData.append((params["title"]!.data(using: String.Encoding.utf8)!),
                                         withName: "title")
                multipartFormData.append((params["ids"]!.data(using: String.Encoding.utf8)!),
                                         withName: "ids")
                for i in 0..<data.count {
                    multipartFormData.append(data[i], withName: "appPhoto", fileName: name[i], mimeType: "image/png")
                }
        },
            to: urlString,
            headers: headers,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        if let value = response.result.value as? [String: AnyObject]{
                            success(value)
                        }
                    }
                case .failure(let encodingError):
                    failture(encodingError)
                }
        }
        )
    }
    
    func createNoteUpLoadImageRequest(urlString : String,
                            params:[String:String],
                            data: [UIImage],
                            name: [String],
                            success : @escaping (_ response : [String : AnyObject])->(),
                            failture : @escaping (_ error : Error)->()){
        
        let headers = ["content-type":"multipart/form-data"]
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append((params["SESSIONID"]!.data(using: String.Encoding.utf8)!),
                                         withName: "SESSIONID")
                multipartFormData.append((params["mobileCode"]!.data(using: String.Encoding.utf8)!),
                                         withName: "mobileCode")
                multipartFormData.append((params["semeiography"]!.data(using: String.Encoding.utf8)!),
                                         withName: "semeiography")
                multipartFormData.append((params["title"]!.data(using: String.Encoding.utf8)!),
                                         withName: "title")
                multipartFormData.append((params["content"]!.data(using: String.Encoding.utf8)!),
                                         withName: "content")
                multipartFormData.append((params["day"]!.data(using: String.Encoding.utf8)!),
                                         withName: "day")
                multipartFormData.append((params["diaryId"]!.data(using: String.Encoding.utf8)!),
                                         withName: "diaryId")
                multipartFormData.append((params["swelling"]!.data(using: String.Encoding.utf8)!),
                                         withName: "swelling")
                multipartFormData.append((params["pain"]!.data(using: String.Encoding.utf8)!),
                                         withName: "pain")
                multipartFormData.append((params["scar"]!.data(using: String.Encoding.utf8)!),
                                         withName: "scar")
                multipartFormData.append((params["isIce"]!.data(using: String.Encoding.utf8)!),
                                         withName: "isIce")
                multipartFormData.append((params["ids"]!.data(using: String.Encoding.utf8)!),
                                         withName: "ids")
                for i in 0 ..< data.count {
                    multipartFormData.append(UIImagePNGRepresentation(data[i])!, withName: "img", fileName: "iOS_\(name[i]).png", mimeType: "image/png")
                }
        },
            to: urlString,
            headers: headers,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        if let value = response.result.value as? [String: AnyObject]{
                            success(value)
                            let json = JSON(value)
                            delog(json)
                        }
                    }
                case .failure(let encodingError):
                    delog(encodingError)
                    failture(encodingError)
                }
        }
        )
    }
    
    func rePushNoteUpLoadImageRequest(urlString : String,
                                      params:[String:String],
                                      data: [UIImage],
                                      name: [String],
                                      success : @escaping (_ response : [String : AnyObject])->(),
                                      failture : @escaping (_ error : Error)->()){
        
        let headers = ["content-type":"multipart/form-data"]
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                
                multipartFormData.append((params["SESSIONID"]!.data(using: String.Encoding.utf8)!),
                                         withName: "SESSIONID")
                multipartFormData.append((params["mobileCode"]!.data(using: String.Encoding.utf8)!),
                                         withName: "mobileCode")
                multipartFormData.append((params["content"]!.data(using: String.Encoding.utf8)!),
                                         withName: "content")
                multipartFormData.append((params["id"]!.data(using: String.Encoding.utf8)!),
                                         withName: "id")
                for i in 0 ..< data.count {
                    multipartFormData.append(UIImagePNGRepresentation(data[i])!, withName: "img", fileName: "iOS_\(name[i]).png", mimeType: "image/png")
                }
        },
            to: urlString,
            headers: headers,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        if let value = response.result.value as? [String: AnyObject]{
                            success(value)
                            let json = JSON(value)
                            delog(json)
                        }
                    }
                case .failure(let encodingError):
                    delog(encodingError)
                    failture(encodingError)
                }
        }
        )
    }
    
    func reBuildHeadUpLoadImageRequest(urlString : String,
                                      params:[String:String],
                                      data: [UIImage],
                                      name: [String],
                                      success : @escaping (_ response : [String : AnyObject])->(),
                                      failture : @escaping (_ error : Error)->()){
        
        let headers = ["content-type":"multipart/form-data"]
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                
                multipartFormData.append((params["SESSIONID"]!.data(using: String.Encoding.utf8)!),
                                         withName: "SESSIONID")
                multipartFormData.append((params["mobileCode"]!.data(using: String.Encoding.utf8)!),
                                         withName: "mobileCode")
                multipartFormData.append((params["nickName"]!.data(using: String.Encoding.utf8)!),
                                         withName: "nickName")
                multipartFormData.append((params["gender"]!.data(using: String.Encoding.utf8)!),
                                         withName: "gender")
                multipartFormData.append((params["birthday"]!.data(using: String.Encoding.utf8)!),
                                         withName: "birthday")
                multipartFormData.append((params["area"]!.data(using: String.Encoding.utf8)!),
                                         withName: "area")
                multipartFormData.append((params["ids"]!.data(using: String.Encoding.utf8)!),
                                         withName: "ids")
                for i in 0 ..< data.count {
                    multipartFormData.append(UIImagePNGRepresentation(data[i])!, withName: "img", fileName: "head\(name[i]).png", mimeType: "image/png")
                }
        },
            to: urlString,
            headers: headers,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        if let value = response.result.value as? [String: AnyObject]{
                            success(value)
                            let json = JSON(value)
                            delog(json)
                        }
                    }
                case .failure(let encodingError):
                    delog(encodingError)
                    failture(encodingError)
                }
        }
        )
    }
    
    //退货上传图片
    func reReturnGoodsUpLoadImageRequest(urlString : String,
                                         params:[String:String],
                                         data: [UIImage],
                                         name: [String],
                                         success : @escaping (_ response : [String : AnyObject])->(),
                                         failture : @escaping (_ error : Error)->()){
        
        let headers = ["content-type":"multipart/form-data"]
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                
                multipartFormData.append((params["SESSIONID"]!.data(using: String.Encoding.utf8)!),
                                         withName: "SESSIONID")
                multipartFormData.append((params["mobileCode"]!.data(using: String.Encoding.utf8)!),
                                         withName: "mobileCode")
                multipartFormData.append((params["id"]!.data(using: String.Encoding.utf8)!),
                                         withName: "id")
                multipartFormData.append((params["applyReason"]!.data(using: String.Encoding.utf8)!),
                                         withName: "applyReason")
                multipartFormData.append((params["phone"]!.data(using: String.Encoding.utf8)!),
                                         withName: "phone")
                for i in 0 ..< data.count {
                    var random = String()
                    for _ in 0...4 {
                        random += "\(arc4random() % 100)"
                    }
                    multipartFormData.append(UIImagePNGRepresentation(data[i])!, withName: "image", fileName: "\(name[i])_\(random)", mimeType: "image/png")
                }
        },
            to: urlString,
            headers: headers,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        if let value = response.result.value as? [String: AnyObject]{
                            success(value)
                            let json = JSON(value)
                            delog(json)
                        }
                    }
                case .failure(let encodingError):
                    delog(encodingError)
                    failture(encodingError)
                }
        }
        )
    }
}
