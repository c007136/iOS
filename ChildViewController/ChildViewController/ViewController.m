//
//  ViewController.m
//  ChildViewController
//
//  Created by muyu on 2017/7/7.
//  Copyright © 2017年 muyu. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UISegmentedControl *segmentedControl;

@property (nonatomic, strong) UIViewController *currentViewController;

@property (nonatomic) NSInteger segmentIndex;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.titleView = self.segmentedControl;
    
    [self p_addChildViewController];
}

#pragma mark - event

- (void)clickSegmentedControl
{
    [self.currentViewController willMoveToParentViewController:nil];
    [self.currentViewController.view removeFromSuperview];
    UIViewController *vc = self.childViewControllers[self.segmentedControl.selectedSegmentIndex];
    vc.view.frame = self.view.bounds;
    [self.view addSubview:vc.view];
    [vc didMoveToParentViewController:self];
    self.currentViewController = vc;
}

#pragma mark - private method

- (void)p_addChildViewController
{
    FirstViewController *first = [[FirstViewController alloc] init];
    SecondViewController *second = [[SecondViewController alloc] init];
    NSArray *array = @[first,second];
    for (UIViewController *vc in array) {
        [self addChildViewController:vc];
    }
    
    self.currentViewController = self.childViewControllers[0];
    self.currentViewController.view.frame = self.view.bounds;
    [self.view addSubview:self.currentViewController.view];
    [self.currentViewController didMoveToParentViewController:self];
}

#pragma mark - getter and setter

- (UISegmentedControl *)segmentedControl
{
    if (_segmentedControl == nil) {
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"第一页",@"第二页"]];
        [_segmentedControl addTarget:self action:@selector(clickSegmentedControl) forControlEvents:UIControlEventValueChanged];
        _segmentedControl.selectedSegmentIndex = 0;
    }
    return _segmentedControl;
}



@end
