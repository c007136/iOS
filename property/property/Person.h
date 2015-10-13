//
//  Person.h
//  property
//
//  Created by miniu on 15/6/29.
//  Copyright (c) 2015年 miniu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Car;

@interface Person : NSObject
{
    Car * _car;
}

@property (nonatomic, copy) NSString * name;
@property (nonatomic, assign) NSInteger age;


- (void)setCar:(Car *)car;
- (Car *)getCar;

@end
