//
//  ThreeViewController.m
//  ScrollViewMasonry
//
//  Created by muyu on 2018/8/22.
//  Copyright © 2018年 muyu. All rights reserved.
//

#import "ThreeViewController.h"
#import <Masonry.h>

@interface ThreeViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *actionButton;
@property (nonatomic, strong) UIView *blueView;
@property (nonatomic, strong) UIView *redView;

@end

@implementation ThreeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.contentView];
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.actionButton];
    [self.contentView addSubview:self.blueView];
    [self.contentView addSubview:self.redView];
    
    [self layoutAllSubViews];
}

- (void)layoutAllSubViews
{
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.bottom.equalTo(self.view);
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        }
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.width.equalTo(@100);
        make.top.equalTo(@20);
        make.height.equalTo(@40);
    }];
    
    [self.actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.width.equalTo(@100);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(30);
        make.height.equalTo(@40);
    }];
    
    [self.blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.top.equalTo(self.actionButton.mas_bottom).offset(500);
        make.height.equalTo(@100);
    }];
    
    if (self.redView.hidden == YES)
    {
        [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.scrollView);
            make.width.equalTo(self.scrollView);
            make.height.equalTo(@800);
        }];
    }
    else
    {
        [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.scrollView);
            make.width.equalTo(self.scrollView);
            make.height.equalTo(@1000);
        }];
        
        [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(20);
            make.right.equalTo(self.view).offset(-20);
            make.top.equalTo(self.blueView.mas_bottom).offset(30);
            make.height.equalTo(@200);
        }];
    }
}

- (void)onTapAction
{
    NSLog(@"....");
    
    self.redView.hidden = NO;
    [self layoutAllSubViews];
}

- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
    }
    return _scrollView;
}

- (UIView *)contentView
{
    if (_contentView == nil) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor orangeColor];
    }
    return _contentView;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor lightGrayColor];
        _titleLabel.text = @"Label";
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:18];
    }
    return _titleLabel;
}

- (UIButton *)actionButton
{
    if (_actionButton == nil) {
        _actionButton = [[UIButton alloc] init];
        _actionButton.backgroundColor = [UIColor lightGrayColor];
        [_actionButton setTitle:@"Button" forState:UIControlStateNormal];
        [_actionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _actionButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [_actionButton addTarget:self action:@selector(onTapAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _actionButton;
}

- (UIView *)blueView
{
    if (_blueView == nil) {
        _blueView = [[UIView alloc] init];
        _blueView.backgroundColor = [UIColor blueColor];
    }
    return _blueView;
}

- (UIView *)redView
{
    if (_redView == nil) {
        _redView = [[UIView alloc] init];
        _redView.backgroundColor = [UIColor redColor];
        _redView.hidden = YES;
    }
    return _redView;
}

@end
