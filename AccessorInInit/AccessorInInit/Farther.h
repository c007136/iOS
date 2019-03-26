//
//  Farther.h
//  AccessorInInit
//
//  Created by muyu on 2018/11/29.
//  Copyright © 2018 muyu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Father : NSObject
@property (nonatomic, strong) NSString               * fatherString;
@end

//
//  Child
//
@interface Child : Father
@property (nonatomic, strong) NSString               * childString;
@end 
