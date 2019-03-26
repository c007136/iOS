//
//  ViewController.m
//  NSInvocation
//
//  Created by muyu on 2018/6/22.
//  Copyright © 2018年 muyu. All rights reserved.
//
//  消息转发的一种方式
//
//  在iOS中可以直接调用某个对象的函数有三种
//  1. [self action]
//  2. performSelector:withObject
//  3. NSInvocation
//
//  NSInvocation作用
//  1. performSelector:withObject至多2个参数，大于2个参数就无法使用。NSInvocation不限制
//  2. NSInvocation返回值可以是基本类型：int，CGFloat, long等，performSelector只能是id类型
//
//
//  NSInvocation与PerformSelector：方法的介绍与区别
//  https://www.jianshu.com/p/8b9b0cd70462
//
//  Return value for performSelector:
//  https://stackoverflow.com/questions/6492033/return-value-for-performselector
//
//  消息处理之performSelector
//  https://www.jianshu.com/p/672c0d4f435a
//
//  NSInvocation在获取返回值后crash问题
//  https://blog.csdn.net/zengconggen/article/details/38024625
//
//  Why performSelector: Is More Dangerous Than I Thought
//  https://www.tomdalling.com/blog/cocoa/why-performselector-is-more-dangerous-than-i-thought/

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSInvocation *invocation;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //[self invocationArgumentDemo];
    
    //[self performSelectorArgumentDemo];
    
    //[self invocationReturnDemo];
    
    [self performSelectorReturnDemo];
}

#pragma mark - Invocation

// 绑定多个参数演示
- (void)invocationArgumentDemo
{
    NSLog(@"invocationArgumentDemo");
    
    NSMethodSignature *signature = [ViewController instanceMethodSignatureForSelector:@selector(methodWithArg1:arg2:)];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    
    invocation.target = self;
    invocation.selector = @selector(methodWithArg1:arg2:);
    NSString *name = [NSString stringWithFormat:@"Muyu"];
    NSDictionary *info = @{
                           @"age" : @(18),
                           @"id" : @"12345678",
                           };
    [invocation setArgument:&name atIndex:2];
    [invocation setArgument:&info atIndex:3];
    [invocation invoke];
}

- (void)performSelectorArgumentDemo
{
    NSLog(@"performSelectorArgumentDemo");
    
    // 至多两个参数
    NSString *name = [NSString stringWithFormat:@"Muyu"];
    NSDictionary *info = @{
                           @"age" : @(18),
                           @"id" : @"12345678",
                           };
    
    [self performSelector:@selector(methodWithArg1:arg2:) withObject:name withObject:info];
}

- (void)invocationReturnDemo
{
    NSLog(@"invocationReturnDemo");
    
    NSMethodSignature *signature = [ViewController instanceMethodSignatureForSelector:@selector(methodReturnDemo1)];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    
    invocation.target = self;
    invocation.selector = @selector(methodReturnDemo1);
    
//    id __unsafe_unretained tempResult = nil;
//    [invocation invoke];
//    [invocation getReturnValue:&tempResult];
//
//    NSDictionary *dict = (NSDictionary *)tempResult;
//    NSLog(@"dict is %@", dict);
    
    NSInteger tempResult;
    [invocation invoke];
    [invocation getReturnValue:&tempResult];
    
    NSLog(@"int is %@", @(tempResult));
    
    return;
}

- (void)performSelectorReturnDemo
{
    NSLog(@"performSelectorReturnDemo");
    
    id result = [self performSelector:@selector(methodReturnDemo2)];
    NSLog(@"reuslt class is %@ and result is %@", [result class], result);
}

#pragma mark - Selector

- (void)methodWithArg1:(NSString *)arg1 arg2:(NSDictionary *)arg2
{
    NSLog(@"My name is %@, info is %@", arg1, arg2);
}


- (NSInteger)methodReturnDemo1
{
    return 10;

    // return NSObject 类型的
//    NSDictionary *dict = @{
//                           @"keyA" : @"valueA",
//                           @"keyB" : @"valueB"
//                           };
//
//    return dict;
}

- (NSInteger)methodReturnDemo2
{
    return @(0);
}

#pragma mark - Super

- (NSString *)title
{
    return @"NSInvocation Demo";
}

@end
