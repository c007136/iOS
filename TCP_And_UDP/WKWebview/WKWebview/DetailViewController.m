//
//  DetailViewController.m
//  WKWebview
//
//  Created by muyu on 16/10/21.
//  Copyright © 2016年 muyu. All rights reserved.
//

#import "DetailViewController.h"
#import <WebKit/WebKit.h>

@interface DetailViewController ()

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NSLog(@"%@", self.navigationController.view);
    NSLog(@"%@", self.view);
    
//    // 将WKWebView添加到视图
//    [self.view addSubview:self.webView];
//    
//    // 设置访问的URL
//    NSURL *url = [NSURL URLWithString:@"http://www.jianshu.com"];
//    // 根据URL创建请求
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    // WKWebView加载请求
//    [self.webView loadRequest:request];
}

- (WKWebView *)webView
{
    if (nil == _webView) {
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
        _webView.backgroundColor = [UIColor blueColor];
    }
    return _webView;
}

@end
