//
//  CircleProgressView.h
//  CircleProgress
//
//  Created by miniu on 15/7/20.
//  Copyright (c) 2015年 miniu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleProgressView : UIView

@property (nonatomic, assign) CGFloat   angle;

// 有动画效果的设置
- (void)setEndAngle:(CGFloat)endAngle;

@end
