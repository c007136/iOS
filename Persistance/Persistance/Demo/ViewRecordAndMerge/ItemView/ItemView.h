//
//  ItemView.h
//  Persistance
//
//  Created by muyu on 2018/6/14.
//  Copyright © 2018年 muyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemView : UIView

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *detail;

@property (nonatomic, strong) NSString *thisPropertyWillNotBeSaved;

@end
