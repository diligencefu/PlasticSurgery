//
//  HBAlertPasswordView.m
//  TestPassward
//
//  Created by JING XU on 17/5/21.
//  Copyright © 2017年 HB. All rights reserved.
//

#import "HBAlertPasswordView.h"

@interface HBAlertPasswordView ()
<UITextFieldDelegate>

/** 密码的TextField */
@property (nonatomic, strong) UITextField *passwordTextField;
/** 黑点的个数 */
@property (nonatomic, strong) NSMutableArray *pointArr;
/** 输入安全密码的背景View */
@property (nonatomic, strong) UIView *BGView;


@end

// 密码点的大小
#define kPointSize CGSizeMake(10, 10)
// 密码个数
#define kPasswordCount 6
// 每一个密码框的高度
#define kBorderHeight 45
// 按钮的高度
#define kButtonHeight 49
// 宏定义屏幕的宽和高
#define HB_ScreenW [UIScreen mainScreen].bounds.size.width
#define HB_ScreenH [UIScreen mainScreen].bounds.size.height

//设置RGBA颜色
#define kSetRGBAColor(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@implementation HBAlertPasswordView


#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        // 背景颜色
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        
        // 输入安全密码的背景View
        UIView *BGView = [[UIView alloc] initWithFrame:CGRectMake((HB_ScreenW - 290) / 2, 0, 290, 200)];
        BGView.backgroundColor = [UIColor whiteColor];
        BGView.layer.cornerRadius = 10;
        BGView.layer.masksToBounds = YES;
        [self addSubview:BGView];
        self.BGView = BGView;
        BGView.center = self.center;
        
        CGFloat BGViewW = BGView.frame.size.width;
        CGFloat BGViewH = BGView.frame.size.height;
        // 请输入安全密码的Label
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, BGViewW, 50)];
//        _titleLabel.text = @"请输入安全密码";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [BGView addSubview:_titleLabel];
        
        // 横线
        UIView *topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleLabel.frame), BGViewW, 1)];
        topLineView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
        [BGView addSubview:topLineView];
        
        UIView *downLineView = [[UIView alloc] initWithFrame:CGRectMake(0, BGViewH - kButtonHeight - 1, BGViewW, 1)];
        downLineView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
        [BGView addSubview:downLineView];
        
        // 取消按钮
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton.frame = CGRectMake(0, BGViewH - kButtonHeight, BGViewW / 2, kButtonHeight);
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[[UIColor blueColor] colorWithAlphaComponent:0.5] forState:UIControlStateNormal];
        cancelButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [cancelButton addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [BGView addSubview:cancelButton];
        
        // 确定按钮
        UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        sureButton.frame = CGRectMake(CGRectGetMaxX(cancelButton.frame), BGViewH - kButtonHeight, BGViewW / 2, kButtonHeight);
        [sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [sureButton setTitleColor:[[UIColor redColor] colorWithAlphaComponent:0.5] forState:UIControlStateNormal];
        sureButton.titleLabel.font = [UIFont systemFontOfSize:19];
        [sureButton addTarget:self action:@selector(sureButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [BGView addSubview:sureButton];
        
        UIView *lineHView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(cancelButton.frame), BGViewH - kButtonHeight + 10, 1, 30)];
        lineHView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2];
        [BGView addSubview:lineHView];
        
//        _balance = [[UILabel alloc] initWithFrame:CGRectMake(0, (BGViewH - CGRectGetMaxY(topLineView.frame) - kButtonHeight - kBorderHeight) / 2+35, BGViewW, 30)];
//        //        _titleLabel.text = @"请输入安全密码";
//        _balance.textColor = kSetRGBAColor(117, 117, 117, 1);
//        _balance.textAlignment = NSTextAlignmentCenter;
//        [BGView addSubview:_balance];

        // 密码框
        CGFloat passwordTextFieldY = (BGViewH - CGRectGetMaxY(topLineView.frame) - kButtonHeight - kBorderHeight) / 2;
        UITextField *passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake((BGViewW - kPasswordCount * kBorderHeight) / 2, passwordTextFieldY + CGRectGetMaxY(topLineView.frame), kPasswordCount * kBorderHeight, kBorderHeight)];
        passwordTextField.backgroundColor = [UIColor whiteColor];
        // 输入的文字颜色为白色
        passwordTextField.textColor = [UIColor whiteColor];
        // 输入框光标的颜色为白色
        passwordTextField.tintColor = [UIColor whiteColor];
        passwordTextField.delegate = self;
        passwordTextField.keyboardType = UIKeyboardTypeNumberPad;
        passwordTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        passwordTextField.layer.borderWidth = 1;
        [passwordTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [BGView addSubview:passwordTextField];
        // 页面出现时弹出键盘
        [passwordTextField becomeFirstResponder];
        self.passwordTextField = passwordTextField;
        
        // 生产分割线
        for (NSInteger i = 0; i < kPasswordCount - 1; i++) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(passwordTextField.frame) + (i + 1) * kBorderHeight, CGRectGetMinY(passwordTextField.frame), 1, kBorderHeight)];
            lineView.backgroundColor = [UIColor lightGrayColor];
            [BGView addSubview:lineView];
        }
        
        self.pointArr = [NSMutableArray array];
        
        // 生成中间的点
        for (NSInteger i = 0; i < kPasswordCount; i++) {
            UIView *pointView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(passwordTextField.frame) + (kBorderHeight - kPointSize.width) / 2 + i * kBorderHeight, CGRectGetMinY(passwordTextField.frame) + (kBorderHeight - kPointSize.height) / 2, kPointSize.width, kPointSize.height)];
            pointView.backgroundColor = [UIColor blackColor];
            pointView.layer.cornerRadius = kPointSize.width / 2;
            pointView.layer.masksToBounds = YES;
            // 先隐藏
            pointView.hidden = YES;
            [BGView addSubview:pointView];
            // 把创建的黑点加入到数组中
            [self.pointArr addObject:pointView];
        }
        
        // 监听键盘的高度
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

