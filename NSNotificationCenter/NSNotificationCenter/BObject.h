//
//  BObject.h
//  NSNotificationCenter
//
//  Created by muyu on 2017/5/22.
//  Copyright © 2017年 muyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TestObject.h"

@protocol BDelegate <NSObject>

- (void)b_fun1;

@end




@interface BObject : NSObject

@property (nonatomic, weak) id<BDelegate> delegate;

+(BObject *)getInstance;

- (void)fun;

@end
