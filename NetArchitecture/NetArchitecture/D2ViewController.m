//
//  D2ViewController.m
//  NetArchitecture
//
//  Created by miniu on 15/6/24.
//  Copyright (c) 2015年 miniu. All rights reserved.
//

#import "D2ViewController.h"

@interface D2ViewController ()

@end

@implementation D2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    NSLog(@"d2 dealloc");
}

@end
