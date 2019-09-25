//
//  UIColor+MCExtentions.m
//  PalmDoctorDR
//
//  Created by muyu on 16/7/14.
//  Copyright © 2016年 Andrew Shen. All rights reserved.
//

#import "UIColor+MCExtentions.h"


@implementation UIColor (MCExtentions)

+ (UIColor *)mc_colorWithValue:(NSUInteger)rgbValue
{
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0];
}

+ (UIColor *)mc_colorWithValue:(NSUInteger)rgbValue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alpha];
}

@end
