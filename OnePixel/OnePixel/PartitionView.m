//
//  PartitionView.m
//  OnePixel
//
//  Created by miniu on 15/7/28.
//  Copyright (c) 2015年 miniu. All rights reserved.
//

#import "PartitionView.h"
#import "Header.h"


@implementation PartitionView

- (void)drawRect:(CGRect)rect
{
    UIColor * partitionColor = (self.partitionColor == nil) ? [UIColor redColor] : self.partitionColor;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, ONEPIXEL_LINE_WIDTH);
    
    CGFloat pixelAdjustOffset = 0;
    if (((int)(ONEPIXEL_LINE_WIDTH*[UIScreen mainScreen].scale) + 1) % 2 == 0) {
        pixelAdjustOffset = ONEPIXEL_LINE_ADJUST_OFFSET;
    }
    
    NSLog(@"scale is %lf....offset is %lf xxx %lf", [UIScreen mainScreen].scale, pixelAdjustOffset, ONEPIXEL_LINE_WIDTH*[UIScreen mainScreen].scale);
    CGFloat height = 3.0 - pixelAdjustOffset;
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, height);
    CGContextAddLineToPoint(context, self.frame.size.width, height);
    
    CGContextMoveToPoint(context, 0, self.frame.size.height-pixelAdjustOffset);
    CGContextAddLineToPoint(context, self.frame.size.width, self.frame.size.height-pixelAdjustOffset);
    
    //CGContextSetStrokeColorWithColor(context, partitionColor.CGColor);
    CGContextSetRGBStrokeColor(context, 1.0, 0, 0, 1.0);
    CGContextStrokePath(context);
}



@end
