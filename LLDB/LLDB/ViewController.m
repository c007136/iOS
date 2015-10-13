//
//  ViewController.m
//  LLDB
//
//  Created by miniu on 15/7/6.
//  Copyright (c) 2015年 miniu. All rights reserved.
//
//  LLDB学习
//  http://objccn.io/issue-19-2/
//
//  调试原理：
//  http://eli.thegreenplace.net/2011/01/23/how-debuggers-work-part-1.html


#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSInteger count = 99;
//    NSString * string = @"red";
//    
//    NSLog(@"%d, %@", count, string);
    
    int i = 99;
    BOOL event0 = [self isEven:i+2];
    BOOL event1 = [self isEven:i+1];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)isEven:(int)i
{
    if ( i % 2 == 0 ) {
        return YES;
    } else {
        return NO;
    }
}

@end
