//
//  NetworkProxy.m
//  NetArchitecture
//
//  Created by miniu on 15/6/24.
//  Copyright (c) 2015年 miniu. All rights reserved.
//

#import "NetworkProxy.h"

@implementation NetworkProxy

+ (NetworkProxy *)proxy
{
    static NetworkProxy * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)loadWithRequest:(NSURLRequest *)request success:(SuccessWithRequestBlock)successBlock
{
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.completionQueue = dispatch_get_main_queue();
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData * responseData = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
        //
        if ( successBlock != nil ) {
            successBlock(dict);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"网络异常，请检查网络");
    }];
    [op start];
}


- (void)loadWithRequest:(NSURLRequest *)request success:(SuccessWithRequestBlock)successBlock failure:(FailureWithRequestBlock)failureBlock
{
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.completionQueue = dispatch_get_main_queue();
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData * responseData = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
        
        if ( successBlock != nil ) {
            successBlock(dict);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (failureBlock != nil) {
            failureBlock(error);
        }
        
    }];
    [op start];
}
@end
