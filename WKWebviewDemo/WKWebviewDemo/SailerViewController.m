//
//  SailerViewController.m
//  WKWebviewDemo
//
//  Created by muyu on 2019/6/17.
//  Copyright © 2019 jkys. All rights reserved.
//

#import "SailerViewController.h"
#import <WebKit/WebKit.h>

@interface SailerViewController () <WKNavigationDelegate, WKUIDelegate>

@property (nonatomic, strong) WKWebView *webview;

@end

@implementation SailerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.webview];
    self.webview.frame = self.view.bounds;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]];
    [self.webview loadRequest:request];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSLog(@"decidePolicyForNavigationAction...");

    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"didStartProvisionalNavigation...");
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    NSLog(@"didFinishNavigation...");
}

- (WKWebView *)webview
{
    if (!_webview) {
        _webview = [[WKWebView alloc] init];
        _webview.navigationDelegate = self;
        _webview.UIDelegate = self;
    }
    return _webview;
}

@end
