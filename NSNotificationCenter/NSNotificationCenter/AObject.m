//
//  AObject.m
//  NSNotificationCenter
//
//  Created by muyu on 2017/5/22.
//  Copyright © 2017年 muyu. All rights reserved.
//

#import "AObject.h"
#import "BObject.h"

@interface AObject ()

@property (nonatomic, strong) BObject *bObject;

@end

@implementation AObject

- (instancetype)init
{
    self = [super init];
    if (self) {
        _bObject = [[BObject alloc] init];
        NSLog(@"bObject is %@", _bObject);
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tNotification) name:@"test" object:nil];
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)tNotification
{
    NSLog(@"%s, self is %@", __func__, self);
}

@end
