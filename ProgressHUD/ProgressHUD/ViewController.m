//
//  ViewController.m
//  ProgressHUD
//
//  Created by miniu on 15/6/25.
//  Copyright (c) 2015年 miniu. All rights reserved.
//

#import "ViewController.h"
#import "ProgressHUDProxy.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)buttonTapped:(id)sender {
    NSLog(@"button tapped.");
    
    [ProgressHUDProxy showHUDWithText:@"...AAA..." autoHide:YES];
}

@end
