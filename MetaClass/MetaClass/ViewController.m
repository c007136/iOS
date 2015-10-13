//
//  ViewController.m
//  MetaClass
//
//  Created by miniu on 15/7/6.
//  Copyright (c) 2015年 miniu. All rights reserved.
//
//  meta class学习
//  http://www.cocoawithlove.com/2010/01/what-is-meta-class-in-objective-c.html
//  http://blog.csdn.net/weiwangchao_/article/details/7367073
//  http://www.cocoachina.com/industry/20131210/7508.html

//  谁TMD能告诉我 什么是meta class
//  http://blog.devtang.com/blog/2013/10/15/objective-c-object-model/

#import "ViewController.h"

// Father and Child
//////////////////////////////////////////////////////////////////////

@interface Father : NSObject

@end

@implementation Father

@end

@interface Child : Father

@end

@implementation Child


@end


//////////////////////////////////////////////////////////////////////

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Child * child = [[Child alloc] init];
    
    NSString * string = [NSString stringWithFormat:@"I am a string"];//@"I am a string";
    NSLog(@"class of string is %@ and class of NSString is %@", [string class], [NSString class]);
    
    NSMutableString * mString = [NSMutableString stringWithFormat:@"I am a mutable string"];
    NSLog(@"class of mstring is %@ and class of NSMutableString is %@", [mString class], [NSMutableString class]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
