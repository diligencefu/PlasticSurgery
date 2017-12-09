//
//  MD5.m
//  stateGridIMDemo
//
//  Created by helloworld on 2017/9/13.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

#import "MD5.h"
//#import "GTMBase64.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

#import <CommonCrypto/CommonCryptor.h>

#define gkey @"dianlixitong@withtestone"
#define gIv @"01234567"

@implementation MD5

//+ (NSString *) md5:(NSString *)input {
//
//    const char *cStr = [input UTF8String];
//
//    unsigned char digest[CC_MD5_DIGEST_LENGTH];
//
//    CC_MD5( cStr, strlen(cStr), digest );
//
//    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
//
//    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
//
//        [output appendFormat:@"%02x", digest[i]];
//
//    return  output;
//}
//
//// 加密方法
//+ (NSString*)encrypt:(NSString*)plainText {
//    NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
//    size_t plainTextBufferSize = [data length];
//    const void *vplainText = (const void *)[data bytes];
//    CCCryptorStatus ccStatus;
//    uint8_t *bufferPtr = NULL;
//    size_t bufferPtrSize = 0;
//    size_t movedBytes = 0;
//    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
//    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
//    memset((void *)bufferPtr, 0x0, bufferPtrSize);
//    const void *vkey = (const void *) [gkey UTF8String];
//    const void *vinitVec = (const void *) [gIv UTF8String];
//    ccStatus = CCCrypt(kCCEncrypt, kCCAlgorithm3DES, kCCOptionPKCS7Padding, vkey, kCCKeySize3DES, vinitVec, vplainText, plainTextBufferSize, (void *)bufferPtr, bufferPtrSize, &movedBytes);
//    NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr
//                                    length:(NSUInteger)movedBytes];
//    NSString *result = [GTMBase64 stringByEncodingData:myData];
//    return result;
//}
//// 解密方法
//+ (NSString*)decrypt:(NSString*)encryptText {
//    NSData *encryptData = [GTMBase64 decodeData:[encryptText dataUsingEncoding:NSUTF8StringEncoding]];
//    size_t plainTextBufferSize = [encryptData length];
//    const void *vplainText = [encryptData bytes];
//    CCCryptorStatus ccStatus;
//    uint8_t *bufferPtr = NULL;
//    size_t bufferPtrSize = 0;
//    size_t movedBytes = 0;
//    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
//    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
//    memset((void *)bufferPtr, 0x0, bufferPtrSize);
//    const void *vkey = (const void *) [gkey UTF8String];
//    const void *vinitVec = (const void *) [gIv UTF8String];
//    ccStatus = CCCrypt(kCCDecrypt, kCCAlgorithm3DES, kCCOptionPKCS7Padding, vkey, kCCKeySize3DES, vinitVec, vplainText, plainTextBufferSize, (void *)bufferPtr, bufferPtrSize, &movedBytes);
//    NSString *result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes] encoding:NSUTF8StringEncoding];
//    return result;
//}

/** * 手机号码格式验证 */
+ (BOOL)isTelphoneNumber:(NSString *)telNum{
    
    telNum = [telNum stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([telNum length] != 11){
        return NO;
    }
    /** * 规则 -- 更新日期 2017-03-30 *
     手机号码: 13[0-9], 14[5,7,9], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[0, 1, 6, 7, 8], 18[0-9] *
     移动号段: 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188 *
     联通号段: 130,131,132,145,155,156,170,171,175,176,185,186 * 
     电信号段: 133,149,153,170,173,177,180,181,189 * * 
     [数据卡]: 14号段以前为上网卡专属号段，如中国联通的是145，中国移动的是147,中国电信的是149等等。 * 
     [虚拟运营商]: 170[1700/1701/1702(电信)、1703/1705/1706(移动)、1704/1707/1708/1709(联通)]、171（联通） * 
     [卫星通信]: 1349 */
    /** *中国移动：China Mobile * 134,135,136,137,138,139,147(数据卡),150,151,152,157,158,159,170[5],178,182,183,184,187,188 */
    NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(17[8])|(18[2-4,7-8]))\\d{8}|(170[5])\\d{7}$";
    /** * 中国联通：China Unicom * 130,131,132,145(数据卡),155,156,170[4,7-9],171,175,176,185,186 */
    NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(17[156])|(18[5,6]))\\d{8}|(170[4,7-9])\\d{7}$";
    /** * 中国电信：China Telecom * 133,149(数据卡),153,170[0-2],173,177,180,181,189 */
    NSString *CT_NUM = @"^((133)|(149)|(153)|(17[3,7])|(18[0,1,9]))\\d{8}|(170[0-2])\\d{7}$";
    NSPredicate *pred_CM = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CM_NUM];
    NSPredicate *pred_CU = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CU_NUM];
    NSPredicate *pred_CT = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CT_NUM];
    BOOL isMatch_CM = [pred_CM evaluateWithObject:telNum];
    BOOL isMatch_CU = [pred_CU evaluateWithObject:telNum];
    BOOL isMatch_CT = [pred_CT evaluateWithObject:telNum];
    if (isMatch_CM || isMatch_CT || isMatch_CU) {
        return YES;
    }
    return NO;
}

@end
