//
//  WebViewControllerManager.m
//  CompositionToWebVC
//
//  Created by miniu on 15/6/30.
//  Copyright (c) 2015年 miniu. All rights reserved.
//

#import "WebViewControllerManager.h"

@interface WebViewControllerManager () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView * webView;

@end

@implementation WebViewControllerManager

- (id)initWithParentView:(UIView *)view url:(NSString *)stringURL
{
    self = [super init];
    if (self) {
        
        CGRect frame = CGRectMake(0.0, 0.0, view.frame.size.width, view.frame.size.height);
        _webView = [[UIWebView alloc] initWithFrame:frame];
        _webView.delegate = self;
        [view addSubview:_webView];
        
        NSURL * URL = [[NSURL alloc] initWithString:stringURL];
        NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:URL];
        [_webView loadRequest:request];
    }
    return self;
}

// delegate 不要放这....
#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"load web finish.");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"load web failed.");
}

@end
