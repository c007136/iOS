//
//  RunLoopThread.m
//  NSRunLoop
//
//  Created by miniu on 15/8/18.
//  Copyright (c) 2015年 miniu. All rights reserved.
//

#import "RunLoopThread.h"

@interface RunLoopThread ()

@end

NSString * printActivity(CFRunLoopActivity activity)
{
    NSString *activityDescription;
    switch (activity) {
        case kCFRunLoopEntry:
            activityDescription = @"kCFRunLoopEntry";
            break;
        case kCFRunLoopBeforeTimers:
            activityDescription = @"kCFRunLoopBeforeTimers";
            break;
        case kCFRunLoopBeforeSources:
            activityDescription = @"kCFRunLoopBeforeSources";
            break;
        case kCFRunLoopBeforeWaiting:
            activityDescription = @"kCFRunLoopBeforeWaiting";
            break;
        case kCFRunLoopAfterWaiting:
            activityDescription = @"kCFRunLoopAfterWaiting";
            break;
        case kCFRunLoopExit:
            activityDescription = @"kCFRunLoopExit";
            break;
        default:
            break;
    }
    return activityDescription;
}

void currentRunLoopObserverCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info)
{
    NSLog(@"currentRunLoopObserverCallBack is called activity %@.", printActivity(activity));
}

@implementation RunLoopThread

- (void)main
{
    NSRunLoop * currentThreadRunLoop = [NSRunLoop currentRunLoop];
    
    CFRunLoopObserverContext context = {0, (__bridge void *)self, NULL, NULL, NULL};
    CFRunLoopObserverRef observer = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, currentRunLoopObserverCallBack, &context);
    
    /* 创建一个Run Loop Observer，并添加到当前的Run Loop，设置Mode为Default */
    if (observer) {
        CFRunLoopRef runLoopRef = currentThreadRunLoop.getCFRunLoop;
        CFRunLoopAddObserver(runLoopRef, observer, kCFRunLoopDefaultMode);
    }
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(handleTimerTask) userInfo:nil repeats:YES];
    
    NSInteger count = 2;
    do {
        [currentThreadRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:2]]; // todo muyu 有啥用途，这个Date
        count--;
    } while (count);
    
    NSLog(@"Thread is exit.");
}

- (void)handleTimerTask
{
    NSLog(@"handleTimerTask is called.");
}

@end

