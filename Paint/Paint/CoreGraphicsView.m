//
//  CoreGraphicsView.m
//  Paint
//
//  Created by muyu on 2019/1/30.
//  Copyright © 2019 muyu. All rights reserved.
//

#import "CoreGraphicsView.h"

@implementation CoreGraphicsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    //[self drawRectangle];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [self drawSolidCircle:ctx];
    [self drawLine:ctx];
}

- (void)drawRectangle:(CGContextRef)ctx
{
    CGRect rectangle = CGRectMake(80, 400, 160, 60);
    CGContextAddRect(ctx, rectangle);
    CGContextSetFillColorWithColor(ctx, [UIColor lightGrayColor].CGColor);
    
    CGContextFillPath(ctx);
}

- (void)drawLine:(CGContextRef)ctx
{
    CGFloat lengths[] = {3.5,2};//先画2个点再画2个点
    CGContextSetLineDash(ctx, 0, lengths, 2);
    CGContextMoveToPoint(ctx, 20, 180); // 起点
    CGContextAddLineToPoint(ctx, self.frame.size.width-20, 180); //终点
    //CGContextSetRGBStrokeColor(ctx, 0, 1.0, 0, 1.0); // 颜色
    [[UIColor redColor] set]; // 两种设置颜色的方式都可以
    CGContextSetLineWidth(ctx, 1.0f); // 线的宽度
    CGContextStrokePath(ctx);
}

- (void)drawSolidCircle:(CGContextRef)ctx
{
    CGContextAddEllipseInRect(ctx, CGRectMake(20-5, 180-5, 10, 10));
    [[UIColor greenColor] set];
    CGContextFillPath(ctx);
}

@end
