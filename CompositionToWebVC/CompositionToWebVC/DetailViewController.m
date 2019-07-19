//
//  DetailViewController.m
//  CompositionToWebVC
//
//  Created by miniu on 15/6/30.
//  Copyright (c) 2015年 miniu. All rights reserved.
//

#import "DetailViewController.h"
#import "WebViewControllerManager.h"

@interface DetailViewController ()
{
    WebViewControllerManager * _webViewControllerManager;
}

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _webViewControllerManager = [[WebViewControllerManager alloc] initWithParentView:self.view url:@"http://www.baidu.com"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
