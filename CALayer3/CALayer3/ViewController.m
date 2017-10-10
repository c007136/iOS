//
//  ViewController.m
//  CALayer3
//
//  Created by muyu on 2017/9/6.
//  Copyright © 2017年 muyu. All rights reserved.
//
//  视觉效果和变换
//  http://www.cocoachina.com/ios/20150104/10816.html

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *layerView1;
@property (nonatomic, strong) UIView *layerView2;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGFloat width = self.view.frame.size.width;
    
    UIView *view1 = [[UIView alloc] init];
    view1.backgroundColor = [UIColor grayColor];
    view1.frame = CGRectMake(30, 100, width-60, 80);
    view1.layer.cornerRadius = 10;
    [self.view addSubview:view1];
    
    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = [UIColor grayColor];
    view2.frame = CGRectMake(30, 240, width-60, 80);
    view2.layer.cornerRadius = 10;
    view2.layer.masksToBounds = YES;
    [self.view addSubview:view2];
    
    UIView *layerView1 = [[UIView alloc] init];
    layerView1.backgroundColor = [UIColor redColor];
    layerView1.frame = CGRectMake(-10, -10, 40, 40);
    [view1 addSubview:layerView1];
    
    UIView *layerView2 = [[UIView alloc] init];
    layerView2.backgroundColor = [UIColor redColor];
    layerView2.frame = CGRectMake(-10, -10, 40, 40);
    [view2 addSubview:layerView2];
}

@end
