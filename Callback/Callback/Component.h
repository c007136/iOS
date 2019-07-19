//
//  Component.h
//  Callback
//
//  Created by miniu on 15/6/23.
//  Copyright (c) 2015年 miniu. All rights reserved.
//

#import <Foundation/Foundation.h>

// delegate
@protocol ComponetDelegate <NSObject>

@required
- (void)callback:(NSDictionary *)dictionary;

@end

// typedef
typedef void (^BlockMethod) (NSDictionary * dictionary);
typedef void (*funPointer) (NSDictionary * dictionary);

// class
@interface Component : NSObject

- (void)runByBlock:(BlockMethod)block;
- (void)runByNotification;
- (void)runByPerformSelector:(NSDictionary *)dictionary;
- (void)runByFunctionPointer:(NSDictionary *)dictionary;
- (void)runBySEL;
- (void)runByIMP;
- (void)runByDelegate;
- (void)runByTarget:(id)target action:(SEL)selector;

@property (nonatomic, weak) id<ComponetDelegate> delegate;

@end
