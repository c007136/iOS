//
//  RequestManager.m
//  NetArchitecture
//
//  Created by miniu on 15/6/24.
//  Copyright (c) 2015年 miniu. All rights reserved.
//

#import "RequestManager.h"
#import "NetworkProxy.h"

@implementation RequestManager

- (void)loadData
{
    NSDictionary * dict = [self.source paramsForRequest];
    [self loadDataWithParams:dict];
}

- (NSURLRequest *)request:(NSDictionary *)dict
{
    return nil;
}

- (void)loadDataWithParams:(NSDictionary *)dict
{
    [[NetworkProxy proxy] loadWithRequest:[self request:dict] success:^(NSDictionary *dictionary) {
        
        //通用判断
        NSString * result = [dict objectForKey:@"result"];
        if ( [result isEqualToString:@"success"] ) {
            [self.delegate requestDidSuccess:dictionary];
        } else {
            //
        }
        
    } failure:^(NSError *error) {
        [self.delegate requestDidFailed:error];
    }];
}

@end
