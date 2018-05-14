//
//  RunLoopWorkDistribution.h
//  RunLoop
//
//  Created by muyu on 2018/5/9.
//  Copyright © 2018年 muyu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef BOOL (^RunLoopWorkDistributionBlock)(void);

@interface RunLoopWorkDistribution : NSObject

@property (nonatomic, assign) NSUInteger maximumQueueLength;

+ (instancetype)share;

- (void)addTaskWithBlock:(RunLoopWorkDistributionBlock)block withKey:(id)key;

- (void)removeAllTasks;

@end
