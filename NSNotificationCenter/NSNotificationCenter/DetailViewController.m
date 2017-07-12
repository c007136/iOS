//
//  DetailViewController.m
//  NSNotificationCenter
//
//  Created by muyu on 2017/5/22.
//  Copyright © 2017年 muyu. All rights reserved.
//

#import "DetailViewController.h"
#import "TestObject.h"
#import "BObject.h"

@interface DetailViewController ()

@property (nonatomic, strong) TestObject *tObject;

@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 200, 40)];
    [button setTitle:@"创建对象" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor blueColor]];
    [button addTarget:self action:@selector(onButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    button = [[UIButton alloc] initWithFrame:CGRectMake(10, 200, 200, 40)];
    [button setTitle:@"发送消息" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor blueColor]];
    [button addTarget:self action:@selector(onButtonClicked2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)onButtonClicked
{
    
    
//    __weak __typeof(self) weakSelf = self;
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        
//        weakSelf.tObject = [[TestObject alloc] init];
//        
//        [weakSelf.tObject fun1];
//        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [weakSelf.tObject fun2];
//        });
//        
//    });
}

- (void)onButtonClicked2
{
    NSLog(@"%s", __func__);
    
    [[BObject getInstance] fun];
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
}

@end
