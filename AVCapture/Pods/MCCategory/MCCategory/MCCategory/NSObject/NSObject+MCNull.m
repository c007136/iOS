//
//  NSObject+MCNull.m
//  Demo
//
//  Created by muyu on 16/10/28.
//  Copyright © 2016年 miniu. All rights reserved.
//

#import "NSObject+MCNull.h"

@implementation NSObject (MCNull)

+ (BOOL)mc_isNull:(id)target
{
    if (nil == target || [target isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    return NO;
}

@end
