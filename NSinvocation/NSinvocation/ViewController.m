//
//  ViewController.m
//  NSInvocation
//
//  Created by muyu on 2018/6/22.
//  Copyright © 2018年 muyu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSInvocation *invocation;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    [invocation retainArguments];   // 不调用这句话的，会直接崩溃
    self.invocation = invocation;
    
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 200, 50)];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonClick
{
    [self.invocation invoke];
}

- (void)methodWithArg1:(NSString *)arg1 arg2:(NSDictionary *)arg2
{
    NSLog(@"My name is %@, info is %@", arg1, arg2);
}

@end
