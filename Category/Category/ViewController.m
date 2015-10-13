//
//  ViewController.m
//  Category
//
//  Created by miniu on 15/6/29.
//  Copyright (c) 2015年 miniu. All rights reserved.
//
//  Category中加变量
//
//  参考链接：
//  http://www.cnblogs.com/wupher/archive/2013/01/05/2845338.html
//  http://blog.csdn.net/onlyou930/article/details/9299169
//  http://blog.codingcoder.com/objc-associated-object/
//  http://nshipster.cn/associated-objects/

#import "ViewController.h"
#import "Persion+C.h"
#import <objc/runtime.h>
#import "AssociatedObject.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self learnAssociatedObject];
    
    //对象和被关联对象的生命周期是相互独立的
    //[AssociatedObject lifeCircle];
    
    // 在category中添加变量
    //[self addParamToCategory];
    
}

- (void)addParamToCategory
{
    Persion * p = [[Persion alloc] init];
    p.name = @"muyu";
    p.number = @"12345678";
    NSLog(@"person is : %@, %@", p.name, p.number);
}

// 关联到具体某一对象的，而不是某一类
- (void)learnAssociatedObject
{
    NSURL * u1 = [NSURL URLWithString:@"blog.codingcoder.com"];
    objc_setAssociatedObject(u1, @"u1key", @"associated object", OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    NSString * u1Get = (NSString *)objc_getAssociatedObject(u1, @"u1key");
    NSLog(@"objc_getAssociatedObject is : %@", u1Get);
    
    NSURL * u2 = [NSURL URLWithString:@"blog"];
    NSString * u2Get = (NSString *)objc_getAssociatedObject(u2, @"u1key");
    NSLog(@"objc_getAssociatedObject is : %@", u2Get);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
