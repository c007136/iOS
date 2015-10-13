//
//  DemoRequestManager.m
//  NetArchitecture
//
//  Created by miniu on 15/7/8.
//  Copyright (c) 2015年 miniu. All rights reserved.
//

#import "DemoRequestManager.h"
#import "NetworkProxy.h"

@implementation DemoRequestManager


- (NSURLRequest *)request:(NSDictionary *)dict
{
    NSString * urlText = @"http://60.191.98.34:88501/check_audit.json";
    NSURLRequest * request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:urlText parameters:dict error:nil];
    return request;
}

- (NSDictionary *)paramsForRequest
{
    return @{@"osType": @"ios"
           , @"version": @"1.0.0"};
}

@end
