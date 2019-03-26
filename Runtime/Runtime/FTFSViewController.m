//
//  FTFSViewController.m
//  Runtime
//
//  Created by muyu on 2018/11/29.
//  Copyright © 2018 miniu. All rights reserved.
//

#import "FTFSViewController.h"
#import "NoSelector.h"

@interface FTFSViewController ()

@end

@implementation FTFSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self performSelector:@selector(noSelector)];
}

// 很适合UINavigationController的返回按钮功能
- (id)forwardingTargetForSelector:(SEL)aSelector
{
    //return self/nil; 则会崩溃
    
    if (aSelector == @selector(noSelector)) {
        return [[NoSelector alloc] init];
    }
    
    return [super forwardingTargetForSelector:aSelector];
}

@end
