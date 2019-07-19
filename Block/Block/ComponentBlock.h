//
//  ComponentBlock.h
//  Block
//
//  Created by miniu on 15/6/23.
//  Copyright (c) 2015年 miniu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^BlockLearn) (NSString * param);
typedef void (^BlockStudy) (NSString * param, NSDictionary * dictionary);

@interface ComponentBlock : NSObject

@property (nonatomic, strong) BlockLearn block;

- (void)run;
- (void)runWithBlock:(BlockStudy)block;


@end
