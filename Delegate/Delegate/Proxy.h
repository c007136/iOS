//
//  Proxy.h
//  Delegate
//
//  Created by miniu on 15/6/24.
//  Copyright (c) 2015年 miniu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PDelegate <NSObject>

@required
- (void)delegateFun:(NSString *)text;

@end




typedef void (^DelegateBlock) (NSString * text);

@interface Proxy : NSObject

@property (nonatomic, weak) id<PDelegate> delegate;
//@property (nonatomic, copy) NSArray * copyArray;

+ (Proxy *)proxy;

// 参数delegate: “id<PDelegate>”比“id”好
- (void)run:(NSInteger)time text:(NSString *)text delegate:(id<PDelegate>)delegate;
- (void)runByBlock:(DelegateBlock)block time:(NSInteger)time;

@end
