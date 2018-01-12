//
//  LuckView.m
//  QSyihz
//
//  Created by apple on 16/4/25.
//  Copyright © 2016年 yihuazhuan. All rights reserved.
//

#import "LuckView.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"
#import "UIView+Extension.h"
#import "FYHLuckyModel.h"

#define setRGBColor(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

@interface LuckView () {
    NSTimer *imageTimer;
    NSTimer *startTimer;
    
    int currentTime;
    int stopTime;
    int result;
}

@property (strong , nonatomic) UIImageView *iv;
@property (assign, nonatomic) BOOL isImage;
@property (strong, nonatomic) NSMutableArray * btnArray;
@property (strong, nonatomic) UIButton * startBtn;
@property (assign, nonatomic) CGFloat time;


@end

@implementation LuckView

- (NSMutableArray *)btnArray {
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        currentTime = 0;
        self.isImage = YES;
        self.time = 0.07;
        stopTime = 63 + self.stopCount;
        self.iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        self.iv.image = [UIImage imageNamed:@"cjbj01"];
        [self addSubview:self.iv];
        
       imageTimer = [NSTimer scheduledTimerWithTimeInterval:.5 target:self selector:@selector(updataImage:) userInfo:nil repeats:YES];
    }
    return self;
}


- (void)updataImage:(NSTimer *)timer {
    self.isImage = !self.isImage;
    if (self.isImage == YES) {
        self.iv.image = [UIImage imageNamed:@"cjbj02"];
    } else {
        self.iv.image = [UIImage imageNamed:@"cjbj01"];
    }
}

- (void)setStopCount:(int)stopCount {
    _stopCount = stopCount;
    stopTime = 63 + _stopCount;
}


- (void)setImageArray:(NSMutableArray *)imageArray {
    _imageArray = imageArray;
    [self.btnArray removeAllObjects];
    
    for (UIView *view in self.iv.subviews) {
        [view removeFromSuperview];
    }
    
    CGFloat yj = 15;
    CGFloat j = 20;
    CGFloat upj = 5;
    CGFloat imageW = 10;
    CGFloat btnw = (self.width - imageW * 2 - j * 2 - upj * 2)/3;
    
    for (int i = 0; i < imageArray.count + 1; i++) {
        
        UIButton *btn = [[UIButton alloc] init];
        btn.x = j + upj * (i % 3) + (i % 3) * btnw + imageW;
        btn.y = yj + upj * (i / 3) + (i / 3) * btnw + imageW;
        btn.width = btnw;
        btn.height = btnw;
        btn.backgroundColor = [UIColor clearColor];
        btn.layer.cornerRadius = 5;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.iv.userInteractionEnabled = YES;
        [self.iv addSubview:btn];
        
        if (i == 4) {
            btn.layer.cornerRadius = 14;
            [btn setImage:[UIImage imageNamed:@"draw_btn_perssed"] forState:UIControlStateNormal];
            btn.tag = 10;
            self.startBtn = btn;
            continue;
        }
        
        btn.tag = i > 4? i -1: i;
        btn.layer.borderWidth = 5;
        btn.layer.borderColor = [UIColor clearColor].CGColor;
//        [btn sd_setImageWithURL:[_imageArray objectAtIndex:i > 4? i -1: i] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"cjbj02"]];
        
        if (i != 4) {
            
            FYHLuckyModel *model = [FYHLuckyModel new];
            if (i<4) {
                model = imageArray[i];
            }else{
                model = imageArray[i-1];
            }

            UIView *theView = [[UIView alloc] initWithFrame:btn.bounds];
            theView.backgroundColor = [UIColor whiteColor];
            theView.tag = 10086;
            theView.alpha = .1;
            [btn addSubview:theView];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, btn.height-20, btn.width, 20)];
            label.text = model.goodName;
            label.textColor = setRGBColor(249, 249, 249);
            label.font = [UIFont systemFontOfSize:14];
            label.textAlignment = NSTextAlignmentCenter;
            [btn addSubview:label];
            [btn setTitle:model.goodName forState:UIControlStateNormal];
            [btn sd_setImageWithURL:[NSURL URLWithString:model.goodImage] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"cjbj02"]];
        }else{
            [btn setImage:[UIImage imageNamed:@"cjbj02"] forState:UIControlStateNormal];
        }
        btn.clipsToBounds = YES;
