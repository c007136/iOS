//
//  ViewController.m
//  Block
//
//  Created by miniu on 15/6/23.
//  Copyright (c) 2015年 miniu. All rights reserved.
//
//  block学习
//  block本质与变量类似，存储的数据是一个函数体
//  参考链接：
//  http://www.cnblogs.com/ludashi/p/3922911.html
//  http://blog.csdn.net/totogo2010/article/details/7839061

#import "ViewController.h"
#import "ComponentBlock.h"

@interface ViewController ()

@property (nonatomic, strong) ComponentBlock * componentBlock;

@end

@implementation ViewController

- (id)init
{
    self = [super init];
    if (self) {
        _componentBlock = [[ComponentBlock alloc] init];
        [_componentBlock setBlock:^void (NSString * param) {
            NSLog(@"---%@---", param);
        }];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_componentBlock run];
    
    [_componentBlock runWithBlock:^(NSString *param, NSDictionary *dictionary) {
       
        NSLog(@"### string : %@ ### dictionary : %@  ###", param, dictionary);
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
