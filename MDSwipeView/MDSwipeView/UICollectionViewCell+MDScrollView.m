//
//  UICollectionViewCell+MDScrollView.m
//  MDSwipeView
//
//  Created by muyu on 2016/12/2.
//  Copyright © 2016年 muyu. All rights reserved.
//

#import "UICollectionViewCell+MDScrollView.h"

@implementation UICollectionViewCell (MDScrollView)

- (UIScrollView *)md_scrollView
{
    UIScrollView *scrollView = nil;
    for (UIView *view in self.contentView.subviews)
    {
        if ([view isKindOfClass:[UIScrollView class]]) {
            scrollView = (UIScrollView *)view;
            break;
        }
    }
    return scrollView;
}

@end
