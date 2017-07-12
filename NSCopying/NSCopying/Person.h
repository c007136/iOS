//
//  Person.h
//  NSCopying
//
//  Created by muyu on 2017/6/27.
//  Copyright © 2017年 muyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject <NSCopying>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *nick;

@end
