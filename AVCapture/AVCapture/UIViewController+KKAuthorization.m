//
//  UIViewController+KKAuthorization.m
//  PalmDoctorPT
//
//  Created by yuanye on 2016/11/18.
//  Copyright © 2016年 kangmeng. All rights reserved.
//

#import "UIViewController+KKAuthorization.h"
#import <AVFoundation/AVFoundation.h>
#import "NSBundle+KKAppName.h"
#import <UIViewController+ZBToastHUD.h>
#import <Photos/Photos.h>

@implementation UIViewController (KKAuthorization)

- (void)kk_checkCameraAvailability:(void (^)(BOOL auth))block
{
#if TARGET_IPHONE_SIMULATOR
    if (block) {
        block(NO);
    }
#elif TARGET_OS_IPHONE
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [self zb_showErrorWithMessage:@"无摄像头或不可用"];
        if (block) {
            block(NO);
        }
        return;
    }
    
    BOOL auth = NO;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusAuthorized) {
        auth = YES;
    } else if (authStatus == AVAuthorizationStatusDenied) {
        auth = NO;
    } else if (authStatus == AVAuthorizationStatusRestricted) {
        auth = NO;
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (block) {
                    block(granted);
                }
            });
        }];
        return;
    }
    
    if (!auth)
    {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]])
        {
            __weak __typeof(self) weakSelf = self;
            NSString *title = [NSString stringWithFormat:@"请到「设置-隐私-相机-允许“%@”访问相机」", [NSBundle kk_bundleName]];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:@"" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
            UIAlertAction *settingAction = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf p_openURL];
            }];
            [alert addAction:cancelAction];
            [alert addAction:settingAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else
        {
            NSString *title = [NSString stringWithFormat:@"请到「设置-隐私-相机-允许“%@”访问相机」", [NSBundle kk_bundleName]];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:@"" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:cancelAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
    
    if (block) {
        block(auth);
    }
#endif
}

- (void)kk_checkPhotoLibraryAvailability:(void (^)(BOOL auth))block
{
    BOOL auth = NO;
    PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
    if (authStatus == PHAuthorizationStatusAuthorized) {
        auth = YES;
    } else if (authStatus == PHAuthorizationStatusRestricted) {
        auth = NO;
    } else if (authStatus == PHAuthorizationStatusDenied) {
        auth = NO;
    } else if (authStatus == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            dispatch_async(dispatch_get_main_queue(), ^{
                BOOL auth = (status == PHAuthorizationStatusAuthorized) ? YES : NO;
                if (block) {
                    block(auth);
                }
            });
        }];
        return;
    }
    
    if (!auth)
    {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]])
        {
            __weak __typeof(self) weakSelf = self;
            NSString *title = [NSString stringWithFormat:@"请到「设置-隐私-照片-允许“%@”访问你的相册」", [NSBundle kk_bundleName]];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:@"" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
            UIAlertAction *settingAction = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf p_openURL];
            }];
            [alert addAction:cancelAction];
            [alert addAction:settingAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else
        {
            NSString *title = [NSString stringWithFormat:@"请到「设置-隐私-照片-允许“%@”访问你的相册」", [NSBundle kk_bundleName]];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:@"" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:cancelAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
    
    if (block) {
        block(auth);
    }
}

- (void)p_openURL
{
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:completionHandler:)]) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    } else if ([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:)]) {
        [[UIApplication sharedApplication] openURL:url];
    } else {
        NSAssert(0, @"Strange: [UIApplication sharedApplication] can't open URL.");
    }
}

@end
