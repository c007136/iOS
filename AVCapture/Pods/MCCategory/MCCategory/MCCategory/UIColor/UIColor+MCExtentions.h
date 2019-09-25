//
//  UIColor+MCExtentions.h
//  PalmDoctorDR
//
//  Created by muyu on 16/7/14.
//  Copyright © 2016年 Andrew Shen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (MCExtentions)

+ (UIColor *)mc_colorWithValue:(NSUInteger)rgbValue;

+ (UIColor *)mc_colorWithValue:(NSUInteger)rgbValue alpha:(CGFloat)alpha;

@end
