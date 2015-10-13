//
//  main.m
//  Xib
//
//  Created by miniu on 15/6/5.
//  Copyright (c) 2015年 miniu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        @try {
            return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        }
        @catch (NSException *exception) {
            NSLog(@"Exception is %@!", exception);
        }
    }
}
