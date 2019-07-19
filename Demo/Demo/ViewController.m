//
//  ViewController.m
//  Demo
//
//  Created by miniu on 15/6/23.
//  Copyright (c) 2015年 miniu. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 200, 50)];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonClick
{
    NSDictionary *dict = @{
                           @"1" : @(1),
                           @"2" : @(2),
                           @"3" : @(3),
                           @"4" : @(4)
                           };
    [dict enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull key, NSNumber *  _Nonnull value, BOOL * _Nonnull stop) {
        if ([key isEqualToString:@"1"]) {
            return;
        }
        
        NSLog(@"key is %@, value is %@", key, value);
    }];
}

@end
