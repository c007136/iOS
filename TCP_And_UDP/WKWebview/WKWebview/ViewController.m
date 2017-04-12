//
//  ViewController.m
//  WKWebview
//
//  Created by muyu on 16/10/21.
//  Copyright © 2016年 muyu. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import "DetailViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
//    // 创建WKWebView
//    WKWebView *webView = [[WKWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    // 设置访问的URL
//    NSURL *url = [NSURL URLWithString:@"http://www.jianshu.com"];
//    // 根据URL创建请求
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    // WKWebView加载请求
//    [webView loadRequest:request];
//    // 将WKWebView添加到视图
//    [self.view addSubview:webView];
    
    UIButton *button = [[UIButton alloc] init];
    button.backgroundColor = [UIColor blueColor];
    button.frame = CGRectMake(0, 100, self.view.frame.size.width, 50);
    [button addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    NSLog(@"%@", self.navigationController.view);
    NSLog(@"%@", self.view);
}

- (void)clickButton
{
    DetailViewController *vc = [[DetailViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
    return;
}


@end
