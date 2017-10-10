//
//  UIResponder+Router.m
//  UIResponderRouter
//
//  Created by muyu on 2017/9/27.
//  Copyright © 2017年 muyu. All rights reserved.
//

#import "UIResponder+Router.h"

@implementation UIResponder (Router)

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    [[self nextResponder] routerEventWithName:eventName userInfo:userInfo];
}

@end
