//
//  ComponentBlock.m
//  Block
//
//  Created by miniu on 15/6/23.
//  Copyright (c) 2015年 miniu. All rights reserved.
//

#import "ComponentBlock.h"

@implementation ComponentBlock

- (void)setBlock:(BlockLearn)block
{
    _block = block;
}

- (void)run
{
    _block(@"I am block.");
}

- (void)runWithBlock:(BlockStudy)block
{
    NSLog(@"I am in component.");
    
    NSString * stringTest = @"StringText";
    NSDictionary * dictionaryTest = @{@"aa":@"AA", @"bb":@"BB"};
    
    if (block) {
        block(stringTest, dictionaryTest);
    }
}

@end
