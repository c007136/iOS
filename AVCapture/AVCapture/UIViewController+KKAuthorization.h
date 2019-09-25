//
//  UIViewController+KKAuthorization.h
//  PalmDoctorPT
//
//  Created by yuanye on 2016/11/18.
//  Copyright © 2016年 kangmeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (KKAuthorization)

- (void)kk_checkCameraAvailability:(void (^)(BOOL auth))block;

- (void)kk_checkPhotoLibraryAvailability:(void (^)(BOOL auth))block;

@end
