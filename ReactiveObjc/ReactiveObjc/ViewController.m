//
//  ViewController.m
//  ReactiveObjc
//
//  Created by muyu on 2018/11/14.
//  Copyright © 2018 muyu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *aButton;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.aButton];
}

- (void)buttonClick
{
    NSLog(@"....");
}

- (UIButton *)aButton
{
    if (_aButton == nil) {
        _aButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 200, 50)];
        _aButton.backgroundColor = [UIColor redColor];
        [_aButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _aButton;
}


@end
