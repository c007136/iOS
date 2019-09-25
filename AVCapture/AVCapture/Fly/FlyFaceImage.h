//
//  FlyFaceImage.h
//  AVCapture
//
//  Created by muyu on 2019/9/6.
//  Copyright © 2019 muyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FlyFaceImage : NSObject

@property (nonatomic, strong) NSData *data;

@property (nonatomic, assign) CGFloat width;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) NSInteger direction;

@end

NS_ASSUME_NONNULL_END
