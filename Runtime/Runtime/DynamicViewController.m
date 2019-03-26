//
//  DynamicViewController.m
//  Runtime
//
//  Created by muyu on 2018/11/29.
//  Copyright © 2018 miniu. All rights reserved.
//

#import "DynamicViewController.h"
#include <objc/runtime.h>

@interface DynamicViewController ()

- (void)missInstanceMethod:(NSString *)string;

+ (void)missClassMethod:(NSString *)string;

@end

@implementation DynamicViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([self respondsToSelector:@selector(missInstanceMethod:)]) {
        [self performSelector:@selector(missInstanceMethod:) withObject:@"instance method"];
    }
    
    if ([DynamicViewController respondsToSelector:@selector(missClassMethod:)]) {
        [[self class] performSelector:@selector(missClassMethod:) withObject:@"class method"];
    }
}

+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    if (sel == @selector(missInstanceMethod:))
    {
        IMP imp = class_getMethodImplementation([self class], @selector(myInstanceMethod:));
        class_addMethod([self class], sel, imp, "v@:");
        return YES;
    }
    
    return [super resolveInstanceMethod:sel];
}

+ (BOOL)resolveClassMethod:(SEL)sel
{
    if (sel == @selector(missClassMethod:))
    {
        //Class classTemp = [self class];  // 会崩溃
        Class class = object_getClass(self);
        //Class class = object_getClass([self class]);  // 等同object_getClass，不会崩溃
        IMP imp = class_getMethodImplementation(class, @selector(myClassMethod:));
        class_addMethod(class, sel, imp, "v@:");
        return YES;
    }
    
    return [super resolveClassMethod:sel];
}

- (void)myInstanceMethod:(NSString *)string
{
    NSLog(@"类名与方法名 %s, string is %@", __PRETTY_FUNCTION__, string);
}

+ (void)myClassMethod:(NSString *)string
{
    NSLog(@"类名与方法名 %s, string is %@", __PRETTY_FUNCTION__, string);
}

@end
