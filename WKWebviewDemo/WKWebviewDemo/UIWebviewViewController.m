//
//  UIWebviewViewController.m
//  WKWebviewDemo
//
//  Created by muyu on 2019/6/17.
//  Copyright © 2019 jkys. All rights reserved.
//

#import "UIWebviewViewController.h"

@interface UIWebviewViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webview;

@end

@implementation UIWebviewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.webview];
    self.webview.frame = self.view.bounds;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]];
    [self.webview loadRequest:request];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"shouldStartLoadWithRequest");
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidFinishLoad");
}

- (UIWebView *)webview
{
    if (_webview == nil) {
        _webview = [[UIWebView alloc] init];
        _webview.delegate = self;
    }
    return _webview;
}

@end
