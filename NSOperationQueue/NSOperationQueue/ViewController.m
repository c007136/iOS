//
//  ViewController.m
//  NSOperationQueue
//
//  Created by muyu on 2018/7/4.
//  Copyright © 2018年 muyu. All rights reserved.
//

#import "ViewController.h"
#import "MMOperation.h"

@interface ViewController ()

@property (nonatomic, assign) NSInteger ticketCount;

@end

@implementation ViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onMMOperationCompletionNotification:) name:MMOperationCompletionNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self saleTicketQueue];
    
    //[self useUseOperationQueue];
    
    //[self useCustomOperation];
    
    //[self useBlockOperationAddExecutionBlock];
    
    //[self useBlockOperation];
    
    //[self useInvocationOperationInThread];
    
    //[self useInvocationOperation];
}

- (void)useInvocationOperation
{
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(useInvocationOperationInMainThreadTask) object:nil];
    [operation start];
}

- (void)useInvocationOperationInMainThreadTask
{
    for (NSInteger i = 0; i < 2; i++)
    {
        [NSThread sleepForTimeInterval:2];
        NSLog(@"current thread is %@", [NSThread currentThread]);
    }
}

- (void)useInvocationOperationInThread
{
    [NSThread detachNewThreadSelector:@selector(useInvocationOperation) toTarget:self withObject:nil];
}

- (void)useBlockOperation
{
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        for (NSInteger i = 0; i < 2; i++)
        {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"current thread is %@", [NSThread currentThread]);
        }
    }];
    [operation start];
}

- (void)useBlockOperationAddExecutionBlock
{
    NSBlockOperation *operation = [[NSBlockOperation alloc] init];
    
    [operation addExecutionBlock:^{
        for (NSInteger i = 0; i < 2; i++)
        {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1 ---- current thread is %@", [NSThread currentThread]);
        }
    }];
    
    [operation addExecutionBlock:^{
        for (NSInteger i = 0; i < 2; i++)
        {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2 ---- current thread is %@", [NSThread currentThread]);
        }
    }];
    
    [operation addExecutionBlock:^{
        for (NSInteger i = 0; i < 2; i++)
        {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"3 ---- current thread is %@", [NSThread currentThread]);
        }
    }];
    
    [operation addExecutionBlock:^{
        for (NSInteger i = 0; i < 2; i++)
        {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"4 ---- current thread is %@", [NSThread currentThread]);
        }
    }];
    
    [operation start];
}

- (void)useCustomOperation
{
    MMOperation *operation = [[MMOperation alloc] init];
    [operation start];
}

- (void)useUseOperationQueue
{
    NSMutableArray *mArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < 1; i++) {
        MMOperation *operation = [[MMOperation alloc] init];
        operation.tag = i;
        if (i == 5 || i == 7) {
            operation.queuePriority = NSOperationQueuePriorityHigh;
        }
        [operation setCompletionBlock:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:MMOperationCompletionNotification object:nil];
        }];
        
        [mArray addObject:operation];
    }
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 3;
    for (MMOperation *operation in mArray) {
        [queue addOperation:operation];
    }
}

- (void)onMMOperationCompletionNotification:(NSNotification *)notification
{
    NSLog(@"current thread is %@ in operation completion", [NSThread currentThread]);
}

- (void)saleTicketQueue
{
    NSLog(@"current thread is %@", [NSThread currentThread]);
    
    self.ticketCount = 50;
    
    NSOperationQueue *queue1 = [[NSOperationQueue alloc] init];
    queue1.maxConcurrentOperationCount = 1;
    
    NSOperationQueue *queue2 = [[NSOperationQueue alloc] init];
    queue2.maxConcurrentOperationCount = 1;
    
    __weak typeof(self) weakSelf = self;
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        [weakSelf saleTicketSafeOrNotSafe];
    }];
    
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        [weakSelf saleTicketSafeOrNotSafe];
    }];
    
    [queue1 addOperation:operation1];
    [queue2 addOperation:operation2];
}

- (void)saleTicketSafeOrNotSafe
{
    while (1)
    {
        @synchronized(self)
        {
            if (self.ticketCount > 0)
            {
                self.ticketCount--;
                NSString *text = [NSString stringWithFormat:@"剩余票数:%@ thread is %@", @(self.ticketCount), [NSThread currentThread]];
                NSLog(@"%@", text);
                [NSThread sleepForTimeInterval:0.2];
            }
            else
            {
                NSLog(@"票卖完了");
                break;
            }
        }
    }
}

@end
