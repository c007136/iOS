//
//  Task.h
//  Runloop
//
//  Created by muyu on 2019/8/22.
//  Copyright © 2019 muyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Task : NSObject

@property (nonatomic, assign, getter=isFinished) BOOL finished;

- (void)run;

@end

NS_ASSUME_NONNULL_END
