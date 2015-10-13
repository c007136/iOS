//
//  TestObject.m
//  NSTimer
//
//  Created by miniu on 15/8/18.
//  Copyright (c) 2015年 miniu. All rights reserved.
//

#import "TestObject.h"

@implementation TestObject

- (id)init
{
    self = [super init];
    if (self) {
        NSLog(@"instance %@ has been created!", self);
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"instance %@ has been dealloced!", self);
}

- (void)timerAction:(NSTimer *)timer
{
    NSLog(@"timer action for instance %@", self);
}

@end
