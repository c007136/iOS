//
//  ViewController.m
//  AutoLayout3
//
//  Created by miniu on 15/6/25.
//  Copyright (c) 2015年 miniu. All rights reserved.
//
//  AutoLayout代码实现
//
//  item1.attribute1 = multiplier * item2.attribute2 + constant
//
//
//  参考链接：
//  http://blog.csdn.net/hello_hwc/article/details/44003861
//  https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/AutolayoutPG/AutoLayoutConcepts/AutoLayoutConcepts.html#//apple_ref/doc/uid/TP40010853-CH14-SW1
//  https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/AutolayoutPG/VisualFormatLanguage/VisualFormatLanguage.html
//  http://www.cnblogs.com/wupei/p/4150626.html
//  http://chun.tips/blog/2014/10/27/wei-iphone6she-ji-zi-gua-ying-bu-ju-(chun-dai-ma-shi-xian-)/

//  "You cannot set a constraint to cross the view hierarchy if the hierarchy includes a view that sets the frames of subviews manually in a custom implementation for the layoutSubviews method on UIView (or the layout method on NSView). It’s also not possible to cross any views that have a bounds transform (such as a scroll view). You can think of such views as barriers—there’s an inside world and an outside world, but the inside cannot be connected to the outside by constraints."
//  何解？？？

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UILabel * label;
@property (nonatomic, strong) UIButton * button;

@end

@implementation ViewController

- (id)init
{
    self = [super init];
    if (self) {
        // 最好不要调用self.view
        // 否则会先调用viewDidLoad
        //self.view.backgroundColor = [UIColor redColor];
        //NSLog(@"......");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.label];
    [self.view addSubview:self.button];
}

- (void)viewWillAppear:(BOOL)animated
{
    //self.label.frame = CGRectMake(30, 30, 100, 100);
    //self.button.frame = CGRectMake(200, 200, 100, 100);
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    // label constraint
    [self.label setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint * label_h_c = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.label attribute:NSLayoutAttributeRight multiplier:1.0 constant:30];
    
    NSLayoutConstraint * label_v_c = [NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:30];
    
    NSLayoutConstraint * label_e_w = [NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:100];
    
    NSLayoutConstraint * label_e_h = [NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:100];
    [self.view addConstraints:@[label_h_c, label_v_c, label_e_w, label_e_h]];
    
    // button constraint VFL语言
    [self.button setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSArray * button_w_c = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[button(==100)]" options:0 metrics:nil views:@{@"button":self.button}];
    NSArray * button_h_c = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[button(==100)]" options:0 metrics:nil views:@{@"button":self.button}];
    [self.view addConstraints:button_w_c];
    [self.view addConstraints:button_h_c];
    
    NSArray * button_l_c = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-h-[button]" options:0 metrics:@{@"h":@(40)} views:@{@"button":self.button}];
    NSArray * button_t_c = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-v-[button]" options:0 metrics:@{@"v":@(140)} views:@{@"button":self.button}];
    [self.view addConstraints:button_l_c];
    [self.view addConstraints:button_t_c];
}

#pragma mark - getter and setter
- (UILabel *)label
{
    if (_label == nil) {
        _label = [[UILabel alloc] init];
        _label.text = @"I am Label";
        _label.backgroundColor = [UIColor purpleColor];
        _label.textAlignment = NSTextAlignmentCenter;
    }
    
    return _label;
}

- (UIButton *)button
{
    if (_button == nil) {
        _button = [[UIButton alloc] init];
        _button.backgroundColor = [UIColor brownColor];
        [_button setTitle:@"I am Button" forState:UIControlStateNormal];
    }
    
    return _button;
}

@end
