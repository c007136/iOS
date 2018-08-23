//
//  EasyUseViewController.m
//  NSURLSession
//
//  Created by muyu on 2018/8/22.
//  Copyright © 2018年 muyu. All rights reserved.
//

#import "EasyUseViewController.h"
#import <UIViewController+ZBToastHUD.h>

@interface EasyUseViewController ()

@end

@implementation EasyUseViewController

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
    [self zb_showLoading];
    NSString *url = @"https://ss2.baidu.com/6ONYsjip0QIZ8tyhnq/it/u=1068968528,1710847403&fm=173&app=25&f=JPEG?w=500&h=332&s=6D104B9D27E360A25EF985DA0300C0B3";
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:nil];
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"location is %@", location);
        NSData *data = [NSData dataWithContentsOfURL:location];
        UIImage *downloadImage = [UIImage imageWithData:data];
        
        
        // 切换至主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(20, 200, 280, 280)];
            view.image = downloadImage;
            [self.view addSubview:view];
            
            [self zb_dismiss];
        });
    }];
    [downloadTask resume];
}

@end
