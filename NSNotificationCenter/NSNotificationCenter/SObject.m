//
//  SObject.m
//  NSNotificationCenter
//
//  Created by muyu on 2017/5/22.
//  Copyright © 2017年 muyu. All rights reserved.
//

#import "SObject.h"

@interface SObject ()

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation SObject

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"%s", __func__);
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFire) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)timerFire
{
    
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
}

@end
