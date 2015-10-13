//
//  UIColor+Extensions.h
//  Miniu
//
//  Created by miniu on 15/7/28.
//
//

#import <UIKit/UIKit.h>

// color
#define ColorWithValue(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define ColorWithRGB(r,g,b)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define ColorWithRGBA(r,g,b,a)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]


@interface UIColor (Extensions)

// 默认的分割线颜色
+ (UIColor *)separatorColor;

// 默认的背景颜色
+ (UIColor *)viewBackgroundColor;

// 默认的深色/浅色文字颜色
+ (UIColor *)defaultDarkTextColor;
+ (UIColor *)defaultLightTextColor;

// 按钮使用的蓝色
+ (UIColor *)normalButtonBlueColor;
+ (UIColor *)highlightedButtonBlueColor;
+ (UIColor *)normalButtonRedColor;
+ (UIColor *)highlightedButtonRedColor;

// 股票的红色和绿色
+ (UIColor *)stockRedColor;
+ (UIColor *)stockGreenColor;

+ (UIColor *)colorWithValue:(NSUInteger)rgbValue;

@end
