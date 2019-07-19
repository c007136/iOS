//
//  ViewController.m
//  Delegate
//
//  Created by miniu on 15/6/24.
//  Copyright (c) 2015年 miniu. All rights reserved.
//
//  delegate
//  weak指针研究
//  delegate和block对比

#import "ViewController.h"
#import "Weak1.h"
#import "Weak2.h"
#import "D1ViewController.h"

@interface ViewController ()
{
    Weak1 * _weak1;
    Weak2 * _weak2;
}

// init中： _weak2 ＝[[Weak2 alloc] init];
// viewDidLoad中：_weak2 ＝ nil;
// 证明weak不拥有对象
//@property (nonatomic, weak) Weak2 * weak2;

@property (nonatomic, strong) NSMutableString * string1;
@property (nonatomic, weak) NSMutableString * string2;

@end

@implementation ViewController

- (id)init
{
    self = [super init];
    if (self) {
        _weak1 = [[Weak1 alloc] init];
        _weak2 = [[Weak2 alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 如果是 string1 ＝ @"String1";
    // 则打印结果：String1
    // 参考链接：http://www.cnblogs.com/mybkn/archive/2012/03/08/2384860.html
    _string1 = [NSMutableString stringWithString:@"String1"];
    _string2 = _string1;
    _string1 = nil;
    NSLog(@"string2 is...%@...", _string2);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)button1Tapped:(id)sender {
    NSLog(@"button1 tapped.");
    
    // 点击“返回”按钮后，
    // delegate是成员变量： delegate为空
    // delegate是局部变量： delegate不为空
//    D1ViewController * d1 = [[D1ViewController alloc] init];
//    [self.navigationController pushViewController:d1 animated:YES];
    
    
    //Weak1 * weak1 = [[Weak1 alloc] init];
    [[Proxy proxy] run:3 text:@"11111" delegate:_weak1];
}

- (IBAction)button2Tapped:(id)sender {
    
    // 这般写法_delegate会被污染
    // 同时赋值 _delegate
    // 前者的delegate被替换掉了
    // 在这里，_weak1被替换_weak2
    NSLog(@"button2 tapped.");
    [[Proxy proxy] run:1 text:@"22222" delegate:_weak2];
    
    //_weak1 = nil;
}

@end
