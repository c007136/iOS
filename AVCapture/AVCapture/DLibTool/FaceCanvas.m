//
//  FaceCanvas.m
//  AVCapture
//
//  Created by muyu on 2019/9/9.
//  Copyright © 2019 muyu. All rights reserved.
//

#import "FaceCanvas.h"

@implementation FaceCanvas

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    if (self.boundsArray.count == 0) {
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetRGBStrokeColor(context, 1, 0, 0, 1.0);
    CGContextSetLineWidth(context, 1);
    
    for (NSValue *value in self.boundsArray)
    {
        CGRect rect = value.CGRectValue;
        CGContextStrokeRect(context, rect);
    }
}

@end
