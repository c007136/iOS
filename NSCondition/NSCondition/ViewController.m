//
//  ViewController.m
//  NSCondition
//
//  Created by muyu on 2017/4/19.
//  Copyright © 2017年 muyu. All rights reserved.
//
//  http://blog.csdn.net/cuibo1123/article/details/41041949
//  http://www.cnblogs.com/easonoutlook/archive/2012/08/21/2649141.html

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *products;
@property (nonatomic, strong) NSCondition *condition;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 200, 40)];
    [button1 setTitle:@"按钮1" forState:UIControlStateNormal];
    [button1 setBackgroundColor:[UIColor blueColor]];
    [button1 addTarget:self action:@selector(onButton1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(10, 160, 200, 40)];
    [button2 setTitle:@"按钮2" forState:UIControlStateNormal];
    [button2 setBackgroundColor:[UIColor blueColor]];
    [button2 addTarget:self action:@selector(onButton2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
}

- (void)onButton1Clicked
{
    [NSThread detachNewThreadSelector:@selector(p_thread1) toTarget:self withObject:nil];
}

- (void)onButton2Clicked
{
    [NSThread detachNewThreadSelector:@selector(p_thread2) toTarget:self withObject:nil];
}

- (void)p_thread1
{
    while (1)
    {
        NSLog(@"thread1: 等待发送");
        [self.condition lock];
        [self.condition wait];
        NSLog(@"thread1: 发送");
        [self.condition unlock];
    }
}

- (void)p_thread2
{
    [self.condition lock];
    NSLog(@"thread1: 收到数据");
    [self.condition signal];
    [self.condition unlock];
}

- (void)onButtonClicked
{
    NSLog(@"button clicked......");
    
    [NSThread detachNewThreadSelector:@selector(p_createConsumer) toTarget:self withObject:nil];
    [NSThread detachNewThreadSelector:@selector(p_createProducer) toTarget:self withObject:nil];
}

- (void)p_createConsumer
{
    [self.condition lock];
    while (self.products.count == 0) {
        NSLog(@"wait for products");
        [self.condition wait];
    }
    
    [self.products removeObjectAtIndex:0];
    NSLog(@"remove a object");
    [self.condition unlock];
}

- (void)p_createProducer
{
    [self.condition lock];
    NSObject *object = [[NSObject alloc] init];
    [self.products addObject:object];
    NSLog(@"add a object");
    [self.condition signal];
    [self.condition unlock];
}

#pragma mark - getter and setter

- (NSMutableArray *)products
{
    if (nil == _products) {
        _products = [[NSMutableArray alloc] init];
    }
    return _products;
}

- (NSCondition *)condition
{
    if (nil == _condition) {
        _condition = [[NSCondition alloc] init];
    }
    return _condition;
}

@end
