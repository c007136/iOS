//
//  ViewController.m
//  CALayer
//
//  Created by miniu on 15/8/28.
//  Copyright (c) 2015年 miniu. All rights reserved.
//
//  学习Layer做绘画
//
//  masksToBounds和shadow冲突
//  http://stackoverflow.com/questions/3690972/why-maskstobounds-yes-prevents-calayer-shadow
//
//  CGContextSaveGState和CGContextRestoreGState的作用
//  用于保存上下文的状态（context），并在之后恢复状态
//  http://ioser.cc/2014/01/12/guan-yu-cgcontextsavegstate-slash-cgcontextrestoregstate-he-uigraphicspushcontext-slash-uigraphicspopcontext/
//
//  pattern create
//  http://southpeak.github.io/blog/2014/12/05/quartz-2dbian-cheng-zhi-nan-zhi-liu-:mo-shi-pattern/

#import "ViewController.h"

@interface ViewController ()

@end

static inline double radians (double degrees) { return degrees * M_PI/180; }


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //[self addSubLayer];
    [self addCustomLayer];
}

#pragma mark -
void MyDrawColoredPattern (void *info, CGContextRef ctx)
{
    CGColorRef dotColor = [UIColor colorWithHue:0 saturation:0 brightness:0.07 alpha:1.0].CGColor;
    CGColorRef shadowColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.1].CGColor;
    
    CGContextSetFillColorWithColor(ctx, dotColor);
    CGContextSetShadowWithColor(ctx, CGSizeMake(0, 1), 1, shadowColor);
    
    CGContextAddArc(ctx, 3, 3, 4, 0, radians(360), 0);
    CGContextFillPath(ctx);
    
    CGContextAddArc(ctx, 16, 16, 4, 0, radians(360), 0);
    CGContextFillPath(ctx);
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    CGColorRef bgColor = [UIColor colorWithHue:0 saturation:0 brightness:0.15 alpha:1.0].CGColor;
    CGContextSetFillColorWithColor(ctx, bgColor);
    CGContextFillRect(ctx, layer.bounds);
    
    static const CGPatternCallbacks callbacks = {0, &MyDrawColoredPattern, NULL};
    
    CGContextSaveGState(ctx);
    CGColorSpaceRef patternSpace = CGColorSpaceCreatePattern(NULL);
    CGContextSetFillColorSpace(ctx, patternSpace);
    CGColorSpaceRelease(patternSpace);
    
    CGPatternRef pattern = CGPatternCreate(NULL, layer.bounds, CGAffineTransformIdentity, 24, 24, kCGPatternTilingConstantSpacing, true, &callbacks);
    
    CGFloat alpha = 1.0;
    CGContextSetFillPattern(ctx, pattern, &alpha);
    CGPatternRelease(pattern);
    
    CGContextFillRect(ctx, layer.bounds);
    CGContextRestoreGState(ctx);
}

#pragma mark -
- (void)addSubLayer
{
    CALayer * sublayer = [CALayer layer];
    sublayer.backgroundColor = [UIColor purpleColor].CGColor;
    sublayer.shadowOffset = CGSizeMake(0, 3);
    sublayer.shadowRadius = 5.0f;
    sublayer.shadowColor = [UIColor redColor].CGColor;
    sublayer.shadowOpacity = 0.8;
    sublayer.frame = CGRectMake(30, 30, 128, 192);
    [self.view.layer addSublayer:sublayer];
}

- (void)addCustomLayer
{
    CALayer * customLayer = [CALayer layer];
    customLayer.delegate = self;
    customLayer.backgroundColor = [UIColor greenColor].CGColor;
    customLayer.frame = CGRectMake(50, 50, 280, 200);
//    customLayer.shadowOffset = CGSizeMake(0, 2);
//    customLayer.shadowRadius = 5.0f;
//    customLayer.shadowColor = [UIColor blackColor].CGColor;
//    customLayer.shadowOpacity = 0.8;
    customLayer.cornerRadius = 10.0;
    customLayer.borderColor = [UIColor blackColor].CGColor;
    customLayer.borderWidth = 0.3;
    customLayer.masksToBounds = YES;  // 不注释shadow没法显示
    [self.view.layer addSublayer:customLayer];
    [customLayer setNeedsDisplay];
}


@end
