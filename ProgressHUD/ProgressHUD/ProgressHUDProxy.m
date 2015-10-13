//
//  ProgressHUDProxy.m
//  ProgressHUD
//
//  Created by miniu on 15/6/25.
//  Copyright (c) 2015年 miniu. All rights reserved.
//
//  MBProgressHUD学习
//
//  两个问题：
//  1.根据label等元素，计算HUD的frame大小，使之不要等于父view的frame  // 关注此函数：layoutSubviews
//  2.如何置顶HUD，使得在切换ViewController后HUD不消失       //[view bringSubviewToFront:hud];
//
//  参考链接：
//  http://southpeak.github.io/blog/2015/03/24/yuan-ma-pian-:mbprogresshud/
//  http://stackoverflow.com/questions/12033080/use-of-mbprogresshud-globally-make-it-singleton
//  http://bj007.blog.51cto.com/1701577/541572

#import "ProgressHUDProxy.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"

@implementation ProgressHUDProxy

+ (UIWindow *)mainWindow
{
    return [[[UIApplication sharedApplication] windows] lastObject];
}

+ (void)showHUDWithText:(NSString *)text autoHide:(BOOL)autoHide
{
    [ProgressHUDProxy showHUDWithText:text];
    
    if ( autoHide ) {
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1.5 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            UIWindow * window = [ProgressHUDProxy mainWindow];
            [MBProgressHUD hideAllHUDsForView:window animated:YES];
        });
    }
}

+ (void)showHUDWithText:(NSString *)text
{
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        
        UIWindow * window = [ProgressHUDProxy mainWindow];
        if ( 0 == [MBProgressHUD allHUDsForView:window].count ) {
            [MBProgressHUD showHUDAddedTo:window animated:YES];
        }
        
        [MBProgressHUD HUDForView:window].mode = MBProgressHUDModeText;
        [MBProgressHUD HUDForView:window].labelText = text;
        
    });
}

+ (void)showHUDModeIndeterminate
{
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        if ( 0 == [MBProgressHUD allHUDsForView:[ProgressHUDProxy mainWindow]].count ) {
            [MBProgressHUD showHUDAddedTo:[ProgressHUDProxy mainWindow] animated:YES];
        }
        
        [MBProgressHUD HUDForView:[ProgressHUDProxy mainWindow]].mode = MBProgressHUDModeIndeterminate;
        [MBProgressHUD HUDForView:[ProgressHUDProxy mainWindow]].labelText = @"加载中...";
        [MBProgressHUD HUDForView:[ProgressHUDProxy mainWindow]].opacity = 0.7;
    });
}

+ (void)hideHUD
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow * window = [ProgressHUDProxy mainWindow];
        [MBProgressHUD hideAllHUDsForView:window animated:YES];
    });
}

@end
