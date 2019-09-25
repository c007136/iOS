//
//  DlibWrapper.h
//  AVCapture
//
//  Created by muyu on 2019/9/6.
//  Copyright © 2019 muyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMedia/CoreMedia.h>

NS_ASSUME_NONNULL_BEGIN

@interface DlibWrapper : NSObject

- (void)prepare;

- (void)doWorkOnSampleBuffer:(CMSampleBufferRef)sampleBuffer inRects:(NSArray<NSValue *> *)rects;

@end

NS_ASSUME_NONNULL_END
