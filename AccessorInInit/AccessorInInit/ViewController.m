//
//  ViewController.m
//  AccessorInInit
//
//  Created by miniu on 15/7/25.
//  Copyright (c) 2015年 miniu. All rights reserved.
//
//  不要在init和dealloc中使用accessor
//  http://blog.sina.com.cn/s/blog_55a8a96d01012vik.html
//  http://stackoverflow.com/questions/192721/why-shouldnt-i-use-objective-c-2-0-accessors-in-init-dealloc

//  todo muyu Y 在非ARC环境下会崩溃

#import "ViewController.h"
#import "Test.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Test1 * test1 = [[Test1 alloc] init];
    NSLog(@"test1 str : %@, str1 : %@", test1.str, test1.str1);
    
    
    Test * test = (Test *)test1;
    NSLog(@"test1 str : %@, str1 : %@", test.str, test.str1);
    
    [test1 release];
    //[test release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
