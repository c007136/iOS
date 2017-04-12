//
//  ViewController.m
//  MDSwipeView
//
//  Created by muyu on 2016/12/2.
//  Copyright © 2016年 muyu. All rights reserved.
//

#import "ViewController.h"
#import "MDSwipeView.h"

@interface ViewController ()

@property (nonatomic, strong) MDSwipeView *swipeView;

@end

@implementation ViewController

#pragma mark - lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.swipeView];
    
    self.swipeView.frame = self.view.bounds;
    
    [self.swipeView reloadData];
}

#pragma mark - getter and setter

- (MDSwipeView *)swipeView
{
    if (nil == _swipeView) {
        _swipeView = [[MDSwipeView alloc] init];
    }
    return _swipeView;
}

@end
