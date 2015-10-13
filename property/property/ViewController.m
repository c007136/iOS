//
//  ViewController.m
//  property
//
//  Created by miniu on 15/6/29.
//  Copyright (c) 2015年 miniu. All rights reserved.
//
//  readonly     can't be changed outside and can be changed inside
//  readwrite    can be changed outside and can be changed inside
//
//  retain  mutableString之类的指向同一内存
//  copy    mutableString之类的指向新内存
//
//  strong  拥有，相当于retain
//  weak    不拥有
//
//  assign  用于基础类型
//  weak    对象消失后指针为nil
//
//  retain copy assign strong weak readonly readwrite nonatomic atomic学习
//
//  野指针错误形式在Xcode中通常表现为：Thread 1：EXC_BAD_ACCESS(code=EXC_I386_GPFLT)错误。
//  因为你访问了一块已经不属于你的内存
//  参考链接：
//  http://www.cnblogs.com/kenshincui/p/3870325.html
//  http://blog.csdn.net/guchengluoye/article/details/7623622
//  http://blog.csdn.net/hitwhylz/article/details/18838565

#import "ViewController.h"
#import "Car.h"
#import "Person.h"
#import "RetainAndCopy.h"

@interface ViewController ()

@end


@implementation ViewController



- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self retainAndCopy];
    
    // 初步了解
    //[self simpleToUnderstand];
    //[self moreToUnderstand];
}

- (void)retainAndCopy
{
    RetainAndCopy * rac = [[RetainAndCopy alloc] init];
    NSMutableString * string = [[NSMutableString alloc] initWithString:@"String"];
    
    [rac setStringRetain:string];
    [rac setStringCopy:string];
    NSLog(@"rac retain string is %@ and copy string is %@", rac.stringRetain, rac.stringCopy);
    
    [string appendString:@"_String"];
    NSLog(@"rac retain string is %@ and copy string is %@", rac.stringRetain, rac.stringCopy);
}

- (void)moreToUnderstand
{
    Person * p = [[Person alloc] init];
    p.name = @"muyu";
    
    [self getCar:p];
    
    [[p getCar] run];
    
    [p release];
    p = nil;
}

- (void)simpleToUnderstand
{
    Person * p = [[Person alloc] init];
    p.name = @"muyu";
    p.age = 30;
    NSLog(@"person is retaincount = %lu", [p retainCount]);
    
    //[p retain];
    //NSLog(@"person is retaincount = %lu", [p retainCount]);
    
    [p release];
    NSLog(@"person is retaincount = %lu", [p retainCount]);
    //p = nil;
    
    // 野指针错误，访问已经不属于你的指针
    //[p release];
}

#pragma - private
- (void)getCar:(Person * )p
{
    Car * car1 = [[Car alloc] init];
    car1.number = @"88888";
    
    //p.car = car1;
    [p setCar:car1];
    NSLog(@"p's retain count is %lu car1's retain count is %lu", [p retainCount], car1.retainCount);
    
    Car * car2 = [[Car alloc] init];
    car2.number = @"66666";
    
    [car1 release];
    car1 = nil;
    
    [car2 release];
    car2 = nil;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
