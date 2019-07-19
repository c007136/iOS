//
//  D1ViewController.m
//  Delegate
//
//  Created by miniu on 15/6/24.
//  Copyright (c) 2015年 miniu. All rights reserved.
//

#import "D1ViewController.h"
#import "Proxy.h"

@interface D1ViewController () <PDelegate>

@end

@implementation D1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor brownColor];
    
    // dealloc后不执行
    [[Proxy proxy] run:5.0 text:@"D1" delegate:self];
    
//    // dealloc后还是会执行
//    [[Proxy proxy] runByBlock:^(NSString *text) {
//        NSLog(@"text %@ in block", text);
//    } time:10];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)delegateFun:(NSString *)text
{
    NSLog(@"DelegateFun in D1ViewController %@", text);
}

- (void)dealloc
{
    NSLog(@"D1ViewController dealloc.");
}

@end
