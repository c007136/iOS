//
//  Person.m
//  AccessorInInit
//
//  Created by muyu on 2018/11/29.
//  Copyright © 2018 muyu. All rights reserved.
//

#import "Person.h"

@implementation Person

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.lastName = @"";
    }
    return self;
}

- (void)setLastName:(NSString*)lastName
{
    NSLog(@"类名与方法名：%s（在第%d行），描述：%@", __PRETTY_FUNCTION__, __LINE__, @"根本不会调用这个方法");
    _lastName = @"炎黄";
}

@end
