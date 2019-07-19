//
//  ViewController.m
//  CircleProgress
//
//  Created by miniu on 15/7/20.
//  Copyright (c) 2015年 miniu. All rights reserved.
//


#define kWindowWidth CGRectGetWidth([UIScreen mainScreen].bounds)
#define kWindowHeight CGRectGetHeight([UIScreen mainScreen].bounds)

#import "ViewController.h"
#include "CircleProgressView.h"

@interface ViewController ()

@property (nonatomic, strong) CircleProgressView * circleProgressView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _circleProgressView = [[CircleProgressView alloc] init];
    _circleProgressView.backgroundColor = [UIColor yellowColor];
    _circleProgressView.frame = CGRectMake((kWindowWidth-150)/2, 100, 150, 150);
    [self.view addSubview:_circleProgressView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //self.circleProgressView.angle = 60;
    [self.circleProgressView setEndAngle:120.0f];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
