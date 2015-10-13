//
//  WebViewController.m
//  CompositionToWebVC
//
//  Created by miniu on 15/6/30.
//  Copyright (c) 2015年 miniu. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () <UIWebViewDelegate>
{
    UIWebView  * _webView;
    NSString   * _url;
}

@end

@implementation WebViewController

- (id)initWithUrl:(NSString *)url
{
    self = [super init];
    if (self) {
        _url = url;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _webView = [[UIWebView alloc] init];
    _webView.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height);
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    NSURL * URL = [[NSURL alloc] initWithString:_url];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:URL];
    [_webView loadRequest:request];
}

#pragma mark - WebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"load web finish.");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"load web failed.");
}

@end
