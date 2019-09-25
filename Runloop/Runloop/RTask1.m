//
//  RTask1.m
//  Runloop
//
//  Created by muyu on 2019/8/22.
//  Copyright © 2019 muyu. All rights reserved.
//

#import "RTask1.h"

@implementation RTask1

- (void)run
{
    NSLog(@"task1 run dataDict is %@", self.dataDict);
    
    sleep(2);
    
    NSLog(@"task1 run finished current thread is %@", [NSThread currentThread]);
}

@end
