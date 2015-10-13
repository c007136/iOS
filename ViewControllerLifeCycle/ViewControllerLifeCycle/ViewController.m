//
//  ViewController.m
//  ViewControllerLifeCycle
//
//  Created by miniu on 15/6/8.
//  Copyright (c) 2015年 miniu. All rights reserved.
//
//  ViewController的生命周期
//  参考链接：
//  http://blog.csdn.net/jjunjoe/article/details/8730326

#import "ViewController.h"
#import "LifeCycleViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 100, 100)];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonClick {
    LifeCycleViewController * lifeCycle = [[LifeCycleViewController alloc] init];
    [self.navigationController pushViewController:lifeCycle animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
