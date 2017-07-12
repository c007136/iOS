//
//  ViewController.m
//  NSMapTable
//
//  Created by muyu on 2017/6/27.
//  Copyright © 2017年 muyu. All rights reserved.
//
//  NSMapTable和NSDictionary类似
//  NSDictionary对于key和value的内存管理，对key进行copy，对value强引用
//  在NSDictionary中，object是由“key”来索引的，key的值不能改变，
//  为了保证这个特性在NSDcitionary中对key的内存管理为copy，在复制的时候需要考虑对系统的负担，
//  因此key应该是轻量级的，所以通常我们都用字符串和数字来做索引，但这只能说是key-to-object映射，不能说是object-to-object的映射
//  NSMapTabTable更适合于我们一般所说的映射标准，它既可以处理key-to-value又可以处理object-to-object
//  http://www.jianshu.com/p/62d12b01be5c

//  http://www.isaced.com/post-235.html

#import "ViewController.h"
#import "Person.h"
#import "Favorite.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Person *p1 = [[Person alloc] init];
    Favorite *f1 = [[Favorite alloc] init];
    p1.name = @"Jack";
    f1.name = @"iOS";
    
    Person *p2 = [[Person alloc] init];
    Favorite *f2 = [[Favorite alloc] init];
    p2.name = @"Rose";
    f2.name = @"android";
    
    NSMapTable *mapTable = [NSMapTable mapTableWithKeyOptions:NSMapTableWeakMemory valueOptions:NSMapTableWeakMemory];
    [mapTable setObject:f1 forKey:p1];
    [mapTable setObject:f2 forKey:p2];
    
    NSLog(@"f1 value is %@", [mapTable objectForKey:p1]);
    NSLog(@"f2 value is %@", [mapTable objectForKey:p2]);
}

@end
