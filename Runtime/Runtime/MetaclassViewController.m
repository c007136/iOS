//
//  MetaclassViewController.m
//  Runtime
//
//  Created by muyu on 2018/11/16.
//  Copyright © 2018 miniu. All rights reserved.
//
//  参考文章
//  浅谈Objective-C中的元类（https://www.jianshu.com/p/79b06fabb459）

#import "MetaclassViewController.h"
#import <objc/runtime.h>
#import "Person.h"


void Function(id self, SEL _cmd)
{
    NSLog(@"This object is %p.", self);
    NSLog(@"Class is %@, and super is %@.", [self class], [self superclass]);
    
    Class currentClass = [self class];
    for (int i = 1; i < 5; i++)
    {
        NSLog(@"Following the isa pointer %d times gives %p", i, currentClass);
        currentClass = object_getClass(currentClass);
    }
    
    NSLog(@"NSObject's class is %p", [NSObject class]);
    NSLog(@"NSObject's meta class is %p", object_getClass([NSObject class]));
}



@interface MetaclassViewController ()

@end

@implementation MetaclassViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    [self methodsOfNSObject];
}

- (void)getMetaClass
{
    NSLog(@"Person's class is %@ and point is %p", [Person class], [Person class]);
    NSLog(@"Person's metaclass is %@ and point is %p ", object_getClass([Person class]), object_getClass([Person class]));
}

- (void)relationship
{
    /*
     * 结论：
     * 类的元类的isa指向的是NSObject
     * NSObject指向的是自己
     */
    
    // UIButton --> UIControl --> UIView --> UIResponder --> NSObject
    // 多重继承关系
    class_addMethod([UIButton class], @selector(report), (IMP)Function, "v@:");
    UIButton *view = [[UIButton alloc] init];
    [view performSelector:@selector(report)];
    
    
    // RuntimeErrorSubclass --> NSError --> NSObject
    // 三重继承关系
    Class newClass = objc_allocateClassPair([NSError class], "RuntimeErrorSubclass", 0);
    class_addMethod(newClass, @selector(report), (IMP)Function, "v@:");
    objc_registerClassPair(newClass);
    
    id instanceOfNewClass = [[newClass alloc] initWithDomain:@"someDomain" code:0 userInfo:nil];
    [instanceOfNewClass performSelector:@selector(report)];
}

- (void)methods
{
    unsigned int count;
    
    // 实例方法
    NSLog(@"*****instance method*****");
    Class class1 = [Person class];
    Method *methods = class_copyMethodList(class1, &count);
    for (int i = 0; i < count; i++) {
        NSLog(@"%s", sel_getName(method_getName(methods[i])));
    }
    free(methods);
    
    NSLog(@"");
    NSLog(@"*****class method*****");
    
    Class class2 = object_getClass([Person class]);
    methods = class_copyMethodList(class2, &count);
    for (int i = 0; i < count; i++) {
        NSLog(@"%s", sel_getName(method_getName(methods[i])));
    }
    free(methods);
}

- (void)methodsOfNSObject
{
    unsigned int count;
    
    // 获得了实例方法和类方法
    NSLog(@"*****instance method*****");
    Class class1 = [NSObject class];
    Method *methods = class_copyMethodList(class1, &count);
    for (int i = 0; i < count; i++) {
        NSLog(@"%s", sel_getName(method_getName(methods[i])));
    }
    free(methods);
}

@end