#pragma mark - <UITextFieldDelegate>
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    NSLog(@"变化%@", string);
    if ([string isEqualToString:@"\n"]) {
        // 按回车关闭键盘
        [textField resignFirstResponder];
        return NO;
    } else if (string.length == 0) {
        // 判断是不是删除键
        return YES;
    } else if (textField.text.length >= kPasswordCount) {
        // 输入的字符个数大于6
//        NSLog(@"输入的字符个数大于6,忽略输入");
        return NO;
    } else {
        return YES;
    }
}


/**
 清除密码
 */
- (void)clearUpPassword {
    
    self.passwordTextField.text = @"";
    [self textFieldDidChange:self.passwordTextField];
}

/**
 重置显示的点
 */
- (void)textFieldDidChange:(UITextField *)textField {
//    NSLog(@"%@", textField.text);
    for (UIView *pointView in self.pointArr) {
        pointView.hidden = YES;
    }
    for (NSInteger i = 0; i < textField.text.length; i++) {
        ((UIView *)[self.pointArr objectAtIndex:i]).hidden = NO;
    }
    if (textField.text.length == kPasswordCount) {
        NSLog(@"输入完毕,密码为%@", textField.text);
    }
}

#pragma mark - 
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    [self endEditing:YES];
}

#pragma mark - 按钮的执行方法
// 取消按钮
- (void)cancelButtonAction {
    
    [self removeFromSuperview];
}

// 确定按钮
- (void)sureButtonAction {
    
    if (self.passwordTextField.text.length == 6) {
        if ([self.delegate respondsToSelector:@selector(sureActionWithAlertPasswordView:password:)]) {
            [self.delegate sureActionWithAlertPasswordView:self password:self.passwordTextField.text];
        }
    }else{
        NSLog(@"请检查密码长度");
        return;
    }
}

#pragma mark - 键盘的出现和收回的监听方法
- (void)keyboardWillShow:(NSNotification *)aNotification {
    // 获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGFloat keyboardHeight = keyboardRect.size.height;
    self.BGView.frame = CGRectMake(self.BGView.frame.origin.x, HB_ScreenH - keyboardHeight - self.BGView.frame.size.height - 30, self.BGView.frame.size.width, self.BGView.frame.size.height);
}

- (void)keyboardWillHide:(NSNotification *)aNotification {
    self.BGView.center = CGPointMake(self.BGView.center.x, self.center.y);
}

@end
