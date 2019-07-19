//
//  ViewController.m
//  Autolayout4
//
//  Created by miniu on 15/9/12.
//  Copyright (c) 2015年 miniu. All rights reserved.
//

#define kWindowWidth CGRectGetWidth([UIScreen mainScreen].bounds)
#define kWindowHeight CGRectGetHeight([UIScreen mainScreen].bounds)

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *contentView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView addSubview:self.contentView];
    
    NSDictionary *views = @{@"contentView":self.contentView};
    NSDictionary *metrics = @{@"height" : @(900), @"width" : @(kWindowWidth)};
    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[contentView(height)]|" options:kNilOptions metrics:metrics views:views]];
    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[contentView(width)]|" options:kNilOptions metrics:metrics views:views]];
}


@end
