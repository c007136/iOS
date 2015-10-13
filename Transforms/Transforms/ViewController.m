//
//  ViewController.m
//  Transforms
//
//  Created by miniu on 15/9/22.
//  Copyright (c) 2015年 miniu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIView             * view1;
@property (nonatomic, strong) UILabel            * label1;
@property (nonatomic, strong) UIButton           * button1;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.button1];
    self.button1.frame = CGRectMake(self.view.frame.size.width-100, 10, 90, 40);
    
    [self.view addSubview:self.view1];
    self.view1.frame = CGRectMake((self.view.frame.size.width-200)/2, 200, 200, 200);
    
//    [self.view1 addSubview:self.label1];
//    self.label1.frame = CGRectMake(10, 10, 50, 20);
    
    NSLog(@"center is %lf....%lf in viewDidLoad", self.view1.center.x, self.view1.center.y);
}

#pragma mark - event
- (void)clickButton1
{
    self.view1.transform = CGAffineTransformMakeRotation(M_PI/4);
    NSLog(@"center is %lf....%lf in clickButton1", self.view1.center.x, self.view1.center.y);
}

#pragma mark - getter and setter
- (UIView *)view1
{
    if (nil == _view1) {
        _view1 = [[UIView alloc] init];
        _view1.transform = CGAffineTransformMakeRotation(M_PI/4);
        _view1.layer.backgroundColor = [UIColor blueColor].CGColor;
    }
    return _view1;
}

- (UILabel *)label1
{
    if (nil == _label1) {
        _label1 = [[UILabel alloc] init];
        _label1.backgroundColor = [UIColor whiteColor];
        _label1.textColor = [UIColor darkTextColor];
        _label1.text = @"1";
        _label1.font = [UIFont systemFontOfSize:14];
    }
    return _label1;
}

- (UIButton *)button1
{
    if (nil == _button1) {
        _button1 = [[UIButton alloc] init];
        _button1.backgroundColor = [UIColor cyanColor];
        [_button1 addTarget:self action:@selector(clickButton1) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button1;
}


@end
