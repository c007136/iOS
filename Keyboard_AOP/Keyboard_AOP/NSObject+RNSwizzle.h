//
//  NSObject+RNSwizzle.h
//  MethodSwizzling
//
//  Created by muyu on 16/7/5.
//  Copyright © 2016年 muyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (RNSwizzle)

+ (void)swizzleSelector:(SEL)origSelector withSelector:(SEL)newSelector;

@end
