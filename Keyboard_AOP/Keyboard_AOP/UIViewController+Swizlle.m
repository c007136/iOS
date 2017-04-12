//
//  UIViewController+Swizlle.m
//  Keyboard_AOP
//
//  Created by muyu on 16/7/5.
//  Copyright © 2016年 muyu. All rights reserved.
//

#import "UIViewController+Swizlle.h"
#import "NSObject+RNSwizzle.h"

#import "AViewController.h"
#import "BViewController.h"

@implementation UIViewController (Swizlle)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UIViewController swizzleSelector:@selector(viewWillAppear:) withSelector:@selector(zx_viewWillAppear:)];
        [UIViewController swizzleSelector:@selector(viewWillDisappear:) withSelector:@selector(zx_viewWillDisappear:)];
    });
}

- (void)zx_viewWillAppear:(BOOL)animated
{
    [self zx_viewWillAppear:animated];
    
    if (![self zx_needToPerform]) {
        return;
    }
    
    NSLog(@"%@ will appear", NSStringFromClass([self class]));
    
    // 监听键盘事件
}

- (void)zx_viewWillDisappear:(BOOL)animated
{
    [self zx_viewWillDisappear:animated];
    
    if (![self zx_needToPerform]) {
        return;
    }
    
    NSLog(@"%@ will disappear", NSStringFromClass([self class]));
    
    // 取消监听键盘事件
}

- (void)keyboardWillShow:(NSNotification *)notification
{
}

-(void)keyboardWillHide:(NSNotification *)notification
{
}

// 过滤函数
- (BOOL)zx_needToPerform
{
    if ([self isKindOfClass:[AViewController class]]
        || [self isKindOfClass:[BViewController class]])
    {
        return YES;
    }
    
    return NO;
}

@end
