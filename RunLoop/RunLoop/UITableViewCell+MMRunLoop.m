//
//  UITableViewCell+MMRunLoop.m
//  RunLoop
//
//  Created by muyu on 2018/5/9.
//  Copyright © 2018年 muyu. All rights reserved.
//

#import "UITableViewCell+MMRunLoop.h"
#import <objc/runtime.h>

@implementation UITableViewCell (MMRunLoop)

//@dynamic currentIndexPath;

- (NSIndexPath *)currentIndexPath
{
    NSIndexPath *indexPath = objc_getAssociatedObject(self, @selector(currentIndexPath));
    return indexPath;
}

- (void)setCurrentIndexPath:(NSIndexPath *)currentIndexPath
{
    objc_setAssociatedObject(self, @selector(currentIndexPath), currentIndexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
