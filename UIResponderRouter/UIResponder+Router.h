//
//  UIResponder+Router.h
//  UIResponderRouter
//
//  Created by muyu on 2017/9/27.
//  Copyright © 2017年 muyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (Router)

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo;

@end
