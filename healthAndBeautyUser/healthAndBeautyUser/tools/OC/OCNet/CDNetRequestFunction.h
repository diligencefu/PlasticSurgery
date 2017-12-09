//
//  CDNetRequestFunction.h
//  chongdejiazhengDEMO
//
//  Created by 吴玄 on 16/8/22.
//  Copyright © 2016年 iOSMonkey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDNetRequestFunction : NSObject

+ (instancetype)shareCDNetRequestFunction;

+ (void)requestWithUrl:(NSString *)urlStr andStr:(NSString *)str andBlock:(void (^)(id responseObject))sucess andFaild:(void (^)(NSError * error))faild;

+ (void)requestPOSTWithUrl:(NSString *)urlStr andDic:(NSDictionary *)dic andBlock:(void (^)(id responseObject))sucess andFaild:(void (^)(NSError *error))faild;
 
+ (void)post:(NSString *)url parameters:(id)param imageFile:(NSArray *)file fileKay:(NSArray *)fileKey success:(void (^)(id responseObject))success failed:(void (^)(NSError *error))failed;

@end
