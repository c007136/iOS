//
//  RTask2.m
//  Runloop
//
//  Created by muyu on 2019/8/22.
//  Copyright © 2019 muyu. All rights reserved.
//

#import "RTask2.h"

@implementation RTask2

- (void)run
{
    NSLog(@"task2 run dataDict is %@", self.dataDict);
    
    sleep(3);
    
    NSLog(@"task2 run finished current thread is %@", [NSThread currentThread]);
}

@end
