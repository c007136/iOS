//
//  Second2View.m
//  ScrollViewMasonry
//
//  Created by muyu on 2018/8/15.
//  Copyright © 2018年 muyu. All rights reserved.
//

#import "Second2View.h"
#import <Masonry.h>

@interface Second2View ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation Second2View

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        
        [self addSubview:self.scrollView];
        [self.scrollView addSubview:self.titleLabel];
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
        make.bottom.equalTo(self.titleLabel.superview).offset(-1000);
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
        _titleLabel.backgroundColor = [UIColor grayColor];
    }
    return _titleLabel;
}

@end
