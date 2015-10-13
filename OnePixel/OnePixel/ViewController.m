//
//  ViewController.m
//  OnePixel
//
//  Created by miniu on 15/7/23.
//  Copyright (c) 2015年 miniu. All rights reserved.
//
//  绘画一个像素的线
//  http://www.cnblogs.com/smileEvday/p/iOS_PixelVsPoint.html


#define ColorWithValue(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#import "ViewController.h"
#import "PartitionView.h"
#import "UIView+Partition.h"

@interface ViewController ()

@property (nonatomic, strong)  UIView      * backgroundView;
@property (nonatomic, strong)  UIView      * partitionView;

@property (nonatomic, strong)  PartitionView    * pView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self.view addSubview:self.pView];
    
//    // 是画，不是addSubview
//    [self.backgroundView addSubview:self.partitionView];
//    
//    NSLog(@"screen scale is %lf", [UIScreen mainScreen].scale);
//    
//    self.backgroundView.frame = CGRectMake(0, 100, self.view.frame.size.width, 201);
//    self.partitionView.frame = CGRectMake(0, 2.2, self.view.frame.size.width, SINGLE_LINE_WIDTH);
    
    [self.view addSubview:self.backgroundView];
}

- (void)viewWillLayoutSubviews
{
    //self.pView.frame = CGRectMake(0, 100, self.view.frame.size.width, 201);
    
    self.backgroundView.frame = CGRectMake(0, 100, self.view.frame.size.width, 201);
    
    [self.backgroundView layoutPartitionView];
    NSLog(@"viewWillLayoutSubviews is called");
}

#pragma mark - getter and setter
- (UIView *)backgroundView
{
    if (nil == _backgroundView) {
        _backgroundView = [[UIView alloc] init];
        _backgroundView.backgroundColor = ColorWithValue(0xF4F3F8);
        [_backgroundView addPartitionViewWithMode:0];
    }
    return _backgroundView;
}

- (UIView *)partitionView
{
    if (nil == _partitionView) {
        _partitionView = [[UIView alloc] init];
        _partitionView.backgroundColor = [UIColor blackColor];
    }
    return _partitionView;
}

- (PartitionView *)pView
{
    if (_pView == nil) {
        _pView = [[PartitionView alloc] init];
        _pView.backgroundColor = ColorWithValue(0xF4F3F8);
    }
    return _pView;
}

@end
