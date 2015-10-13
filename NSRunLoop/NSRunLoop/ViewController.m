//
//  ViewController.m
//  NSRunLoop
//
//  Created by miniu on 15/8/17.
//  Copyright (c) 2015年 miniu. All rights reserved.
//
//  NSRunLoop
//  Runloop的作用：减少CPU做无谓的空转，CPU可以在空闲的时候休眠，以节约电源
//  十分类似windows的信号量（Event，Semphone），想象一下WaitForSingleObject
//  输入源：
//      事件源：
//         基于端口的源（mach port）
//         自定义源
//      performSelector源
//      定时器
//      观察者
//

//  关于NSDefaultRunLoopMode和NSRunLoopCommonModes区别查看例子ScrollView
//  http://www.cnblogs.com/zy1987/p/4582466.html
//
//
//  参考链接：
//  http://chun.tips/blog/2014/10/20/zou-jin-run-loopde-shi-jie-%5B%3F%5D-:shi-yao-shi-run-loop%3F/


#import "ViewController.h"
#import <CoreFoundation/CoreFoundation.h>
#import "RunLoopThread.h"

@interface ViewController ()

@property (nonatomic) BOOL normalThreadDidFinishFlag;
@property (nonatomic) BOOL runLoopThreadDidFinishFlag;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UIButton appearance] setBackgroundColor:[UIColor blueColor]];
    
    /* 点击之后，创建一个普通线程，执行相应的线程任务，等待后再继续执行相应任务，该线程任务会阻碍UI线程 */
    UIButton * normalThreadButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, 200, 50)];
    [normalThreadButton setTitle:@"Normal Thread Button" forState:UIControlStateNormal];
    [normalThreadButton addTarget:self action:@selector(handleNormalThreadButtonTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:normalThreadButton];
    
    /* 点击之后，创建一个普通线程，执行相应的线程任务，利用RunLoop等待而后执行相应任务，该线程不会阻碍UI线程 */
    UIButton * runLoopThreadButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 200, 50)];
    [runLoopThreadButton setTitle:@"Run Loop Button" forState:UIControlStateNormal];
    [runLoopThreadButton addTarget:self action:@selector(handleRunLoopButtonTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:runLoopThreadButton];
    
    /*测试Button，看UI能否正常响应*/
    UIButton * testButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 170, 200, 50)];
    [testButton setTitle:@"Test Button" forState:UIControlStateNormal];
    [testButton addTarget:self action:@selector(handleTestButtonTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:testButton];
    
    UIButton * runLoopObserver = [[UIButton alloc] initWithFrame:CGRectMake(10, 240, 300, 50)];
    [runLoopObserver setTitle:@"Run Loop Observer Button" forState:UIControlStateNormal];
    [runLoopObserver addTarget:self action:@selector(handleRunLoopObserverButtonTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:runLoopObserver];
}

#pragma mark - event
- (void)handleNormalThreadButtonTouchUpInside
{
    NSLog(@"handleNormalThreadButtonTouchUpInside is called.");
    
    self.normalThreadDidFinishFlag = NO;
    
    NSThread * normalThread = [[NSThread alloc] initWithTarget:self selector:@selector(handleNormalThreadTask) object:nil];
    [normalThread start];
    
    // 会阻塞UI主线程
    while (!self.normalThreadDidFinishFlag) {
        NSLog(@"before sleepForTimeInterval in handleNormalThreadButtonTouchUpInside");
        [NSThread sleepForTimeInterval:1.0];
        NSLog(@"after sleepForTimeInterval in handleNormalThreadButtonTouchUpInside");
    }
    
    NSLog(@"handleNormalThreadButtonTouchUpInside is end.");
}

- (void)handleRunLoopButtonTouchUpInside
{
    NSLog(@"handleRunLoopButtonTouchUpInside is called.");
    
    self.runLoopThreadDidFinishFlag = NO;
    
    NSThread * runLoopThread = [[NSThread alloc] initWithTarget:self selector:@selector(handleRunLoopThreadTask) object:nil];
    [runLoopThread start];
    
    while ( !self.runLoopThreadDidFinishFlag ) {
        NSLog(@"begin run loop");
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        NSLog(@"end run loop");
    }
    
    NSLog(@"handleRunLoopButtonTouchUpInside is end");
}

- (void)handleTestButtonTouchUpInside
{
    NSLog(@"handleTestButtonTouchUpInside is called.");
}

- (void)handleRunLoopObserverButtonTouchUpInside
{
    NSLog(@"handleRunLoopObserverButtonTouchUpInside is called.");
    
    RunLoopThread * thread = [[RunLoopThread alloc] init];
    [thread start];
}

#pragma mark - thread task
- (void)handleNormalThreadTask
{
    NSLog(@"handleNormalThreadTask is called.");
    
    for (int i = 0; i < 5; i++) {
        NSLog(@"in handleNormalThreadTask count = %d", i);
        sleep(2.0);
    }
    
    self.normalThreadDidFinishFlag = YES;
    
    NSLog(@"handleNormalThreadTask is end");
}

- (void)handleRunLoopThreadTask
{
    NSLog(@"handleRunLoopThreadTask is called.");
    
    for (int i = 0; i < 5; i++) {
        NSLog(@"in handleRunLoopThreadTask count = %d", i);
        sleep(1.0);
    }
    
#if 0
    // 错误示范
    /* 这样不能立马通知RunLoop 和这篇文章说的有出入：http://chun.tips/blog/2014/10/20/zou-jin-run-loopde-shi-jie-%5B%3F%5D-:shi-yao-shi-run-loop%3F/ */
    self.runLoopThreadDidFinishFlag = YES;
#else
    [self performSelectorOnMainThread:@selector(updateRunLoopThreadDidFinishFlag) withObject:nil waitUntilDone:NO];
#endif
    
    NSLog(@"handleRunLoopThreadTask is end");
}

#pragma mark - private
- (void)updateRunLoopThreadDidFinishFlag
{
    self.runLoopThreadDidFinishFlag = YES;
}


@end
