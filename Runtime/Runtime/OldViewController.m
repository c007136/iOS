//
//  OldViewController.m
//  Runtime
//
//  Created by muyu on 2018/11/16.
//  Copyright © 2018 miniu. All rights reserved.
//
//  objective_c runtime学习
//
//  meta class是什么？
//  参考链接：
//  http://www.cocoachina.com/industry/20131210/7508.html
//  http://www.justinyan.me/post/1624

//  objective-c runtime学习
//  http://blog.csdn.net/wzzvictory/article/details/8615569
//  http://blog.csdn.net/wzzvictory/article/details/8624057
//  http://blog.csdn.net/wzzvictory/article/details/8629036

#import "OldViewController.h"
#import <objc/objc.h>
#import <objc/runtime.h>
#import "MObject.h"

@interface OldViewController ()

// 实现消息的转发
@property (nonatomic, strong) NSString * stringTest;

@property (nonatomic, strong) MObject * mObject;

@end




void ReportFunction(id self, SEL cmd)
{
    NSLog(@"This object is %p", self);
    NSLog(@"Class is %@, and super is %@", [self class], [self superclass]);
    
    Class currentClass = [self class];
    for (int i = 0; i < 5; i++) {
        NSLog(@"Following the isa pointer %d times gives %p", i, currentClass);
        currentClass = object_getClass(currentClass);
    }
    
    NSLog(@"NSObject's class is %p", [NSObject class]);
    NSLog(@"NSObject's meta class is %p", object_getClass([NSObject class]));
}

int dynamicMethodIMP(id self, SEL cmd, NSString * string)
{
    NSLog(@"self is %@ pointer of self is %p and class is %@ and SEL is %s", self, self, [self class], cmd);
    
    NSLog(@"string is in dynamicMethodIMP :  %@", string);
    return 10;
}




@implementation OldViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //    [(id)[NSObject class] isKindOfClass:[NSObject class]];
    //
    //    BOOL res1 = [(id)[NSObject class] isKindOfClass:[NSObject class]];
    //    BOOL res2 = [(id)[NSObject class] isMemberOfClass:[NSObject class]];
    //
    //    BOOL res3 = [(id)[MObject class] isKindOfClass:[MObject class]];
    //    BOOL res4 = [(id)[MObject class] isMemberOfClass:[MObject class]];
    //
    //    NSLog(@"%d %d %d %d", res1, res2, res3, res4);
    
    //[self learnSelector];
    //[self learnIMP];
    //self.stringTest = @"I am a string";
}

- (void)learnBySelf
{
    Class currentClass = [OldViewController class];
    for (int i = 0; i < 10; i++) {
        NSLog(@"Following the isa pointer %d times gives %p class is %@", i, currentClass, currentClass);
        currentClass = object_getClass(currentClass);
    }
}

- (void)learnByClassPair
{
    Class newClass = objc_allocateClassPair([NSError class], "RuntimeErrorSubclass", 0);
    class_addMethod(newClass, @selector(report), (IMP)ReportFunction, "v@:");
    objc_registerClassPair(newClass);
    
    id instanceOfNewClass = [[newClass alloc] initWithDomain:@"someDomain" code:0 userInfo:nil];
    [instanceOfNewClass performSelector:@selector(report) withObject:nil];
}

// SEL 其实是 char * 指针
- (void)learnSelector
{
    SEL selector = @selector(message);
    NSLog(@"%s", (char *)selector);
    NSLog(@"%s", sel_getName(selector));
}

- (void)learnIMP
{
    // 定义函数指针的类型
    typedef void (* FUN)(id, SEL);
    // 声明函数指针
    void (*performMessage)(id, SEL);
    
    performMessage = (FUN)[self methodForSelector:@selector(message)];
    performMessage(self, @selector(message));
}

// 关于class_addMethod可查看官方文档
// https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    NSLog(@"sel is %@ in resolveInstanceMethod", NSStringFromSelector(sel));
    
    if (sel == @selector(setStringTest:)) {
        class_addMethod([self class], sel, (IMP)dynamicMethodIMP, "i@:@");
        return YES;
    }
    
    return [super resolveInstanceMethod:sel];
}

// 消息转发
// 类似多重继承
// todo muyu 有待再研究研究
// http://www.cnblogs.com/treejohn/p/3596531.html
- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    SEL invSel = anInvocation.selector;
    if ( [_mObject respondsToSelector:invSel] ) {
        [anInvocation invokeWithTarget:_mObject];
    } else {
        [self doesNotRecognizeSelector:invSel];
    }
}

- (void)setStringTest:(NSString *)string
{
    _stringTest = string;
    NSLog(@"string test is in setStringTest : %@", string);
}

- (void)message
{
    NSLog(@"log in message.");
}

- (void)report
{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
