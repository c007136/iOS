
//  Constants.h
//  Flipboard
//
//  Created by Kowloon on 12-7-10.
//  Copyright (c) 2012年 Goome. All rights reserved.
//

#ifndef Flipboard_Constants_h
#define Flipboard_Constants_h

// width and height
#define kWindowWidth CGRectGetWidth([UIScreen mainScreen].bounds)
#define kWindowHeight CGRectGetHeight([UIScreen mainScreen].bounds)
#define kTabBarHeight 49

// color
#define ColorWithValue(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define ColorWithRGB(r,g,b)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define ColorWithRGBA(r,g,b,a)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

//
#define CalculateValueInCode(x) (x)*320.0f/1242.0f


// todo muyu 想办法将下面的宏定义都去掉
///////////////////////////////////////////////////////
#define kWindowHeightWithoutNavigationBar (kWindowHeight - 44)
#define kWindowHeightWithoutNavigationBarAndTabbar (kWindowHeightWithoutNavigationBar - 49)
#define kContentFrameWithoutNavigationBar CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), kWindowHeightWithoutNavigationBar)

#define kContentFrameWithoutNavigationBarAndTabBar CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), kWindowHeightWithoutNavigationBarAndTabbar)

#define kContentFrame CGRectMake(0, 0, kWindowWidth, SystemVersionGreaterThanOrEqualTo7 ? (kWindowHeight + 20) : kWindowHeight)

#define kViewBackgroundColor ColorWithValue(0xF4F3F8)
#define kTabBarBackgroundColor [UIColor whiteColor]

#define kUD [NSUserDefaults standardUserDefaults]

#define kRedColor ColorWithRGB(189, 11, 7)
#define kGreenColor ColorWithRGB(148, 199, 195)
#define kTableViewBGColor ColorWithRGB(246, 241, 234)

#define kNavigationBarBackgroundColor kRedColor
#define kBoarderColor ColorWithRGB(204, 204, 204)

#define kContentBackgroundColor  [UIColor colorWithRed:234.0/255 green:247.0/255 blue:252.0/255 alpha:1]
#define kDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#define UMENG_KEY @"53a7cf7f56240bbe65195bfd"

#define ApplicationDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

#define kBlueColor ColorWithRGB(15, 82, 167)

#define kNotificationNameUserReloadData @"kNotificationNameUserReloadData"
#define kNotificationNameProfileReloadData kNotificationNameUserReloadData
//#define kNotificationNameProfileReloadData @"kNotificationNameProfileReloadData"
#define kNotificationNameMyBidReloadData @"kNotificationNameMyBidReloadData"
#define kNotificationNameMyTransferReloadData @"kNotificationNameMyTransferReloadData"
#define kNotificationNameMyCardsReloadData @"kNotificationNameMyCardsReloadData"
#define kNotificationNameLoadConfirmData @"kNotificationNameLoadConfirmData"
#define kNotificationNameFlowFilterReloadData @"kNotificationNameFlowFilterReloadData"
#define kNotificationNameAccountFilterReloadData @"kNotificationNameAccountFilterReloadData"
#define kNotificationNameOrderFilterReloadData @"kNotificationNameOrderFilterReloadData"
#define kNotificationNameMemberGiftReloadData @"kNotificationNameMemberGiftReloadData"
#define kNotificationNameProfileJump2Recharge @"kNotificationNameProfileJump2Recharge"

typedef void (^BOOLBlock)(BOOL result);
typedef void (^VoidBlock)(void);


#endif
