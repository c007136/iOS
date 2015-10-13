//
//  ViewController.m
//  ScrollView
//
//  Created by miniu on 15/7/17.
//  Copyright (c) 2015年 miniu. All rights reserved.
//
//  参考链接：
//  http://unremittingly.iteye.com/blog/2031626

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, assign) NSInteger          count;

@property (nonatomic, strong) UIScrollView       * scrollView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;   // ios7 的问题
    self.view.backgroundColor = [UIColor redColor];

    [self.view addSubview:self.scrollView];
}

- (void)viewWillLayoutSubviews
{
    self.scrollView.frame = CGRectMake(0, 164, self.view.frame.size.width, self.view.frame.size.height-200);
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    /* 理解NSRunLoop
       在主线程启动一个计时器Timer，然后拖动UIScollView，计时器不执行。
       这是因为为了更好的用户体验，Event tracking模式的优先级最高，而创建timer默认关联为Default Mode
     */
    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(timerFire) userInfo:nil repeats:YES];
    // NSDefaultRunLoopMode
    // NSRunLoopCommonModes
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    [timer fire];
}

- (void)timerFire
{
    self.count++;
    NSLog(@"timer fire... %ld", self.count);
}



#pragma mark - getter and setter
- (UIScrollView *)scrollView
{
    if (nil == _scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor grayColor];
    }
    return _scrollView;
}


@end
