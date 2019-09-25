//
//  NSBundle+KKAppName.m
//  PalmDoctorPT
//
//  Created by muyu on 2017/6/19.
//  Copyright © 2017年 kangmeng. All rights reserved.
//

#import "NSBundle+KKAppName.h"

@implementation NSBundle (KKAppName)

+ (NSString *)kk_bundleName
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
}

@end
