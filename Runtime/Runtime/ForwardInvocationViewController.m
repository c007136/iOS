//
//  ForwardInvocationViewController.m
//  Runtime
//
//  Created by muyu on 2018/11/29.
//  Copyright © 2018 miniu. All rights reserved.
//

#import "ForwardInvocationViewController.h"

@interface ForwardInvocationViewController ()

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *password;

@property (nonatomic, strong) NSMutableDictionary *dataDict;

@end

@implementation ForwardInvocationViewController

@dynamic name;
@dynamic password;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.name = @"muyu";
    self.password = @"123456";
    NSLog(@"dataDict is %@", self.dataDict);
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    NSString *key = NSStringFromSelector([anInvocation selector]);
    NSLog(@"selector is %@", key);
    
    // setter
    if ([key rangeOfString:@"set"].location == 0)
    {
        key = [[key substringWithRange:NSMakeRange(3, [key length]-4)] lowercaseString];
        NSString *obj;
        [anInvocation getArgument:&obj atIndex:2];
        [self.dataDict setObject:obj forKey:key];
    }
    // getter
    else
    {
        NSString *obj = [self.dataDict objectForKey:key];
        [anInvocation setReturnValue:&obj];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSString *sel = NSStringFromSelector(aSelector);
    
    // 动态构造一个setter函数
    if ([sel rangeOfString:@"set"].location == 0)
    {
        return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
    }
    // 动态构造一个getter函数
    else
    {
        return [NSMethodSignature signatureWithObjCTypes:"@@:"];
    }
}

#pragma mark - Getter and Setter

- (NSMutableDictionary *)dataDict
{
    if (_dataDict == nil) {
        _dataDict = [[NSMutableDictionary alloc] init];
    }
    return _dataDict;
}

@end
