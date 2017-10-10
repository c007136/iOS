//
//  AView.m
//  UIResponderRouter
//
//  Created by muyu on 2017/9/27.
//  Copyright © 2017年 muyu. All rights reserved.
//

#import "AView.h"
#import "UIResponder+Router.h"

NSString *const AViewButtonTapped = @"AViewButtonTapped";

@interface AView ()

@property (nonatomic, strong) UIButton *aButton;

@end

@implementation AView

#pragma mark - lifecycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        
        [self addSubview:self.aButton];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.aButton.frame = CGRectMake(12, 5, self.frame.size.width-24, self.frame.size.height-10);
}

#pragma mark - action

- (void)onAButtonTappedAction
{
    NSDictionary *dict = @{
                           @"key" : @"value"
                           };
    [self routerEventWithName:AViewButtonTapped userInfo:dict];
}

#pragma mark - getter and setter

- (UIButton *)aButton
{
    if (_aButton == nil) {
        _aButton = [[UIButton alloc] init];
        _aButton.backgroundColor = [UIColor orangeColor];
        _aButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [_aButton setTitle:@"点我看看" forState:UIControlStateNormal];
        [_aButton addTarget:self action:@selector(onAButtonTappedAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _aButton;
}

@end
