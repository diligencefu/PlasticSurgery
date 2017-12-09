//
//  UIImageView+GetVideoFistPic.h
//  healthAndBeautyUser
//
//  Created by 丿番茄 on 2017/11/24.
//  Copyright © 2017年 RXSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (GetVideoFistPic)

- (UIImage *)firstFrameWithVideoURL:(NSURL *)url img:(UIImageView *)image;

@end
