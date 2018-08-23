//
//  DelegateQueueViewController.m
//  NSURLSession
//
//  Created by muyu on 2018/8/23.
//  Copyright © 2018年 muyu. All rights reserved.
//

#import "DelegateQueueViewController.h"
#import <UIViewController+ZBToastHUD.h>

@interface DelegateQueueViewController ()
<
  NSURLSessionDelegate
>

@property (nonatomic, strong) NSURLSession *session;

@end

@implementation DelegateQueueViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 200, 50)];
    button.backgroundColor = [UIColor orangeColor];
    [button addTarget:self action:@selector(onButtonTappedAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)onButtonTappedAction
{
    NSLog(@"download start... current thread is %@", [NSThread currentThread]);
    NSString *url1 = @"https://ss2.baidu.com/6ONYsjip0QIZ8tyhnq/it/u=1068968528,1710847403&fm=173&app=25&f=JPEG?w=500&h=332&s=6D104B9D27E360A25EF985DA0300C0B3";
    NSURLSessionDownloadTask *downloadTask1 = [self.session downloadTaskWithURL:[NSURL URLWithString:url1]];
    downloadTask1.taskDescription = @"task1";
    [downloadTask1 resume];
    
    NSString *url2 = @"https://ss2.baidu.com/6ONYsjip0QIZ8tyhnq/it/u=3902559155,3805767758&fm=173&app=25&f=JPEG?w=580&h=330&s=BE366180001353D4160421DF030010B2";
    NSURLSessionDownloadTask *downloadTask2 = [self.session downloadTaskWithURL:[NSURL URLWithString:url2]];
    downloadTask2.taskDescription = @"task2";
    [downloadTask2 resume];
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
                                           didWriteData:(int64_t)bytesWritten
                                      totalBytesWritten:(int64_t)totalBytesWritten
                              totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    NSLog(@"downloading... current thread is %@, task is %@", [NSThread currentThread], downloadTask.taskDescription);
    [NSThread sleepForTimeInterval:3];
}


- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
                           didCompleteWithError:(nullable NSError *)error
{
    NSLog(@"download finish... current thread is %@, task is %@", [NSThread currentThread], task.taskDescription);
    [NSThread sleepForTimeInterval:3];
}

- (NSURLSession *)session
{
    if (_session == nil) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        /*
         * delegateQueue不设置，则block和delegate，在子线程中
         * = [NSOperationQueue mainQueue]，则在主线程中
         * = [[NSOperationQueue alloc] init]，则在子线程中
         */
        //NSOperationQueue *queue = [NSOperationQueue mainQueue];
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        queue.maxConcurrentOperationCount = 1;
        _session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:queue];
    }
    return _session;
}

@end
