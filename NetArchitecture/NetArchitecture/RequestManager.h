//
//  RequestManager.h
//  NetArchitecture
//
//  Created by miniu on 15/6/24.
//  Copyright (c) 2015年 miniu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RequestManager;

// callback delegate
@protocol RequestCallbackDelegate <NSObject>

@required
- (void)requestDidSuccess:(NSDictionary *)dict;

@optional
- (void)requestDidFailed:(NSError *)error;

@end



// reformer
@protocol RequestCallbackDataReformer <NSObject>

@required
- (id)manager:(RequestManager *)manager reformData:(NSDictionary *)data;

@end



// data source
@protocol RequestSourceDelegate <NSObject>

@required
- (NSDictionary *)paramsForRequest;

@end


@interface RequestManager : NSObject


@property (nonatomic, weak) id<RequestCallbackDelegate> delegate;
@property (nonatomic, weak) id<RequestSourceDelegate> source;
@property (nonatomic, weak) id<RequestCallbackDataReformer> reformer;

- (void)loadData;

@end
