//
//  RetainAndCopy.m
//  property
//
//  Created by miniu on 15/6/29.
//  Copyright (c) 2015年 miniu. All rights reserved.
//
//  参考

#import "RetainAndCopy.h"

@implementation RetainAndCopy

- (void)setStringRetain:(NSString *)stringRetain
{
    [_stringRetain release];
    _stringRetain = stringRetain;
    NSLog(@"retainString's retainCount %lu", [_stringRetain retainCount]);
    NSLog(@"pointer of string copy : %p--%p--%p--%p", stringRetain, &stringRetain, _stringRetain, &_stringRetain);
}

- (void)setStringCopy:(NSString *)stringCopy
{
    [_stringCopy release];
    _stringCopy = [stringCopy copy];
    NSLog(@"pointer of string copy : %p--%p--%p--%p", stringCopy, &stringCopy, _stringCopy, &_stringCopy);
}

@end
