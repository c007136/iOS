//
//  Second1View.m
//  ScrollViewMasonry
//
//  Created by muyu on 2018/8/15.
//  Copyright © 2018年 muyu. All rights reserved.
//

#import "Second1View.h"
#import <Masonry.h>

@interface Second1View ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *actionButton;
@property (nonatomic, strong) UIView *blueView;
@property (nonatomic, strong) UIView *redView;

@end

@implementation Second1View

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.scrollView];
        [self.scrollView addSubview:self.titleLabel];
        [self.scrollView addSubview:self.actionButton];
        [self.scrollView addSubview:self.blueView];
        [self.scrollView addSubview:self.redView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
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
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
        make.top.equalTo(self.actionButton.mas_bottom).offset(500);
        make.height.equalTo(@100);
        make.bottom.equalTo(self.scrollView).offset(-20);
    }];
}

- (void)onTapAction
{
    NSLog(@"....");
    
    self.redView.hidden = NO;
    
    [self.blueView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(40);
        make.right.equalTo(self).offset(-40);
        make.top.equalTo(self.actionButton.mas_bottom).offset(500);
        make.height.equalTo(@100);
    }];
    
    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
        make.top.equalTo(self.blueView.mas_bottom).offset(30);
        make.height.equalTo(@200);
        make.bottom.equalTo(self.scrollView).offset(-20);
    }];
}

- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
    }
    return _scrollView;
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