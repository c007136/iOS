//
//  CNViewController.m
//  NSProxy
//
//  Created by muyu on 2018/11/30.
//  Copyright © 2018 muyu. All rights reserved.
//

#import "CNViewController.h"
#import "TestProxyA.h"
#import "TestProxyB.h"

@interface CNViewController ()

@end

@implementation CNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //[self fun1];
    
    [self fun2];
}

- (void)fun1
{
    NSString *string = @"test";
    
    TestProxyA *proxyA = [[TestProxyA alloc] initWithTarget:string];
    TestProxyB *proxyB = [[TestProxyB alloc] initWithTarget:string];
    
    NSLog(@"%d", [proxyA respondsToSelector:@selector(length)]);
    NSLog(@"%d", [proxyB respondsToSelector:@selector(length)]);
    
    NSLog(@"%d", [proxyA isKindOfClass:[NSString class]]);
    NSLog(@"%d", [proxyB isKindOfClass:[NSString class]]);
    
    //NSLog(@"%@", [proxyA valueForKey:@"length"]);  编译失败
    //NSLog(@"%@", [proxyB valueForKey:@"length"]);  崩溃
}

- (void)fun2
{
    CFAbsoluteTime startTime =CFAbsoluteTimeGetCurrent();
    
    NSString *string = @"test";
    
//    for (NSInteger i = 0; i < 10000; i++)
//    {
//        TestProxyA *proxyA = [[TestProxyA alloc] initWithTarget:string];
//        [proxyA performSelector:@selector(length)];
//    }
    
    for (NSInteger i = 0; i < 10000; i++)
    {
        TestProxyB *proxyB = [[TestProxyB alloc] initWithTarget:string];
        id tt = [proxyB performSelector:@selector(length)];    // 崩溃？？
        NSLog(@"tt is %@", tt);
    }
    
    CFAbsoluteTime time = (CFAbsoluteTimeGetCurrent() - startTime);
    NSLog(@"time is %f ms", time *1000.0);
}

@end
