//
//  Proxy.m
//  Delegate
//
//  Created by miniu on 15/6/24.
//  Copyright (c) 2015年 miniu. All rights reserved.
//

#import "Proxy.h"

@implementation Proxy

+ (Proxy *)proxy
{
    static Proxy * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)run:(NSInteger)time text:(NSString *)text delegate:(id<PDelegate>)delegate
{
    // 1.delegate用的是局部变量
    // 成员变量＝nil后，delegate不为空
    // 局部变量被销毁后，delegate不为空
    //
    // 2.delegate是weak类型的成员变量
    // 成员变量＝nil后，delegate为空
    // 局部变量被销毁后，delegate为空
    
    //_delegate = delegate;
    
    double delayInSeconds = time*1.0;
    dispatch_time_t delayInNanoSeconds = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_after(delayInNanoSeconds, concurrentQueue, ^(void)
    {
        if (delegate != nil)
        {
            [delegate delegateFun:text];
        }
        else
        {
            NSLog(@"delegate is nil");
        }
    });
    
    // 两种方式
    //[NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(timerFire:) userInfo:text repeats:NO];
}

- (void)timerFire:(NSTimer *)timer
{
    if (_delegate == nil) {
        NSLog(@"delegate is nil.");
        return;
    }
    
    [_delegate delegateFun:timer.userInfo];
}

- (void)runByBlock:(DelegateBlock)block time:(NSInteger)time
{
    double delayInSeconds = time*1.0;
    dispatch_time_t delayInNanoSeconds = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_after(delayInNanoSeconds, concurrentQueue, ^(void)
    {
        NSString * text = @"bbbbb";
        block( text );
    });
}

@end
