//
//  BezierPathView.m
//  Paint
//
//  Created by muyu on 2019/1/30.
//  Copyright © 2019 muyu. All rights reserved.
//

#import "BezierPathView.h"

@implementation BezierPathView

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
    [self colorSetFill];
}

- (void)colorSetFill
{
    [[UIColor orangeColor] setFill];
    UIRectFill(CGRectMake(100, 100, 100, 100));
}

@end
