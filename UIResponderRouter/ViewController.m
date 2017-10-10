//
//  ViewController.m
//  UIResponderRouter
//
//  Created by muyu on 2017/9/27.
//  Copyright © 2017年 muyu. All rights reserved.
//

#import "ViewController.h"
#import "AView.h"

@interface ViewController ()

@property (nonatomic, strong) AView *aView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.aView];
    
    self.aView.frame = CGRectMake(0, 60, self.view.frame.size.width, 60);
}

#pragma mark - responder router

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    NSLog(@"user info dict is %@", userInfo);
}

#pragma mark - getter and setter

- (AView *)aView
{
    if (_aView == nil) {
        _aView = [[AView alloc] init];
    }
    return _aView;
}

@end
