//
//  Person.m
//  NSCopying
//
//  Created by muyu on 2017/6/27.
//  Copyright © 2017年 muyu. All rights reserved.
//

#import "Person.h"

@implementation Person

- (id)copyWithZone:(NSZone *)zone
{
    Person *p = [[Person allocWithZone:zone] init];
    p.name = self.name;
    p.nick = self.nick;
    return p;
}

@end
