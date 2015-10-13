//
//  ViewController.m
//  NSURLConnection
//
//  Created by miniu on 15/8/17.
//  Copyright (c) 2015年 miniu. All rights reserved.
//
//  NSURLConnection请求方式学习
//  http://blog.csdn.net/xyz_lmn/article/details/8968182
//  http://objccn.io/issue-5-4/

#import "ViewController.h"

// todo muyu 这两个协议可以不用标明
@interface ViewController () //<NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (nonatomic,strong) NSURLConnection   * connectionDelegate;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self httpSynchronousRequest];
    
    //[self httpAsynchronousRequest];
    
    // in main thread
    //[self.connectionDelegate start];
    
    // in work thread
    [NSThread detachNewThreadSelector:@selector(handleThreadTask) toTarget:self withObject:nil];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//        NSLog(@"in work thread.");
//        [self.connectionDelegate scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
//        [self.connectionDelegate start];
//    });
}

- (void)handleThreadTask
{
    NSRunLoop * runLoop = [NSRunLoop currentRunLoop];
    [self.connectionDelegate scheduleInRunLoop:runLoop forMode:NSRunLoopCommonModes];
    [self.connectionDelegate start];
    
    // 启动Run Loop
    [runLoop runUntilDate:[NSDate distantFuture]];
}

// 同步请求
- (void)httpSynchronousRequest
{
    // Y直接能请求呢，这是HTTPS呢？
    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com/"]];
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    NSString * string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    if (error == nil) {
        NSLog(@"httpSynchronousRequest success---- \nstring is: %@", string);
    } else {
        NSLog(@"httpSynchronousRequest failure---- \nerror is: %@", error);
    }
}

// 异步请求
- (void)httpAsynchronousRequest
{
    NSURL * url = [NSURL URLWithString:@"http://www.baidu.com"];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    NSOperationQueue * queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if ( connectionError != nil ) {
            NSLog(@"httpAsynchronousRequest failure---- \nerror is: %@", connectionError);
        } else {
            NSString * string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"httpAsynchronousRequest failure---- \nerror is: %@", string);
        }
        
    }];
}

// 异步请求 delegate方式
- (NSURLConnection *)connectionDelegate
{
    if (nil == _connectionDelegate) {
        NSURL * url = [NSURL URLWithString:@"http://www.baidu.com"];
        NSURLRequest * request = [NSURLRequest requestWithURL:url];
        _connectionDelegate = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
    }
    return _connectionDelegate;
}

#pragma mark - NSURLConnectionDelegate
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"connectionDelegate failure--- \nerror is %@", error);
}

#pragma mark - NSURLConnectionDataDelegate
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSString * string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"connectionDelegate success--- \nstring is %@", string);
}

@end
