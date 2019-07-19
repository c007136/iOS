//
//  Fraction.m
//  CopyAndMutableCopy
//
//  Created by miniu on 15/6/29.
//  Copyright (c) 2015年 miniu. All rights reserved.
//

#import "Fraction.h"

@implementation Fraction

- (id)init
{
    self = [super init];
    if (self) {
        _firstName = [NSString stringWithFormat:@"muyu"];
        NSLog(@"in init function first name retain count is %lu", _firstName.retainCount);
        _lastName = [NSString stringWithFormat:@"chan"];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    Fraction * copy = [Fraction allocWithZone:zone];
    copy.firstName = _firstName;//[_firstName copy]; 不能用后面的方式
    NSLog(@"in copyWithZone function first name retain count is %lu", _firstName.retainCount);
    copy.lastName = _lastName;//[_lastName copy];
    return copy;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    Fraction * mutableCopy = [Fraction allocWithZone:zone];
    mutableCopy.firstName = [_firstName mutableCopy];
    mutableCopy.lastName = [_lastName mutableCopy];
    return mutableCopy;
}

- (NSString *)description
{
    NSMutableString * output = [[NSMutableString alloc] init];
    [output appendFormat: @"adid = \"%@\"\r\n", _firstName];
    [output appendFormat: @"type = \"%@\"\r\n", _lastName];
    
    return output;
}

@end
