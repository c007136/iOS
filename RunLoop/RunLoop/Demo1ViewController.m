//
//  Demo1ViewController.m
//  RunLoop
//
//  Created by muyu on 2018/4/19.
//  Copyright © 2018年 muyu. All rights reserved.
//
//  https://blog.csdn.net/u011619283/article/details/53433243

#import "Demo1ViewController.h"
#import "HLThread.h"

@interface Demo1ViewController ()

@property (nonatomic, strong) HLThread *subThread;

@end

@implementation Demo1ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    CFRunLoopRef runLoopRef = CFRunLoopGetMain();
    CFArrayRef modes = CFRunLoopCopyAllModes(runLoopRef);
    NSLog(@"MainRunLoop中的modes:%@",modes);
    NSLog(@"MainRunLoop对象：%@",runLoopRef);
    
    [self threadTest];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self performSelector:@selector(subThreadOpetion) onThread:self.subThread withObject:nil waitUntilDone:NO];
}

- (void)threadTest
{
    HLThread *subThread = [[HLThread alloc] initWithTarget:self selector:@selector(subThreadEntryPoint) object:nil];
    [subThread setName:@"HLThread"];
    [subThread start];
    self.subThread = subThread;
}

// runloop使得线程长时间存活
- (void)subThreadEntryPoint
{
    // 除GCD外，手动创建AutoReleasePool
    @autoreleasepool
    {
        NSRunLoop *runloop = [NSRunLoop currentRunLoop];
        // 如果注释了下面这一行，子线程中的任务并不能正常执行
        // 如果一个Mode中一个Item都没有，则RunLoop会直接退出，不会进入循环。
        [runloop addPort:[NSMachPort port] forMode:NSRunLoopCommonModes];
        NSLog(@"启动RunLoop前--%@",runloop.currentMode);
        [runloop run];
        
        NSLog(@"current run loop--%@", runloop);
    }
}

- (void)subThreadOpetion
{
    // 执行任务在Mode间切换，只执行该Mode上的任务
    NSLog(@"启动RunLoop后--%@",[NSRunLoop currentRunLoop].currentMode);
    NSLog(@"%@----子线程任务开始",[NSThread currentThread]);
    [NSThread sleepForTimeInterval:3.0];
    NSLog(@"%@----子线程任务结束",[NSThread currentThread]);
}

#pragma mark - super

- (NSString *)title
{
    return @"DEMO1";
}

@end
