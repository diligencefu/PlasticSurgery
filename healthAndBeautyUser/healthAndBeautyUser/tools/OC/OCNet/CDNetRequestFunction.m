//
//  CDNetRequestFunction.m
//  chongdejiazhengDEMO
//
//  Created by 吴玄 on 16/8/22.
//  Copyright © 2016年 iOSMonkey. All rights reserved.
//

#import "CDNetRequestFunction.h"
#import "AFNetworking.h"

@implementation CDNetRequestFunction

+ (instancetype)shareCDNetRequestFunction {
    
    static CDNetRequestFunction *netWorking = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        netWorking = [[CDNetRequestFunction alloc]init];
    });
    return netWorking;
}

+ (void)requestWithUrl:(NSString *)urlStr
                andStr:(NSString *)str
              andBlock:(void (^)(id responseObject))sucess
              andFaild:(void (^)(NSError * error))faild {
    
    // 检测网络连接状态
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
     {
          if (status>0) {    //网络正常
              AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
              manager.responseSerializer = [AFHTTPResponseSerializer serializer];
              manager.requestSerializer.timeoutInterval = 30000;
              
              [manager GET:urlStr parameters:str progress:^(NSProgress * _Nonnull downloadProgress) {
                  
              } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                  if (![responseObject isKindOfClass:[NSError class]]) {
                      sucess(responseObject);
                  }
              } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  faild(error);
              }];
          }else {
              UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示："
                                                                  message:@"当前没有网络，请连接网络后重试"
                                                                 delegate:self
                                                        cancelButtonTitle:@"确定"
                                                        otherButtonTitles:nil,
                                        nil];
              [alertView show];
          }
     }];
}

+ (void)requestPOSTWithUrl:(NSString *)urlStr
                    andDic:(NSDictionary *)dic
                  andBlock:(void (^)(id responseObject))sucess
                  andFaild:(void (^)(NSError *error))faild {
    
    // 检测网络连接状态
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
     {
         if (status>0) {    //网络正常
             AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
             manager.responseSerializer = [AFHTTPResponseSerializer serializer];
             manager.requestSerializer.timeoutInterval = 30000;
             
             [manager POST:urlStr parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
                 
             } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                 if (![responseObject isKindOfClass:[NSError class]]) {
                     sucess(responseObject);
                 }
             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 sucess(error);
             }];
         }else {
             UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示："
                                                                 message:@"当前没有网络，请连接网络后重试"
                                                                delegate:self
                                                       cancelButtonTitle:@"确定"
                                                       otherButtonTitles:nil,
                                       nil];
             [alertView show];
         }
     }];

}

//file 图片
//fileKey 图片名字
+ (void)post:(NSString *)url
  parameters:(id)param
   imageFile:(NSArray *)file
     fileKay:(NSArray *)fileKey
     success:(void (^)(id responseObject))success
      failed:(void (^)(NSError *error))failed {
    
    // 检测网络连接状态
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
     {
         if (status>0) {    //网络正常
             AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
             manager.responseSerializer = [AFHTTPResponseSerializer serializer];
             manager.requestSerializer.timeoutInterval = 30000;
             
             [manager POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                 for (int i = 0; i < file.count; i++) {
                     NSDate *dateNow = [NSDate date];
                     NSString *timeSp = [NSString stringWithFormat:@"%ld_%d",(long)[dateNow timeIntervalSince1970],arc4random()];
                     NSData *imageData = UIImageJPEGRepresentation(file[i],0.4);
                     [formData appendPartWithFileData:imageData name:fileKey[i] fileName:[NSString stringWithFormat:@"%@.jpeg",timeSp] mimeType:@"image/jpeg"];
                 }
             } progress:^(NSProgress * _Nonnull uploadProgress) {
                 
             } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                 if (![responseObject isKindOfClass:[NSError class]]) {
                     success(responseObject);
                 }
             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 failed(error);
             }];
         }else {
             UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示："
                                                                 message:@"当前没有网络，请连接网络后重试"
                                                                delegate:self
                                                       cancelButtonTitle:@"确定"
                                                       otherButtonTitles:nil,
                                       nil];
             [alertView show];
         }
     }];
}

@end
