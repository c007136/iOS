//
//  MAPersistanceConfiguration.h
//  Persistance
//
//  Created by muyu on 2018/6/14.
//  Copyright © 2018年 muyu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSUInteger, MAPersistanceErrorCode) {
    MAPersistanceErrorCodeOpenError,
    MAPersistanceErrorCodeCreateError,
    MAPersistanceErrorCodeQueryStringError,
    MAPersistanceErrorCodeInsertError,
    MAPersistanceErrorCodeUpdateError,
};
