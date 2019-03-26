//
//  Farther.m
//  AccessorInInit
//
//  Created by muyu on 2018/11/29.
//  Copyright © 2018 muyu. All rights reserved.
//

#import "Farther.h"

@implementation Father

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"init in Father");
        
        // 本质是因为在child还没初始化的时候，就执行了setter方法
        // 而这个时候self.childString = nil
        // 于是崩溃
        self.fatherString = @"FatherString";
    }
    return self;
}

@end

//
//  Child
//
@implementation Child

- (id)init
{
    self = [super init];
    if (self) {
        NSLog(@"init in Child");
        self.childString = @"I am really ChildString";
        self.fatherString = @"ChildString";
    }
    return self;
}

- (void)setFatherString:(NSString *)fatherString
{
    [super setFatherString:fatherString];
    
    NSString * string = [NSString stringWithString:self.childString];
    NSLog(@"string in Child is %@", string);
}

@end
