//
//  UIViewController+AHook.m
//  Hook
//
//  Created by muyu on 2018/9/26.
//  Copyright © 2018年 muyu. All rights reserved.
//

#import "UIViewController+AHook.h"
#import <objc/runtime.h>

@implementation UIViewController (AHook)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL originalSelector = @selector(viewDidAppear:);
        SEL swizzledSelector = @selector(AViewDidAppear:);
        [self p_swizzlingInClass:[self class] originalSelector:originalSelector swizzledSelector:swizzledSelector];
        
        SEL originalSelector2 = @selector(viewDidDisappear:);
        SEL swizzledSelector2 = @selector(AViewDidDisapper:);
        [self p_swizzlingInClass:[self class] originalSelector:originalSelector2 swizzledSelector:swizzledSelector2];
    });
}

- (void)AViewDidAppear:(BOOL)animated
{
    NSLog(@"AViewDidAppear");
    
    [self AViewDidAppear:animated];
}

- (void)AViewDidDisapper:(BOOL)animated
{
    NSLog(@"AViewDidDisapper");
    
    [self AViewDidDisapper:animated];
}

#pragma mark - private method

+ (void)p_swizzlingInClass:(Class)cls originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector
{
    Class class = cls;
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
