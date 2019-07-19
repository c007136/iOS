//
//  Weak2.m
//  Delegate
//
//  Created by miniu on 15/6/24.
//  Copyright (c) 2015年 miniu. All rights reserved.
//

#import "Weak2.h"

@implementation Weak2

- (void)delegateFun:(NSString *)text
{
    NSLog(@"delegateFun in weak2 %@.", text);
}

@end
