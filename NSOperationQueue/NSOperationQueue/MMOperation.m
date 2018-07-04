//
//  MMOperation.m
//  NSOperationQueue
//
//  Created by muyu on 2018/7/4.
//  Copyright © 2018年 muyu. All rights reserved.
//

#import "MMOperation.h"

NSString *const MMOperationCompletionNotification = @"MMOperationCompletionNotification";

@implementation MMOperation

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.name = NSStringFromClass([MMOperation class]);
    }
    return self;
}

- (void)main
{
//    for (NSInteger i = 0; i < 2; i++) {
//        [NSThread sleepForTimeInterval:2];
//        NSLog(@"name is %@ tag is %@ current thread is %@", self.name, @(self.tag), [NSThread currentThread]);
//    }
    
//    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(threadFunction) object:nil];
//    [thread start];
    
    NSThread *thread = [[NSThread alloc] initWithBlock:^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"name is %@ tag is %@ current thread is %@", self.name, @(self.tag), [NSThread currentThread]);
    }];
    [thread start];
}

- (void)threadFunction
{
    [NSThread sleepForTimeInterval:2];
    NSLog(@"name is %@ tag is %@ current thread is %@", self.name, @(self.tag), [NSThread currentThread]);
}

@end
