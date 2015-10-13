//
//  Person.m
//  property
//
//  Created by miniu on 15/6/29.
//  Copyright (c) 2015年 miniu. All rights reserved.
//

#import "Person.h"
#import "Car.h"

@implementation Person

- (void)dealloc
{
    NSLog(@"person (%@) dealloc.", _name);
    [_car release];  // 谁创建，谁释放
    [super dealloc];
}

- (void)setCar:(Car *)car
{
    if (_car != car) {
        // retain的写法
        //[_car release];
        //_car = [car retain];
        
        // copy的写法
        _car = [car copy];
    }
}

- (Car *)getCar
{
    return _car;
}

@end
