//
//  AppDelegate.h
//  Window
//
//  Created by miniu on 15/6/25.
//  Copyright (c) 2015年 miniu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UIWindow *normalLevelWindow;
@property (strong, nonatomic) UIWindow *statusBarLevelWindow;
@property (strong, nonatomic) UIWindow *alertLevelWindow;


@end