//
        btn.imageEdgeInsets = UIEdgeInsetsMake(10, 15, 20, 15);
        
        btn.backgroundColor = setRGBColor(arc4random() % 255, arc4random() % 255, arc4random() % 255);
        
//        btn.titleEdgeInsets = UIEdgeInsetsMake(30, 30, -10, 10);
        [self.btnArray addObject:btn];
    }
    [self tradePlacesWithBtn1:self.btnArray[3] btn2:self.btnArray[4]];
    [self tradePlacesWithBtn1:self.btnArray[4] btn2:self.btnArray[7]];
    [self tradePlacesWithBtn1:self.btnArray[5] btn2:self.btnArray[6]];
}

- (void)btnClick:(UIButton *)btn {
    if (btn.tag == 10) {
        self.beginLuck(btn);
    } else {
//        self.luckBtn(btn);
//        if ([self.delegate respondsToSelector:@selector(luckSelectBtn:)]) {
//            [self.delegate luckSelectBtn:btn];
//        }
    }
}

- (void)startDrawLotteryRaffle{
    
    currentTime = result;
    self.time = 0.1;
    stopTime = 63 + self.stopCount % 8;
    [self.startBtn setEnabled:NO];
    [self.startBtn setImage:[UIImage imageNamed:@"draw_btn_default"] forState:UIControlStateNormal];
    
    startTimer = [NSTimer scheduledTimerWithTimeInterval:self.time target:self selector:@selector(start:) userInfo:nil repeats:YES];
}

- (void)start:(NSTimer *)timer {
    UIButton *oldBtn = [self.btnArray objectAtIndex:currentTime % self.btnArray.count];
    oldBtn.layer.borderColor = [UIColor clearColor].CGColor;
    UIView *view = [oldBtn viewWithTag:10086];
    view.alpha = .1;
    
    currentTime++;
    UIButton *btn = [self.btnArray objectAtIndex:currentTime % self.btnArray.count];
    btn.layer.borderColor = [UIColor orangeColor].CGColor;
    UIView *view1 = [btn viewWithTag:10086];
    view1.alpha = .25;
    
    if (currentTime > stopTime) {
        [timer invalidate];
        [self.startBtn setEnabled:YES];
        [self.startBtn setImage:[UIImage imageNamed:@"draw_btn_perssed"] forState:UIControlStateNormal];
        result = currentTime % self.btnArray.count;
        
        [self stopWithCount:result];
        if (self.luckResultBlock != nil) {
            self.luckResultBlock(result);
        }
        return;
    }
   
    if (currentTime > stopTime - 10) {
        self.time += 0.07;
        [timer invalidate];
        startTimer = [NSTimer scheduledTimerWithTimeInterval:self.time target:self selector:@selector(start:) userInfo:nil repeats:YES];
    }
}


- (void)stopWithCount:(NSInteger)count {
    if ([self.delegate respondsToSelector:@selector(luckViewDidStopWithArrayCount:)]) {
        [self.delegate luckViewDidStopWithArrayCount:count];
    }
}


- (void)tradePlacesWithBtn1:(UIButton *)firstBtn btn2:(UIButton *)secondBtn {
    CGRect frame = firstBtn.frame;
    firstBtn.frame = secondBtn.frame;
    secondBtn.frame = frame;
}

- (void)dealloc {
    [imageTimer invalidate];
    [startTimer invalidate];
}


- (void)getLuckResult:(luckBlock)luckResult {
    self.luckResultBlock = luckResult;
}

- (void)getLuckBtnSelect:(luckBtnBlock)btnBlock {
    self.luckBtn = btnBlock;
}

@end
