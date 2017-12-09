//
//  UIButton+WXButton_Title_Image.h
//  zmCarDriver
//
//  Created by 吴玄 on 2017/2/18.
//  Copyright © 2017年 iOSMonkey. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MKButtonEdgeInsetsStyle) {
    MKButtonEdgeInsetsStyleTop, // image在上，label在下
    MKButtonEdgeInsetsStyleLeft, // image在左，label在右
    MKButtonEdgeInsetsStyleBottom, // image在下，label在上
    MKButtonEdgeInsetsStyleRight // image在右，label在左
};

@interface UIButton (Title_Image)

- (void)layoutButtonWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyle)style
                            imageTitleSpace:(CGFloat)space;
    
@end
