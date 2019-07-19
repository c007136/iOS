//
//  ViewController.m
//  Callback
//
//  Created by miniu on 15/6/23.
//  Copyright (c) 2015年 miniu. All rights reserved.
//
//  Objective-C回调机制学习
//  未能实现的方式：IMP and target
//
//  参考链接：
//  http://blog.sina.com.cn/s/blog_631af5500100z4ub.html

#import "ViewController.h"
#import "Component.h"

@interface ViewController () <ComponetDelegate>

@property (nonatomic, strong) Component * component;

@end

@implementation ViewController

- (id)init
{
    if (self) {
        _component = [[Component alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(msgNotification:) name:@"fNotification" object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"fNotification" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // block方式
    [_component runByBlock:^(NSDictionary *dictionary) {
        NSLog(@"### dictionary post by block: %@ ###", dictionary);
    }];
    
    // delegate
    _component.delegate = self;
    [_component runByDelegate];
    
    // target-action
    [_component runByTarget:self action:@selector(cTargetAction:)];
    
    
    // notification
    [_component runByNotification];
    
    // performSelector
    NSDictionary * dictionary = @{@"aPerformSelector":@"AA", @"bPerformSelector":@"BB"};
    if ( [_component respondsToSelector:@selector(runByPerformSelector:)] ) {
        [_component performSelector:@selector(runByPerformSelector:) withObject:dictionary];
    }
    
    // function pointer
    NSDictionary * dictionary1 = @{@"aFunctionPointer":@"AA", @"bFunctionPointer":@"BB"};
    [_component performSelector:@selector(runByFunctionPointer:) withObject:dictionary1];
    
//    // IMP
//    //SEL sel = @selector(runByIMP);
//    SEL sel = NSSelectorFromString(@"runByIMP");
//    IMP imp = [_component methodForSelector:sel];
//    imp(_component, sel);
}

// notification
- (void)msgNotification:(NSNotification *)notification
{
    NSDictionary * dictionary = notification.object;
    NSLog(@"### dictionary post by notification: %@ ###", dictionary);
}

// ComponentDelegate
- (void)callback:(NSDictionary *)dictionary
{
    NSLog(@"### dictionary post by delegate: %@ ###", dictionary);
}

// target-action
- (void)cTargetAction:(NSDictionary *)dictionary
{
    NSLog(@"### dictionary post by target-action: %@ ###", dictionary);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
