//
//  UIViewController+Track.m
//  HookForTrack
//
//  Created by muyu on 2017/3/13.
//  Copyright © 2017年 muyu. All rights reserved.
//

#import "UIViewController+Track.h"
#import "WHookUtility.h"

@implementation UIViewController (Track)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL originalSelector = @selector(viewDidAppear:);
        SEL swizzledSelector = @selector(swizzledViewDidAppear:);
        [WHookUtility swizzlingInClass:[self class] originalSelector:originalSelector swizzledSelector:swizzledSelector];
        
        SEL originalSelector2 = @selector(viewDidDisappear:);
        SEL swizzledSelector2 = @selector(swizzledViewDidDisapper:);
        [WHookUtility swizzlingInClass:[self class] originalSelector:originalSelector2 swizzledSelector:swizzledSelector2];
    });
}

#pragma mark - swizzling method

- (void)swizzledViewDidAppear:(BOOL)animated
{
    NSLog(@"swizzledViewDidAppear class is %@", [self class]);
    [self swizzledViewDidAppear:animated];
}

- (void)swizzledViewDidDisapper:(BOOL)animated
{
    NSLog(@"swizzledViewDidDisapper class is %@", [self class]);
    [self swizzledViewDidDisapper:animated];
}

@end
