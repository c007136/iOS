//
//  UIImage+MCColor.m
//  PalmDoctorDR
//
//  Created by muyu on 16/7/15.
//  Copyright © 2016年 Andrew Shen. All rights reserved.
//

#import "UIImage+MCColor.h"

@implementation UIImage (MCColor)

+ (UIImage *)mc_imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
