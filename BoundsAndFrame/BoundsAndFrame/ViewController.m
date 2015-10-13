//
//  ViewController.m
//  BoundsAndFrame
//
//  Created by miniu on 15/6/27.
//  Copyright (c) 2015年 miniu. All rights reserved.
//
//  理解bounds
//  bounds.origin.x>0 表示坐标轴左移，对应的内部子 view 左移，
//  bounds.origin.y>0 表示坐标轴上移，对应的内部子 view 上移
//  从而理解scrollview中子view移动的原理
//
//  如何利用ContentInset解决键盘遮盖界面问题
//
//  参考链接：
//  http://honglu.me/2014/10/21/%E6%B5%85%E6%9E%90frame%E4%B8%8Ebounds/
//  http://objccn.io/issue-3-2/

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor yellowColor];
    
    UIView * view1 = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 200, 200)];
    view1.backgroundColor = [UIColor redColor];
    // 是否支持裁剪
    view1.clipsToBounds = NO;
    [self.view addSubview:view1];
    
    UIView * view2 = [[UIView alloc] initWithFrame:CGRectMake(5, 5, 100, 100)];
    view2.backgroundColor = [UIColor blueColor];
    [view1 addSubview:view2];
    
    // view2整体向上移动了10像素
    CGRect bounds = view1.bounds;
    bounds.origin.y = 10;
    view1.bounds = bounds;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
