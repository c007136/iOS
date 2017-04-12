//
//  ViewController.m
//  HookForTrack
//
//  Created by muyu on 2017/3/13.
//  Copyright © 2017年 muyu. All rights reserved.
//

#import "ViewController.h"
#import "AViewController.h"
#import "BViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIButton *aButton = [[UIButton alloc] init];
    aButton.backgroundColor = [UIColor purpleColor];
    aButton.frame = CGRectMake(0, 80, CGRectGetWidth(self.view.frame), 50);
    [self.view addSubview:aButton];
    [aButton addTarget:self action:@selector(clickAButton) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *bButton = [[UIButton alloc] init];
    bButton.backgroundColor = [UIColor purpleColor];
    bButton.frame = CGRectMake(0, 180, CGRectGetWidth(self.view.frame), 50);
    [self.view addSubview:bButton];
    [bButton addTarget:self action:@selector(clickBButton) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSLog(@"P...viewDidAppear");
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    NSLog(@"P...viewDidDisappear");
}

- (void)clickAButton
{
    AViewController *vc = [[AViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickBButton
{
    BViewController *vc = [[BViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
