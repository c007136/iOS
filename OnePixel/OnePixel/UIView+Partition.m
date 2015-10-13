//
//  UIView+Partition.m
//  OnePixel
//
//  Created by miniu on 15/7/28.
//  Copyright (c) 2015年 miniu. All rights reserved.
//

#import "UIView+Partition.h"
#import "Header.h"
#import <objc/runtime.h>

@interface UIView ()

@property (nonatomic, weak) UIView     * topView;
@property (nonatomic, weak) UIView     * bottomView;
@property (nonatomic, weak) UIView     * centerView;

@end

#pragma mark - 运行时相关
static char kPartitionViewKeyTop;
static char kPartitionViewKeyBottom;
static char kPartitionViewKeyCenter;

@implementation UIView (Partition)

- (void)addPartitionViewWithMode:(NSUInteger)mode
{
    UIView * topPartition = [[UIView alloc] init];
    topPartition.backgroundColor = [UIColor redColor];
    //topPartition.frame = CGRectMake(0, 0, self.frame.size.width, ONEPIXEL_LINE_WIDTH);
    [self addSubview:topPartition];
    self.topView = topPartition;
    
    UIView * bottomPatition = [[UIView alloc] init];
    bottomPatition.backgroundColor = [UIColor redColor];
    //bottomPatition.frame = CGRectMake(0, self.frame.size.height-ONEPIXEL_LINE_WIDTH, self.frame.size.width, ONEPIXEL_LINE_WIDTH);
    [self addSubview:bottomPatition];
    self.bottomView = bottomPatition;
}

- (void)layoutPartitionView
{
    if (self.topView != nil) {
        self.topView.frame = CGRectMake(0, 0, self.frame.size.width, ONEPIXEL_LINE_WIDTH);
    }
    
    if (self.bottomView != nil) {
        self.bottomView.frame = CGRectMake(0, self.frame.size.height-ONEPIXEL_LINE_WIDTH, self.frame.size.width, ONEPIXEL_LINE_WIDTH);
    }
    
    if (self.centerView != nil) {
        NSLog(@"center view is layout");
    }
}

#pragma mark - getter and setter
- (void)setTopView:(UIView *)topView
{
    objc_setAssociatedObject(self, &kPartitionViewKeyTop, topView, OBJC_ASSOCIATION_ASSIGN);
}

- (UIView *)topView
{
    return objc_getAssociatedObject(self, &kPartitionViewKeyTop);
}

- (void)setBottomView:(UIView *)bottomView
{
    objc_setAssociatedObject(self, &kPartitionViewKeyBottom, bottomView, OBJC_ASSOCIATION_ASSIGN);
}

- (UIView *)bottomView
{
    return objc_getAssociatedObject(self, &kPartitionViewKeyBottom);
}

@end
