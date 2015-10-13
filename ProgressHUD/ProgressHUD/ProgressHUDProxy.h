//
//  ProgressHUDProxy.h
//  ProgressHUD
//
//  Created by miniu on 15/6/25.
//  Copyright (c) 2015年 miniu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ProgressHUDProxy : NSObject

+ (UIWindow *)mainWindow;

+ (void)showHUDWithText:(NSString *)text autoHide:(BOOL)autoHide;
+ (void)showHUDWithText:(NSString *)text;
+ (void)showHUDModeIndeterminate;
+ (void)hideHUD;

@end
