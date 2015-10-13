//
//  CircleProgressView.m
//  CircleProgress
//
//  Created by miniu on 15/7/20.
//  Copyright (c) 2015年 miniu. All rights reserved.
//

#import "CircleProgressView.h"

const CGFloat LineWidth = 6.0f;

@implementation CircleProgressView

// todo muyu Y?
+ (Class)layerClass
{
    return [CAShapeLayer class];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat radius = CGRectGetWidth(self.frame)/2-3;
    
    CAShapeLayer * layer = (CAShapeLayer *)self.layer;
    layer.fillColor = nil;
    layer.strokeColor = [UIColor darkGrayColor].CGColor;
    layer.lineWidth = LineWidth;
    layer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2) radius:radius startAngle:M_PI_2 endAngle:M_PI_2 + (M_PI * 2) clockwise:YES].CGPath;
    
    CAShapeLayer * colorPathLayer = [CAShapeLayer layer];
    colorPathLayer.fillColor = nil;
    colorPathLayer.lineCap = kCALineCapRound;
    colorPathLayer.strokeColor = [UIColor redColor].CGColor;
    colorPathLayer.lineWidth = LineWidth;
    colorPathLayer.strokeEnd = self.angle / 360.0f;
    colorPathLayer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2) radius:radius startAngle:-M_PI_2 endAngle:(M_PI * 2)-M_PI_2 clockwise:YES].CGPath;
    
    [layer addSublayer:colorPathLayer];
}

// todo muyu 需研究动画是怎么实现的
- (void)setEndAngle:(CGFloat)endAngle
{
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @(0);
    animation.toValue = @(endAngle/360.0f);
    animation.duration = 1.0f;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    CAShapeLayer * colorSublayer = [self.layer.sublayers lastObject];
    [colorSublayer addAnimation:animation forKey:nil];
    
}

#pragma mark - getter and setter
- (void)setAngle:(CGFloat)angle
{
    _angle = angle;
    
    [self setNeedsLayout];
}


@end
