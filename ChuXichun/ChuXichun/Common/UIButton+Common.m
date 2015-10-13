//
//  UIButton+Common.m
//  Miniu
//
//  Created by miniu on 15/7/8.
//
//  通用的按钮
//

#import "UIButton+Common.h"
#import "UIImage+ASCategory.h"
#import "UIColor+Extensions.h"

@implementation UIButton (Common)

- (id)initWithTitle:(NSString *)title
{
    return [self initWithTitle:title normalColor:ColorWithValue(0xfd5f3a) highlightedColor:ColorWithRGB(225, 61, 34)];
}

- (id)initWithTitle:(NSString *)title normalColor:(UIColor *)normalColor highlightedColor:(UIColor *)highlightedcolor
{
    self = [UIButton buttonWithType:UIButtonTypeCustom];
    if (self) {
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitle:title forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageFromColor:normalColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageFromColor:highlightedcolor] forState:UIControlStateHighlighted];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (id)initWithEnabledTitle:(NSString *)enabledTitle disabledTitle:(NSString *)disabledTitle
{
    self = [UIButton buttonWithType:UIButtonTypeCustom];
    if (self) {
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitle:enabledTitle forState:UIControlStateNormal];
        [self setTitle:disabledTitle forState:UIControlStateDisabled];
        [self setBackgroundImage:[UIImage imageFromColor:ColorWithValue(0xfd5f3a)] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageFromColor:ColorWithRGB(225, 61, 34)] forState:UIControlStateHighlighted];
        [self setBackgroundImage:[UIImage imageFromColor:ColorWithValue(0xbebebe)] forState:UIControlStateDisabled];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (id)initCancelButtonWithTitle:(NSString *)title
{
    self = [UIButton buttonWithType:UIButtonTypeCustom];
    if (self) {
        [self setTitleColor:[UIColor colorWithValue:0x9b9b9b] forState:UIControlStateNormal];
        [self setTitle:title forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageFromColor:[UIColor colorWithValue:0xf3f2f2]] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor grayColor].CGColor;
    }
    return self;
}

- (void)disableWithTitle:(NSString *)title
{
    self.enabled = NO;
    [self setTitle:title forState:UIControlStateDisabled];
}

- (void)highlightButton:(BOOL)isHighlighted
{
    [self performSelector:@selector(highlightSelector:) withObject:[NSNumber numberWithBool:isHighlighted] afterDelay:0];
}

- (void)highlightSelector:(NSNumber *)number
{
    [self setHighlighted:[number boolValue]];
}

@end
