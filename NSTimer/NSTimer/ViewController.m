//
//  ViewController.m
//  NSTimer
//
//  Created by miniu on 15/8/18.
//  Copyright (c) 2015年 miniu. All rights reserved.
//
//  需要注意的是除了scheduledTimerWithTimeInterval开头的方法创建的Timer都需要手动添加到当前Run Loop中。（scheduledTimerWithTimeInterval 创建的timer会自动以Default Mode加载到当前Run Loop中。）
//
//  http://www.cnblogs.com/smileEvday/archive/2012/12/21/nstimer.html


#import "ViewController.h"
#import "TestObject.h"
#import "DetailViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // object对象会被retain
    //[self testNonRepeatTimer];
    //[self testRepeatTimer];
    
    // 没有runloop
    //[self testTimerWithoutShedule];
    
    // 有loop
    //[NSThread detachNewThreadSelector:@selector(testTimerSheduleToRunLoop) toTarget:self withObject:nil];
    
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 200, 50)];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)testNonRepeatTimer
{
    NSLog(@"testNonRepeatTimer is called.");
    TestObject * object = [[TestObject alloc] init];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:object selector:@selector(timerAction:) userInfo:nil repeats:NO];
}

- (void)testRepeatTimer
{
    NSLog(@"testRepeatTimer is called.");
    TestObject * object = [[TestObject alloc] init];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:object selector:@selector(timerAction:) userInfo:nil repeats:YES];
}

- (void)testTimerWithoutShedule
{
    NSLog(@"testTimerWithoutShedule is called.");
    TestObject * object = [[TestObject alloc] init];
    NSTimer * timer = [[NSTimer alloc] initWithFireDate:[NSDate dateWithTimeIntervalSinceNow:1] interval:1 target:object selector:@selector(timerAction:) userInfo:nil repeats:YES];
    
    // 需要主动add到runloop中
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

- (void)testTimerSheduleToRunLoop
{
    NSLog(@"testTimerSheduleToRunLoop is called.");
    
    TestObject * object = [[TestObject alloc] init];
    NSTimer * timer = [[NSTimer alloc] initWithFireDate:[NSDate dateWithTimeIntervalSinceNow:1] interval:1 target:object selector:@selector(timerAction:) userInfo:nil repeats:NO];
    
    // 添加timer
    // mode:
    // NSDefaultRunLoopMode
    // NSRunLoopCommonModes
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
    // 运行runloop
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:3]];
}

- (void)buttonClick
{
    DetailViewController *vc = [[DetailViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
