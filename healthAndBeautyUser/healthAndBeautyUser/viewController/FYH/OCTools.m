//
//  OCTools.m
//  healthAndBeautyUser
//
//  Created by RongXing on 2017/12/11.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

#import "OCTools.h"

@implementation OCTools

+(NSURL *)getEfficientAddress:(NSString *)string{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)string,
                                                              (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                              NULL,
                                                              kCFStringEncodingUTF8));
    return [NSURL URLWithString:encodedString];
}

@end
