//
//  ChenPerson.m
//  AccessorInInit
//
//  Created by muyu on 2018/11/29.
//  Copyright © 2018 muyu. All rights reserved.
//

#import "ChenPerson.h"

@implementation ChenPerson

@synthesize lastName = _lastName;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.lastName = @"Chen";
    }
    return self;
}

- (void)setLastName:(NSString*)lastName
{
    _lastName = lastName;
    NSLog(@"类名与方法名：%s（在第%d行），描述：%@", __PRETTY_FUNCTION__, __LINE__, @"会调用这个方法,想一下为什么？");
}

@end
