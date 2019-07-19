//
//  UIButton+Common.h
//  Miniu
//
//  Created by miniu on 15/7/8.
//
//

#import <UIKit/UIKit.h>

@interface UIButton (Common)

- (id)initWithTitle:(NSString *)title;
- (id)initWithTitle:(NSString *)title normalColor:(UIColor *)normalColor highlightedColor:(UIColor *)color;
- (id)initWithEnabledTitle:(NSString *)enabledTitle disabledTitle:(NSString *)disabledTitle;
- (id)initCancelButtonWithTitle:(NSString *)title;

- (void)disableWithTitle:(NSString *)title;

- (void)highlightButton:(BOOL)isHighlighted;

@end
