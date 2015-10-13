//
//  ViewController.m
//  NetArchitecture
//
//  Created by miniu on 15/6/24.
//  Copyright (c) 2015年 miniu. All rights reserved.
//

#import "ViewController.h"
#import "NetworkProxy.h"
#import "DemoRequestManager.h"

@interface ViewController () <RequestCallbackDelegate>

@property (nonatomic, strong) DemoRequestManager * demoRequestManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.demoRequestManager loadData];
    
//    // http://192.168.0.11:8850
//    // http://60.191.98.34:8850
//    NSString * urlText = @"http://192.168.0.11:8850/util/offline_spread_help.json";
//    NSDictionary * parameters = @{@"target" : @"62"};
//    NSURLRequest * request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:urlText parameters:parameters error:nil];
//    
//    // block方式
//    [[NetworkProxy proxy] loadWithRequest:request success:^(NSDictionary *dictionary) {
//        NSLog(@"request success in block dictionary is %@.", dictionary);
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (DemoRequestManager *)demoRequestManager
{
    if (nil == _demoRequestManager) {
        _demoRequestManager = [[DemoRequestManager alloc] init];
        _demoRequestManager.delegate = self;
    }
    return _demoRequestManager;
}

- (void)requestDidSuccess:(NSDictionary *)dict
{
    NSLog(@"requestDidSuccess, dict is : %@", dict);
}

- (void)requestDidFailed:(NSError *)error
{
    
}

@end
