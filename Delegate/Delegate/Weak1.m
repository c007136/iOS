//
//  Weak1.m
//  Delegate
//
//  Created by miniu on 15/6/24.
//  Copyright (c) 2015年 miniu. All rights reserved.
//

#import "Weak1.h"

@implementation Weak1

- (void)delegateFun:(NSString *)text
{
    NSLog(@"delegateFun in weak1 %@.", text);
}

@end
