//
//  SecondViewController.m
//  ScrollViewMasonry
//
//  Created by muyu on 2018/8/15.
//  Copyright © 2018年 muyu. All rights reserved.
//

#import "SecondViewController.h"
#import <Masonry.h>
#import <MCCategory/UIView+MCFrame.h>
#import "Second1View.h"
#import "Second2View.h"
#import "Second3View.h"
#import "Second4View.h"

@interface SecondViewController ()
<
  UIScrollViewDelegate
>

@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) Second1View *second1View;
@property (nonatomic, strong) Second2View *second2View;
@property (nonatomic, strong) Second3View *second3View;
@property (nonatomic, strong) Second4View *second4View;

@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.segmentedControl];
    [self.view addSubview:self.scrollView];
    
    [self.scrollView addSubview:self.second1View];
    [self.scrollView addSubview:self.second2View];
    [self.scrollView addSubview:self.second3View];
    [self.scrollView addSubview:self.second4View];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuideBottom);
        make.left.width.equalTo(self.view);
        make.height.equalTo(@44);
    }];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.segmentedControl.mas_bottom);
        make.bottom.equalTo(self.mas_bottomLayoutGuideBottom);
        make.left.right.equalTo(self.view);
    }];
    
    [self.second1View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.segmentedControl.mas_bottom);
        make.width.bottom.equalTo(self.view);
        make.left.equalTo(@0);
    }];
    
    [self.second2View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.segmentedControl.mas_bottom);
        make.width.bottom.equalTo(self.view);
        make.left.equalTo(self.second1View.mas_right);
    }];

    [self.second3View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.segmentedControl.mas_bottom);
        make.width.bottom.equalTo(self.view);
        make.left.equalTo(self.second2View.mas_right);
    }];

    [self.second4View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.segmentedControl.mas_bottom);
        make.width.bottom.equalTo(self.view);
        make.left.equalTo(self.second3View.mas_right);
        make.right.equalTo(self.scrollView);
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.scrollView == scrollView)
    {
        CGFloat pageWidth = scrollView.width;
        NSInteger currentPage = floor((scrollView.contentOffset.x - pageWidth/2) / pageWidth)+ 1;
        if (currentPage != self.segmentedControl.selectedSegmentIndex) {
            self.segmentedControl.selectedSegmentIndex = currentPage;
        }
    }
}

- (void)onClickSegmentedControl:(UISegmentedControl *)control
{
    [self.scrollView setContentOffset:CGPointMake(control.selectedSegmentIndex*self.scrollView.width, 0) animated:YES];
}

- (UISegmentedControl *)segmentedControl
{
    if (_segmentedControl == nil) {
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"第一页", @"第二页", @"第三页", @"第四页"]];
        _segmentedControl.backgroundColor = [UIColor whiteColor];
        _segmentedControl.tintColor = [UIColor clearColor];
        [_segmentedControl setTitleTextAttributes:@{
                                                    NSFontAttributeName: [UIFont systemFontOfSize:16],
                                                    NSForegroundColorAttributeName: [UIColor grayColor]
                                                    }
                                         forState:UIControlStateNormal];
        [_segmentedControl setTitleTextAttributes:@{
                                                    NSFontAttributeName: [UIFont boldSystemFontOfSize:16],
                                                    NSForegroundColorAttributeName: [UIColor orangeColor]
                                                    }
                                         forState:UIControlStateSelected];
        [_segmentedControl addTarget:self action:@selector(onClickSegmentedControl:) forControlEvents:UIControlEventValueChanged];
        _segmentedControl.selectedSegmentIndex = 0;
    }
    return _segmentedControl;
}

- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.scrollEnabled = YES;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (Second1View *)second1View
{
    if (_second1View == nil) {
        _second1View = [[Second1View alloc] init];
    }
    return _second1View;
}

- (Second2View *)second2View
{
    if (_second2View == nil) {
        _second2View = [[Second2View alloc] init];
    }
    return _second2View;
}

- (Second3View *)second3View
{
    if (_second3View == nil) {
        _second3View = [[Second3View alloc] init];
    }
    return _second3View;
}

- (Second4View *)second4View
{
    if (_second4View == nil) {
        _second4View = [[Second4View alloc] init];
    }
    return _second4View;
}

@end
