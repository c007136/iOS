//
//  ViewController.m
//  FBKVOController
//
//  Created by muyu on 2017/6/27.
//  Copyright © 2017年 muyu. All rights reserved.
//
//  细节解析
//  https://satanwoo.github.io/2016/02/27/FBKVOController/

#import "ViewController.h"
#import "FBKVOController.h"
#import "Person.h"

@interface ViewController ()

@property (nonatomic, strong) Person *person;
@property (nonatomic, strong) FBKVOController *fbKVO;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 200, 50)];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    __weak __typeof(self)weakSelf = self;
    [self.fbKVO observe:self.person keyPath:@"name" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSKeyValueChangeKey,id> * _Nonnull change) {
        weakSelf.title = change[NSKeyValueChangeNewKey];
    }];
}

- (void)dealloc
{
    NSLog(@"%s", __FUNCTION__);
}

#pragma mark - event

- (void)buttonClick
{
    NSUInteger nums = arc4random()%10;
    self.person.name = [NSString stringWithFormat:@"newName_%@", @(nums)];
}

#pragma mark - getter and setter

- (Person *)person
{
    if (_person == nil) {
        _person = [[Person alloc] init];
        _person.name = @"DefaultName";
    }
    return _person;
}

- (FBKVOController *)fbKVO
{
    if (_fbKVO == nil) {
        _fbKVO = [FBKVOController controllerWithObserver:self];
    }
    return _fbKVO;
}

@end
