//
//  ViewController.m
//  AutoLayout2
//
//  Created by miniu on 15/6/15.
//  Copyright (c) 2015年 miniu. All rights reserved.
//
//  AutoLayout学习
//  参考链接：
//  http://www.cnblogs.com/zer0Black/p/3977288.html

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (IBAction)buttonTapped1:(id)sender {
    
    if ([[sender titleForState:UIControlStateNormal] isEqualToString:@"X"]) {
        [sender setTitle:@"A very long title for this button"
                forState:UIControlStateNormal];
    } else {
        [sender setTitle:@"X" forState:UIControlStateNormal];
    }
    
}

- (IBAction)buttonTapped2:(id)sender {
    
    if ([[sender titleForState:UIControlStateNormal] isEqualToString:@"X"]) {
        [sender setTitle:@"A very long title for this button"
                forState:UIControlStateNormal];
    } else {
        [sender setTitle:@"X" forState:UIControlStateNormal];
    }
    
}

@end
