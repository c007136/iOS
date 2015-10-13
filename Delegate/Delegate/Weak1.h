//
//  Weak1.h
//  Delegate
//
//  Created by miniu on 15/6/24.
//  Copyright (c) 2015年 miniu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Proxy.h"

@interface Weak1 : NSObject<PDelegate>

- (void)delegateFun:(NSString *)text;

@end
