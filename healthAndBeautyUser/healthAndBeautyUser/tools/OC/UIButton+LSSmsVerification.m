//
//  UIButton+LSSmsVerification.m
//  短信验证码
//
//  Created by yepiaoyang on 16/6/30.
//  Copyright © 2016年 yepiaoyang. All rights reserved.
//

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define TEXT28 WIDTH/750*28

#import "UIButton+LSSmsVerification.h"
#import "UIButton+LSSmsVerification.h"

@implementation UIButton (LSSmsVerification)

/**
 *  获取短信验证码倒计时
 *
 *  @param duration 倒计时时间
 */

- (void)startTimeWithDuration:(NSInteger)duration
{
    __block NSInteger timeout = duration;
    
    NSString *originalTitle = [self titleForState:UIControlStateNormal];
    UIColor *originalTitleColor = [self titleColorForState:UIControlStateNormal];
    UIFont *originalFont = self.titleLabel.font;
    UIColor *backColor = [self backgroundColor];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer_t = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer_t,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(timer_t, ^{
        if(timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(timer_t);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮为最初的状态
                [self setTitle:originalTitle forState:UIControlStateNormal];
                [self setTitleColor:originalTitleColor forState:UIControlStateNormal];
                self.titleLabel.font = originalFont;
                self.userInteractionEnabled = YES;
                [self setBackgroundColor:backColor];
                
            });
        }else{
            NSInteger seconds = timeout % duration;
            if(seconds == 0){
                seconds = duration;
            }
            NSString *strTime = [NSString stringWithFormat:@"%.2ld", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{//根据自己需求设置倒计时显示
                [self setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:UIControlStateNormal];
                [self setTitleColor: [UIColor lightGrayColor] forState:UIControlStateNormal];
                self.titleLabel.font = [UIFont systemFontOfSize:TEXT28];
                //self.titleLabel.adjustsFontSizeToFitWidth = YES;//字体自适应大小
                [self setBackgroundColor:[UIColor whiteColor]];
                self.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(timer_t);
}

@end
