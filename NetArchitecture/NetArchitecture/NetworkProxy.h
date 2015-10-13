//
//  NetworkProxy.h
//  NetArchitecture
//
//  Created by miniu on 15/6/24.
//  Copyright (c) 2015年 miniu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

#pragma - typedef block
typedef void (^SuccessWithRequestBlock)(NSDictionary * dictionary);
typedef void (^FailureWithRequestBlock)(NSError * error);




#pragma - delegate
@protocol NetworkProxyDelegate <NSObject>

@required
- (void)successWithRequest:(NSDictionary *)dictionary;

@optional
- (void)failureWithRequest:(NSError *)error;

@end




#pragma - NetworkProxy
@interface NetworkProxy : NSObject

// 单例
+ (NetworkProxy *)proxy;

// block方式
// 以前自己用的方式
// 1.在ViewController dealloc后，仍会被执行到
// 2.逻辑业务多时，代码不是很美观
// 3.至于调试，个人觉得还好。
- (void)loadWithRequest:(NSURLRequest *)request success:(SuccessWithRequestBlock)successBlock;

- (void)loadWithRequest:(NSURLRequest *)request success:(SuccessWithRequestBlock)successBlock failure:(FailureWithRequestBlock)failureBlock;

@end
