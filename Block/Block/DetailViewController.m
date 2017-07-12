//
//  DetailViewController.m
//  Block
//
//  Created by muyu on 2017/7/4.
//  Copyright © 2017年 miniu. All rights reserved.
//

#import "DetailViewController.h"

typedef void (^BlockLearn) (NSString * param);

@interface DetailViewController ()

@property (nonatomic, copy) BlockLearn block;

@property (nonatomic, strong) NSString *text;

@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 200, 50)];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    self.text = @"I am text";
}

- (void)dealloc
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)buttonClick
{
    if (self.block == nil)
    {
        self.block = ^(NSString *param) {
            _text = @"I am test";
            
            // 会循环引用
            NSLog(@"%@", _text);
        };
    }
}

@end
