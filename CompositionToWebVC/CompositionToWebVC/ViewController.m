//
//  ViewController.m
//  CompositionToWebVC
//
//  Created by miniu on 15/6/30.
//  Copyright (c) 2015年 miniu. All rights reserved.
//
//  解耦方式：组合大于继承
//
//  参考链接：
//  http://casatwy.com/tiao-chu-mian-xiang-dui-xiang-si-xiang-yi-ji-cheng.html

#import "ViewController.h"
#import "WebViewController.h"
#import "DetailViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)buttonTapped:(id)sender {
    NSLog(@"hello kity");
    
    DetailViewController * detailVC = [[DetailViewController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
    
//    WebViewController * webVC = [[WebViewController alloc] initWithUrl:@"http://www.baidu.com"];
//    [self.navigationController pushViewController:webVC animated:YES];
}

@end
