//
//  DetailViewController.m
//  NSTimer
//
//  Created by muyu on 2017/6/26.
//  Copyright © 2017年 miniu. All rights reserved.
//
//  NSTimer如何做到“自释放”
//  http://www.olinone.com/?p=232

#import "DetailViewController.h"

@interface DetailViewController ()

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 200, 50)];
    button1.backgroundColor = [UIColor blueColor];
    [button1 setTitle:@"开始定时器" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(buttonClick1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(50, 200, 200, 50)];
    button2.backgroundColor = [UIColor blueColor];
    [button2 setTitle:@"返回" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(buttonClick2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
}

- (void)dealloc
{
    NSLog(@"%s", __FUNCTION__);
}

#pragma mark - event

- (void)buttonClick1
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
}

- (void)buttonClick2
{
    [self.timer invalidate];
    self.timer = nil;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)timerAction:(NSTimer *)timer
{
    NSLog(@"timer action");
}

@end
