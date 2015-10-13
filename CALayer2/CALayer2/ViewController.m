//
//  ViewController.m
//  CALayer2
//
//  Created by miniu on 15/8/28.
//  Copyright (c) 2015年 miniu. All rights reserved.
//
//  学习隐式动画
//  https://github.com/AttackOnDobby/iOS-Core-Animation-Advanced-Techniques/blob/master/7-%E9%9A%90%E5%BC%8F%E5%8A%A8%E7%94%BB/%E9%9A%90%E5%BC%8F%E5%8A%A8%E7%94%BB.md

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) CALayer        * colorLayer;
@property (nonatomic, strong) UIButton       * button;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self.view.layer addSublayer:self.colorLayer];
    [self.view addSubview:self.button];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.colorLayer.frame = CGRectMake(50, 50, 100, 100);
    self.button.frame = CGRectMake(50.0f, 180.0f, 50.0f, 20.f);
}

#pragma mark - event
- (void)clickButton
{
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
}

#pragma mark - getter and setter
- (CALayer *)colorLayer
{
    if (nil == _colorLayer) {
        _colorLayer = [CALayer layer];
        _colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    }
    return _colorLayer;
}

- (UIButton *)button
{
    if (nil == _button) {
        _button = [[UIButton alloc] init];
        _button.backgroundColor = [UIColor redColor];
        [_button addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

@end
