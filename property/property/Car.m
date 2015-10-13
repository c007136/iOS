//
//  Car.m
//  property
//
//  Created by miniu on 15/6/29.
//  Copyright (c) 2015年 miniu. All rights reserved.
//

#import "Car.h"

@implementation Car

- (id)init
{
    self = [super init];
    if (self) {
        NSLog(@"Car init");
    }
    return self;
}

- (void)run
{
    NSLog(@"Car (%@) run", _number);
}

- (void)dealloc
{
    NSLog(@"car (%@) dealloc.", _number);
    [super dealloc];
}

- (id)copyWithZone:(NSZone *)zone
{
    // 不会进入init
    Car * copy = [Car allocWithZone:zone];
    copy.number = _number;
    return copy;
}

@end
