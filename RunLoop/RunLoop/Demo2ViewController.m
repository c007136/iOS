//
//  Demo2ViewController.m
//  RunLoop
//
//  Created by muyu on 2018/4/19.
//  Copyright © 2018年 muyu. All rights reserved.
//
//  https://blog.csdn.net/u011619283/article/details/53436907

#import "Demo2ViewController.h"

@interface Demo2ViewController ()
<
  UITableViewDelegate,
  UITableViewDataSource
>

@property (nonatomic, strong) UILabel *timerLabel;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSThread *subThread;

@end

@implementation Demo2ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.timerLabel];
    [self.view addSubview:self.tableView];
    
    self.timerLabel.frame = CGRectMake(0, 60, self.view.frame.size.width, 40);
    self.tableView.frame = CGRectMake(30, 100, self.view.frame.size.width-60, self.view.frame.size.height-100);
    
    // CPU会在多个线程间切换来执行任务，执行的任务其实就是各个RunLoop各个Mode中的各个Item
    [self createThread];
    
    // Label不会刷新，原因是在滑动ScrollView时，主线程的RunLoop会切换到UITrackingRunLoopMode，执行的UITrackingRunLoopMode下的任务
    // 而Timer是添加到NSDefaultRunLoopMode下的，所以Timer任务不会被执行，只有当UITrackingRunLoopMode的任务执行完毕，RunLoop切换到
    // NSDefaultRunLoopMode后，才会继续执行Timer
    //[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFire) userInfo:nil repeats:YES];
    
    // NSRunLoopCommonModes: For Cocoa applications, this set includes the default, modal, and event tracking modes by default
    // 即默认包含NSDefaultRunLoopMode、NSModalPanelRunLoopMode、NSEventTrackingRunLoopMode
//    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerFire) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
//    [timer fire];
}

- (void)createThread
{
    self.subThread = [[NSThread alloc] initWithTarget:self selector:@selector(timerTest) object:nil];
    [self.subThread start];
}

- (void)timerTest
{
    @autoreleasepool {
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        NSLog(@"启动RunLoop前--%@",runLoop.currentMode);
        NSLog(@"currentRunLoop:%@",[NSRunLoop currentRunLoop]);
        
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFire) userInfo:nil repeats:YES];
        
        [[NSRunLoop currentRunLoop] run];
    }
}

- (void)timerFire
{
    // 针对Timer任务在子线程中的代码
    NSLog(@"当前线程：%@",[NSThread currentThread]);
    NSLog(@"启动RunLoop后--%@",[NSRunLoop currentRunLoop].currentMode);
    NSLog(@"currentRunLoop:%@",[NSRunLoop currentRunLoop]);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.count++;
        NSString *timerText = [NSString stringWithFormat:@"计时器:%@", @(self.count)];
        self.timerLabel.text = timerText;
    });
    
    return;
    
    // 针对Timer任务在主线程中的代码
    self.count++;
    NSString *timerText = [NSString stringWithFormat:@"计时器:%@", @(self.count)];
    self.timerLabel.text = timerText;
    
    return;
}

#pragma mark - UITableViewDelegate and UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell;
}

#pragma mark - getter and setter

- (UILabel *)timerLabel
{
    if (_timerLabel == nil) {
        _timerLabel = [[UILabel alloc] init];
        _timerLabel.backgroundColor = [UIColor orangeColor];
        _timerLabel.textColor = [UIColor blackColor];
        _timerLabel.font = [UIFont systemFontOfSize:20];
        _timerLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _timerLabel;
}

- (UITableView *)tableView
{
    if (nil == _tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = [UIColor grayColor];
        _tableView.sectionFooterHeight = 0;
        _tableView.sectionHeaderHeight = 0;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [_tableView setLayoutMargins:UIEdgeInsetsZero];
        }
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _tableView;
}

@end
