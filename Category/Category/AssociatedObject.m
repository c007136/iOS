//
//  AssociatedObject.m
//  Category
//
//  Created by miniu on 15/6/30.
//  Copyright (c) 2015年 miniu. All rights reserved.
//

#import "AssociatedObject.h"
#import <objc/runtime.h>

@implementation AssociatedObject

+ (void)lifeCircle
{
    static char cKey;
    NSArray * array = [[NSArray alloc] initWithObjects:@"aa", @"bb", @"cc", nil];
    NSString * string = [NSString stringWithFormat:@"%@", @"assciate"];
    
    objc_setAssociatedObject(array, &cKey, string, OBJC_ASSOCIATION_RETAIN);
    [string release];
    
    NSString * get = (NSString *)objc_getAssociatedObject(array, &cKey);
    NSLog(@"get is ..%@", get);
    
    // 去除关联
//    objc_removeAssociatedObjects(array);
//    get = (NSString *)objc_getAssociatedObject(array, &cKey);
//    NSLog(@"get is ..%@", get);
    
    // 去除关联
//    objc_setAssociatedObject(array, &cKey, nil, OBJC_ASSOCIATION_ASSIGN);
//    get = (NSString *)objc_getAssociatedObject(array, &cKey);
//    NSLog(@"get is ..%@", get);
    
    [array release];
    array = nil;
    
    // 需主动释放
    [string release];
    string = nil;
    NSLog(@"string is %@", string);
}

@end
