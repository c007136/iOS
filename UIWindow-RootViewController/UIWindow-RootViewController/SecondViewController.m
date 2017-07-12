//
//  SecondViewController.m
//  UIWindow-RootViewController
//
//  Created by muyu on 2017/6/15.
//  Copyright © 2017年 muyu. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 100, 100)];
    button.backgroundColor = [UIColor blueColor];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonClick
{
    
}

@end
