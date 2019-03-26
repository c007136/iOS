//
//  TestProxyA.m
//  NSProxy
//
//  Created by muyu on 2018/12/27.
//  Copyright © 2018 muyu. All rights reserved.
//

#import "TestProxyA.h"

@interface TestProxyA ()

@property (nonatomic, strong) id target;

@end

@implementation TestProxyA

- (instancetype)initWithTarget:(id)target
{
    _target = target;
    return self;
}

- (nullable NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    return [self.target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    [invocation invokeWithTarget:self.target];
}

@end
