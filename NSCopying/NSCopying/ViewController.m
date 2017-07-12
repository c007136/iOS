//
//  ViewController.m
//  NSCopying
//
//  Created by muyu on 2017/6/27.
//  Copyright © 2017年 muyu. All rights reserved.
//
//  NSCopying协议与NSMutableCopying的区别主要是在于，返回的对象是否是可变类型的
//  http://www.jianshu.com/p/f84803356cbb

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Person *p1 = [[Person alloc] init];
    p1.name = @"muyu";
    p1.nick = @"007";
    
    // 因为实现了NSCopying协议
    Person *p2 = p1;
    NSLog(@"p2, name is %@, nick is %@", p2.name, p2.nick);
}

@end
