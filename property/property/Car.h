//
//  Car.h
//  property
//
//  Created by miniu on 15/6/29.
//  Copyright (c) 2015年 miniu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Car : NSObject <NSCopying>

@property (nonatomic, copy) NSString * number;

- (void)run;

@end
