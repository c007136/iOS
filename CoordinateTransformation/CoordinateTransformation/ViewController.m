//
//  ViewController.m
//  CoordinateTransformation
//
//  Created by muyu on 2017/12/13.
//  Copyright © 2017年 muyu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *redView;
@property (nonatomic, strong) UIView *greenView;
@property (nonatomic, strong) UIView *blueView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.redView];
    [self.view addSubview:self.greenView];
    [self.redView addSubview:self.blueView];
    
    self.greenView.frame = CGRectMake(50, 50, 50, 50);
    self.redView.frame = CGRectMake(100, 100, 200, 200);
    self.blueView.frame = CGRectMake(40, 40, 80, 80);
    
    /*
     convertPoint...toView
     将像素point由point所在视图转换到目标视图view中，返回在目标视图view中的像素值
     
     convertPoint...fromView
     将像素point从view中转换到当前视图中，返回在当前视图中的像素值
     
     convertRect...toView
     将rect由rect所在视图转换到目标视图view中，返回在目标视图view中的rect
     
     convertRect...fromView
     将rect从view中转换到当前视图中，返回在当前视图中的rect
     */
    
    // 算出蓝色控件在view中的位置
    CGRect newRect = [self.view convertRect:self.blueView.frame fromView:self.redView];
    NSLog(@"new rect is (%@, %@), (%@, %@)", @(newRect.origin.x), @(newRect.origin.y), @(newRect.size.width), @(newRect.size.height));
    
    // toView为nil为什么会返回（20，20，40，40）
    newRect = [self.blueView convertRect:CGRectMake(20, 20, 40, 40) toView:self.view];
    NSLog(@"new rect is (%@, %@), (%@, %@)", @(newRect.origin.x), @(newRect.origin.y), @(newRect.size.width), @(newRect.size.height));
    
    // 蓝色控件中定义一个宽高各为40的正方形，相对于蓝色控件的坐标为（20, 20），算出这个正方形在绿色控件中的位置
    newRect = [self.blueView convertRect:CGRectMake(20, 20, 40, 40) toView:self.greenView];
    NSLog(@"new rect is (%@, %@), (%@, %@)", @(newRect.origin.x), @(newRect.origin.y), @(newRect.size.width), @(newRect.size.height));
}


#pragma mark - Getter and Setter

- (UIView *)redView
{
    if (_redView == nil) {
        _redView = [[UIView alloc] init];
        _redView.backgroundColor = [UIColor redColor];
    }
    return _redView;
}

- (UIView *)greenView
{
    if (_greenView == nil) {
        _greenView = [[UIView alloc] init];
        _greenView.backgroundColor = [UIColor greenColor];
    }
    return _greenView;
}

- (UIView *)blueView
{
    if (_blueView == nil) {
        _blueView = [[UIView alloc] init];
        _blueView.backgroundColor = [UIColor blueColor];
    }
    return _blueView;
}


@end
