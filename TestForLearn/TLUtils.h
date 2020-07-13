//
//  TLUtils.h
//  TestForLearn
//
//  Created by Qu,Ke on 2020/7/10.
//  Copyright © 2020 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TLUtils : NSObject

+ (UIImage *)scaleImage:(UIImage *)image size:(CGFloat)size;
+ (UIImage *)scaleImageToDatalength:(NSUInteger)length;

+ (CVPixelBufferRef)pixelBufferFromCGImage:(CGImageRef)image;

+ (NSUInteger)imageMemoryLength:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
