//
//  MMOperation.h
//  NSOperationQueue
//
//  Created by muyu on 2018/7/4.
//  Copyright © 2018年 muyu. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const MMOperationCompletionNotification;

@interface MMOperation : NSOperation

@property (nonatomic, assign) NSInteger tag;

@end
