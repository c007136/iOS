//
//  ViewController.m
//  CopyAndMutableCopy
//
//  Created by miniu on 15/6/29.
//  Copyright (c) 2015年 miniu. All rights reserved.
//
//  copy和mutableCopy学习
//
//  参考链接：
//  http://blog.csdn.net/chengwuli125/article/details/13093687
//  http://blog.csdn.net/growinggiant/article/details/45541483

#import "ViewController.h"
#import "Fraction.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self learnPointer];
    //[self learnCopyOfString];
    [self learnCopyOfMutableString];
    //[self learnCopyOfArray];
    //[self learnDeepCopyOfArray];
    //[self learnCopyAndMutableCopy];
}

- (void)learnPointer
{
    int var = 20;
    int * p = nil;
    
    // p为指针p指向的值，&p为指向指针p的值
    NSLog(@"pointer of var is : %p and pointer of p is : %p--%p", &var, p, &p);
    
    p = &var;  // 表示指针p指向的值等于&var
    NSLog(@"pointer of var is : %p and pointer of p is : %p--%p", &var, p, &p);
}

- (void)learnCopyOfString
{
    // string和stringCopy指向的内存是一样
    // string和stringCopy的retainCount=2
    // stringMutableCopy指向的内存为新内存
    // stringMutableCopy的retainCount=1
    // 简单地说 copy为浅拷贝，mutableCopy为深拷贝
    NSString * string = [NSString stringWithFormat:@"test"];//@"test";
    NSString * stringCopy = [string copy];
    NSString * stringMutableCopy = [string mutableCopy];
    NSLog(@"string is: %@---%p---%p---%lu and stringCopy is: %@---%p---%p---%lu and stringMutableCopy is: %@---%p---%p---%lu", string, string, &string, [string retainCount], stringCopy, stringCopy, &stringCopy, [stringCopy retainCount], stringMutableCopy, stringMutableCopy, &stringMutableCopy, [stringMutableCopy retainCount]);
    
    // release后，retainCount=1
    // 合情合理
    [string release];
    NSLog(@"after of string release retainCount is %lu---%lu", [string retainCount], [stringCopy retainCount]);
}

- (void)learnCopyOfMutableString
{
    // string、stringCopy、stringMutableCopy指向的内存都不一样了。
    // retainCount=1
    NSMutableString * string = [NSMutableString stringWithFormat:@"mutable_string"]; //@"mutable_string"
    NSMutableString * stringCopy = [string copy];
    NSMutableString * stringMutableCopy = [string mutableCopy];
    NSLog(@"string is: %@---%p---%p---%lu and stringCopy is: %@---%p---%p---%lu and stringMutableCopy is: %@---%p---%p---%lu", string, string, &string, [string retainCount], stringCopy, stringCopy, &stringCopy, [stringCopy retainCount], stringMutableCopy, stringMutableCopy, &stringMutableCopy, [stringMutableCopy retainCount]);
    
    //
    // [stringCopy appendString:@"copy_"]; 执行后会报错,copy返回的对象不可变
    [stringMutableCopy appendString:@"mutableCopy_"];
}

- (void)learnCopyOfArray
{
    NSArray * array = [NSArray arrayWithObjects:@"aa", @"bb", @"cc", nil];
    NSArray * arrayCopy = [array copy];
    NSArray * arrayMutableCopy = [array mutableCopy];
    NSLog(@"array is: %@---%p---%p---%lu and stringCopy is: %@---%p---%p---%lu and stringMutableCopy is: %@---%p---%p---%lu", array, array, &array, [array retainCount], arrayCopy, arrayCopy, &arrayCopy, [arrayCopy retainCount], arrayMutableCopy, arrayMutableCopy, &arrayMutableCopy, [arrayMutableCopy retainCount]);
    
    // 通过打印得知：对于容器无论是copy还是mutableCopy
    // 其元素都是指针赋值
    printf("pointer in array is :");
    for (id object in array) {
        printf(" %p ", object);
    }
    printf("\n");
    
    printf("pointer in arrayCopy is :");
    for (id object in arrayCopy) {
        printf(" %p ", object);
    }
    printf("\n");
    
    printf("pointer in arrayMutableCopy is :");
    for (id object in arrayMutableCopy) {
        printf(" %p ", object);
    }
    printf("\n");
}

- (void)learnDeepCopyOfArray
{
    //
    NSArray *array = [NSArray arrayWithObjects:[NSMutableString stringWithString:@"first"], [NSString stringWithFormat:@"b"], @"c", nil];
    NSArray * deepCopyArray = [[NSArray alloc] initWithArray:array copyItems:YES];
    NSArray * trueDeepCopyArray = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:array]];
    
    printf("pointer in array is :");
    for (id object in array) {
        printf(" %p ", object);
    }
    printf("\n");
    
    // 可变元素深拷贝，不可变元素指针赋值
    printf("pointer in deepCopyArray is :");
    for (id object in deepCopyArray) {
        printf(" %p ", object);
    }
    printf("\n");
    
    // 可变元素深拷贝，不可变元素也是深拷贝
    printf("pointer in trueDeepCopyArray is :");
    for (id object in trueDeepCopyArray) {
        printf(" %p ", object);
    }
    printf("\n");
}

- (void)learnCopyAndMutableCopy
{
    Fraction * f1 = [[Fraction alloc] init];
    Fraction * f2 = [f1 copy];
    Fraction * f3 = [f1 mutableCopy];
    NSLog(@"pointer of f1 is: %@---%p---%p---%lu and pointer of f2 is: %@---%p---%p---%lu", f1, f1, &f1, [f1 retainCount], f2, f2, &f2, [f2 retainCount]);
    NSLog(@"pointer of f1 is: %@---%p---%lu and pointer of f2 is: %@---%p---%lu and pointer of f3 is: %@--%p--%lu", f1.firstName, f1.firstName, [f1.firstName retainCount], f2.firstName, f2.firstName, f2.firstName.retainCount, f3.firstName, f3.firstName, f3.firstName.retainCount);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
