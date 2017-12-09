//
//  MD5.h
//  stateGridIMDemo
//
//  Created by helloworld on 2017/9/13.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MD5 : NSObject

//+ (NSString *)md5:(NSString *)input;
//
////DES解密
//// 加密方法
//+ (NSString*)encrypt:(NSString*)plainText;
//// 解密方法
//+ (NSString*)decrypt:(NSString*)encryptText;

//判断密码什么的就写这里了
+ (BOOL)isTelphoneNumber:(NSString *)telNum;

@end
