//
//  TestProxyB.m
//  NSProxy
//
//  Created by muyu on 2018/12/27.
//  Copyright © 2018 muyu. All rights reserved.
//

#import "TestProxyB.h"

@interface TestProxyB ()

@property (nonatomic, strong) id target;

@end

@implementation TestProxyB

- (instancetype)initWithTarget:(id)target
{
    self = [super init];
    if (self) {
        _target = target;
    }
    return self;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    return [self.target methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    [anInvocation invokeWithTarget:self.target];
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    if (@selector(length) == aSelector) {
        return YES;
    }
    
    return [super respondsToSelector:aSelector];
}

@end
