//
//  RetainAndCopy.h
//  property
//
//  Created by miniu on 15/6/29.
//  Copyright (c) 2015年 miniu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RetainAndCopy : NSObject

@property (nonatomic, retain) NSString * stringRetain;
@property (nonatomic, copy) NSString * stringCopy;

@end
