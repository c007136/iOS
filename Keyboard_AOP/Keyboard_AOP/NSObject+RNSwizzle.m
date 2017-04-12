//
//  NSObject+RNSwizzle.m
//  MethodSwizzling
//
//  Created by muyu on 16/7/5.
//  Copyright © 2016年 muyu. All rights reserved.
//
//  http://tech.glowing.com/cn/method-swizzling-aop/

#import "NSObject+RNSwizzle.h"
#import <objc/runtime.h>

@implementation NSObject (RNSwizzle)

+ (void)swizzleSelector:(SEL)origSelector withSelector:(SEL)newSelector
{
    Class class = [self class];
    Method origMethod = class_getInstanceMethod(class, origSelector);
    Method newMethod = class_getInstanceMethod(class, newSelector);
    IMP origIMP = method_getImplementation(origMethod);
    IMP newIMP = method_getImplementation(newMethod);
    
    BOOL didAddMethod = class_addMethod(self, origSelector, newIMP, method_getTypeEncoding(newMethod));
    if (didAddMethod)
    {
        class_replaceMethod(class, newSelector, origIMP, method_getTypeEncoding(origMethod));
    }
    else
    {
        method_exchangeImplementations(origMethod, newMethod);
    }
}

@end
