//
//  ViewController.m
//  Xib
//
//  Created by miniu on 15/6/5.
//  Copyright (c) 2015年 miniu. All rights reserved.
//
//  参考链接：
//  http://www.cnblogs.com/nycoder/p/4333879.html

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UILabel *helloLable;
@property (strong, nonatomic) IBOutlet UIButton *helloButton;
@property (strong, nonatomic) IBOutlet UIButton *agreeButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)clickButton:(id)sender {
    self.helloLable.backgroundColor = [UIColor redColor];
    self.helloLable.text = @"xxxx_oooo";
    
    DetailViewController * detailVC = [[DetailViewController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
