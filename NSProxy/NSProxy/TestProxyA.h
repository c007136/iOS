//
//  TestProxyA.h
//  NSProxy
//
//  Created by muyu on 2018/12/27.
//  Copyright © 2018 muyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestProxyA : NSProxy

- (instancetype)initWithTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
