//
//  Persion+C.m
//  Category
//
//  Created by miniu on 15/6/29.
//  Copyright (c) 2015年 miniu. All rights reserved.
//
//  Category中加变量
//  

#import "Persion+C.h"
#import <objc/runtime.h>

static char kCKey;

@implementation Persion (C)

@dynamic number;

- (void)setNumber:(NSString *)number
{
    objc_setAssociatedObject(self, &kCKey, number, OBJC_ASSOCIATION_COPY);
}

- (NSString *)number
{
    return objc_getAssociatedObject(self, &kCKey);
}

@end
