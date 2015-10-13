//
//  ViewController.m
//  MKNetworkKit
//
//  Created by miniu on 15/6/18.
//  Copyright (c) 2015年 miniu. All rights reserved.
//
//  MKNetworkKit学习

#import "ViewController.h"
#import "MKNetworkKit.h"
#import "MKNetworkEngine.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    MKNetworkEngine * engine = [[MKNetworkEngine alloc] initWithHostName:@""];
    
    NSString * urlString = @"http://app.miniu98.com/util/offline_spread_help.json";
    NSDictionary * parameters = @{@"target" : @"192168"};
    
    MKNetworkOperation * op = [engine operationWithURLString:urlString params:parameters httpMethod:@"GET"];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSString * respone = [completedOperation responseString];
        NSLog(@"success..... %@", respone);
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
        NSLog(@"failed...... %@", error);
        
    }];
    [engine enqueueOperation:op];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
