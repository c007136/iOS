//
//  Component.m
//  Callback
//
//  Created by miniu on 15/6/23.
//  Copyright (c) 2015年 miniu. All rights reserved.
//

#import "Component.h"

@implementation Component

- (void)runByBlock:(BlockMethod)block
{
    NSDictionary * dictionary = @{@"aBlock":@"AA", @"bBlock":@"BB"};
    if (block) {
        block(dictionary);
    }
}

- (void)runByNotification
{
    NSDictionary * dictionary = @{@"aNotification":@"AA", @"bNotification":@"BB"};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"fNotification" object:dictionary];
}

- (void)runByPerformSelector:(NSDictionary *)dictionary
{
    NSLog(@"### dictionary post by performSelector: %@ ###", dictionary);
}

- (void)runByFunctionPointer:(NSDictionary *)dictionary
{
    NSLog(@"### dictionary post by functionPointer: %@ ###", dictionary);
}

- (void)runByDelegate
{
    if ( _delegate != nil && [_delegate respondsToSelector:@selector(callback:)] ) {
        NSDictionary * dictionary = @{@"aDelegate":@"AA", @"bDelegate":@"BB"};
        [_delegate callback:dictionary];
    }
}

- (void)runByIMP
{
    NSDictionary * dictionary = @{@"aIMP":@"AA", @"bIMP":@"BB"};
    NSLog(@"### dictionary post by IMP: %@ ###", dictionary);
}

- (void)runBySEL
{
    
}

// 参考链接：
// http://www.cnblogs.com/ludashi/p/3918703.html
// todo muyu 如何去掉警告
- (void)runByTarget:(id)target action:(SEL)selector
{
    NSDictionary * dictionary = @{@"aTargetAction":@"AA", @"bTargetAction":@"BB"};
    if ( [target respondsToSelector:selector] ) {
        [target performSelector:selector withObject:dictionary];
    }
}

@end
