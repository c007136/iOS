//
//  TestObject.m
//  NSNotificationCenter
//
//  Created by muyu on 2017/5/18.
//  Copyright © 2017年 muyu. All rights reserved.
//

#import "TestObject.h"
#import "AObject.h"
#import "BObject.h"

@interface TestObject () <BDelegate>

@property (nonatomic, strong) AObject *aObject;
@property (nonatomic, strong) BObject *bObject;

@end

@implementation TestObject

- (id)init
{
    if (self = [super init]) {
    }
    return self;
}

- (void)fun1
{
    self.bObject = [[BObject alloc] init];
    self.bObject.delegate = self;
    self.aObject = [[AObject alloc] init];
    NSLog(@"%s, aObject is %@, self is %@", __func__, self.aObject, self);
}

- (void)fun2
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"test" object:nil];
    NSLog(@"%s, self is %@", __func__, self);
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
}

- (void)fun3
{
    
}

- (void)b_fun1
{
    @synchronized (self) {
        NSLog(@"%s, self is %@", __func__, self);
    }
}

@end
