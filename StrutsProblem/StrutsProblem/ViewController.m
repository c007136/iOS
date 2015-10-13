//
//  ViewController.m
//  StrutsProblem
//
//  Created by miniu on 15/6/10.
//  Copyright (c) 2015年 miniu. All rights reserved.
//
//  自动布局学习：
//  http://www.cocoachina.com/industry/20131203/7462.html
//  同时参考：StrutsProblem工程

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *topLeftView;
@property (weak, nonatomic) IBOutlet UIView *topRightView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//- (void)viewWillLayoutSubviews {
//    [super viewWillLayoutSubviews];
//    
//    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]))
//    {
//        CGRect rect = self.topLeftView.frame;
//        rect.size.width = 254;
//        rect.size.height = 130;
//        self.topLeftView.frame = rect;
//        
//        rect = self.topRightView.frame;
//        rect.origin.x = 294;
//        rect.size.width = 254;
//        rect.size.height = 130;
//        self.topRightView.frame = rect;
//        
//        rect = self.bottomView.frame;
//        rect.origin.y = 170;
//        rect.size.width = 528;
//        rect.size.height = 130;
//        self.bottomView.frame = rect;
//    }
//    else
//    {
//        CGRect rect = self.topLeftView.frame;
//        rect.size.width = 130;
//        rect.size.height = 254;
//        self.topLeftView.frame = rect;
//        
//        rect = self.topRightView.frame;
//        rect.origin.x = 170;
//        rect.size.width = 130;
//        rect.size.height = 254;
//        self.topRightView.frame = rect;
//        
//        rect = self.bottomView.frame;
//        rect.origin.y = 295;
//        rect.size.width = 280;
//        rect.size.height = 254;
//        self.bottomView.frame = rect;
//    }
//}

@end
