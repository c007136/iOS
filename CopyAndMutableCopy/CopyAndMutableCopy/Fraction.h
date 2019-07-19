//
//  Fraction.h
//  CopyAndMutableCopy
//
//  Created by miniu on 15/6/29.
//  Copyright (c) 2015年 miniu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fraction : NSObject <NSCopying, NSMutableCopying>
{
}

@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;

@end
