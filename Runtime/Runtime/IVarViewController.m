//
//  IVarViewController.m
//  Runtime
//
//  Created by muyu on 2018/11/20.
//  Copyright © 2018 miniu. All rights reserved.
//

#import "IVarViewController.h"
#import <objc/runtime.h>
#import "Person.h"


@interface IVarViewController ()

@end

@implementation IVarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    [self ivarList];
}

- (void)ivarList
{
    unsigned int count = 0;
    Ivar *var = class_copyIvarList([Person class], &count);
    for (NSInteger i = 0; i < count; i++) {
        NSLog(@"%s", ivar_getName(var[i]));
    }
}

@end
