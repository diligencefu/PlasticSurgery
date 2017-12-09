//
//  UIButton+LSSmsVerification.h
//  短信验证码
//
//  Created by yepiaoyang on 16/6/30.
//  Copyright © 2016年 yepiaoyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (LSSmsVerification)

/**
 *  获取短信验证码倒计时
 *
 *  @param duration 倒计时时间
 */
- (void)startTimeWithDuration:(NSInteger)duration;

@end
