//
//  Test.m
//  AccessorInInit
//
//  Created by miniu on 15/7/25.
//  Copyright (c) 2015年 miniu. All rights reserved.
//

#import "Test.h"

@implementation Test

- (id)init
{
    self = [super init];
    if (self) {
        _str = [NSString stringWithFormat:@"I am string"];
        _str1 = [NSString stringWithFormat:@"I am string_1"];
    }
    return self;
}

//- (void)setStr:(NSString *)str
//{
//    NSString * text = [NSString stringWithFormat:@"%@", str];
//    _str = text;
//}

- (void)dealloc
{
    NSLog(@"dealloc in Test");
    
    // 在arc环境下，self.str又被赋值了
    //self.str = @"dealloc in test1";
    //NSLog(@"str is %@", self.str);
    
    [_str release];
    _str = nil;
    [_str1 release];
    _str1 = nil;
    
    [super dealloc];
}

@end





@implementation Test1

//- (void)setStr:(NSString *)str
//{
////    NSString * append = [self.str1 stringByAppendingString:@" append"];
////    NSLog(@"append is %@", append);
//    
//    NSString * text = [NSString stringWithFormat:@"[%@]", str];
//    [super setStr:text];
//}

//- (void)setStr1:(NSString *)str1
//{
//    NSString * text = [NSString stringWithFormat:@"[%@]", str1];
//    [super setStr1:text];
//}

- (void)dealloc
{
//    [self.str release];
//    self.str = nil;
//    [self.str1 release];
//    self.str1 = nil;
    
    NSLog(@"dealloc in Test1");
    [super dealloc];
}

@end