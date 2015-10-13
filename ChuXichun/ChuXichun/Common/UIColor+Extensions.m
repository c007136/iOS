//
//  UIColor+Extensions.m
//  Miniu
//
//  Created by miniu on 15/7/28.
//
//

#import "UIColor+Extensions.h"

@implementation UIColor (Extensions)

+ (UIColor *)separatorColor
{
    return ColorWithRGB(228, 228, 228);
}

+ (UIColor *)viewBackgroundColor
{
    return [UIColor colorWithValue:0xF4F3F8];
}

+ (UIColor *)defaultDarkTextColor
{
    return [UIColor colorWithValue:0x2b2b2b];
}

+ (UIColor *)defaultLightTextColor
{
    return [UIColor colorWithValue:0x8b8b8b];
}

+ (UIColor *)normalButtonBlueColor
{
    return [UIColor colorWithValue:0x418ff1];
}

+ (UIColor *)highlightedButtonBlueColor
{
    return [UIColor colorWithValue:0x2069c3];
}

+ (UIColor *)normalButtonRedColor
{
    return [UIColor colorWithValue:0xfd5f3a];
}

+ (UIColor *)highlightedButtonRedColor
{
    return ColorWithRGB(225, 61, 34);
}

+ (UIColor *)stockRedColor
{
    return [UIColor colorWithValue:0xbd0b07];
}

+ (UIColor *)stockGreenColor
{
    return [UIColor colorWithValue:0x068f63];
}

+ (UIColor *)colorWithValue:(NSUInteger)rgbValue
{
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0];
}

@end
