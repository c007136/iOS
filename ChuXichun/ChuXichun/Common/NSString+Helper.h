//
//  NSString+Helper.h
//
//  字符串扩展类
//  小萌科技
//
//  Created maike on 14-3-17.
//  Copyright (c) 2014年 赚泡泡. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Helper)

- (NSString *)md5;
- (NSString *)toGBK;
- (NSString *)trim;
- (NSString *)urlEncode;

@end
