//
//  RunLoopWorkDistribution.m
//  RunLoop
//
//  Created by muyu on 2018/5/9.
//  Copyright © 2018年 muyu. All rights reserved.
//

#import "RunLoopWorkDistribution.h"

@interface RunLoopWorkDistribution()

@property (nonatomic, strong) NSMutableArray *tasks;
@property (nonatomic, strong) NSMutableArray *taskKeys;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation RunLoopWorkDistribution

+ (instancetype)share
{
    static RunLoopWorkDistribution * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _maximumQueueLength = 30;
        _tasks = [NSMutableArray array];
        _taskKeys = [NSMutableArray array];
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFire) userInfo:nil repeats:YES];
    }
    return self;
}

#pragma mark - Action

- (void)timerFire
{
    
}

#pragma mark - Public Method

- (void)removeAllTasks
{
    [self.tasks removeAllObjects];
    [self.taskKeys removeAllObjects];
}

- (void)addTaskWithBlock:(RunLoopWorkDistributionBlock)block withKey:(id)key
{
    [self.tasks addObject:block];
    [self.taskKeys addObject:key];
    if (self.tasks.count > self.maximumQueueLength) {
        [self.tasks removeObjectAtIndex:0];
        [self.taskKeys removeObjectAtIndex:0];
    }
}

#pragma mark - Register Observer

+ (void)registerRunLoopObserver:(RunLoopWorkDistribution *)runLoopWorkDistribution
{
    
}

static void _registerObserver(CFOptionFlags activities, CFRunLoopObserverRef observer, CFIndex order, CFStringRef mode, void *info, CFRunLoopObserverCallBack callback)
{
    
}

@end
