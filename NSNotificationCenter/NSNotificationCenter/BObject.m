//
//  BObject.m
//  NSNotificationCenter
//
//  Created by muyu on 2017/5/22.
//  Copyright © 2017年 muyu. All rights reserved.
//

#import "BObject.h"
#import "SObject.h"

@interface BObject ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) SObject *sObject;

@end


@implementation BObject

static BObject *INSTANCE = nil;
+(BObject *)getInstance
{
    if (!INSTANCE) {
        INSTANCE = [[BObject alloc] init];
    }
    return INSTANCE;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"%s", __func__);
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFire) userInfo:nil repeats:YES];
        _sObject = [[SObject alloc] init];
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

- (void)fun
{
    [self.delegate b_fun1];
}

@end
