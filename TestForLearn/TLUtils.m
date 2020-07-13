//
//  TLUtils.m
//  TestForLearn
//
//  Created by Qu,Ke on 2020/7/10.
//  Copyright © 2020 baidu. All rights reserved.
//

#import "TLUtils.h"

@implementation TLUtils

+ (NSUInteger)imageMemoryLength:(UIImage *)image {
    
    size_t bytesperRow = CGImageGetBitsPerPixel(image.CGImage);
    return image.size.height * image.size.width * bytesperRow / 8;
}

+ (UIImage *)scaleImage:(UIImage *)image ToDatalength:(NSUInteger)length {
    if (length == 0) {
        return image;
    }
    
    size_t bytesperRow = CGImageGetBitsPerPixel(image.CGImage);
    
    CGFloat heigth = image.size.height;
    CGFloat width = image.size.width;
    CGFloat scale = heigth / width;
    
    // length = scale * width * width * bytesperRow / 8;
    CGFloat finalWidth = floor(sqrt(length * 8 / (bytesperRow * scale)));
    CGFloat finalHeight = floor(finalWidth * scale);
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(finalWidth, finalHeight), YES, 1);
    [image drawInRect:CGRectMake(0, 0, finalWidth, finalHeight)];
    UIImage * scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    return scaledImage;
    
}

+ (UIImage *)scaleImage:(UIImage *)image size:(CGFloat)size {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(size, size), YES, 1);
    
    CGFloat x, y, w, h;
    CGFloat imageW = image.size.width;
    CGFloat imageH = image.size.height;
    if (imageW > imageH) {
        w = imageW / imageH * size;
        h = size;
        x = (size - w) / 2;
        y = 0;
    } else {
        h = imageH / imageW * size;
        w = size;
        y = (size - h) / 2;
        x = 0;
    }
    
    [image drawInRect:CGRectMake(x, y, w, h)];
    UIImage * scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

+ (CVPixelBufferRef)pixelBufferFromCGImage:(CGImageRef)image {
    NSDictionary *options = @{
                              (NSString *)kCVPixelBufferCGImageCompatibilityKey : @YES,
                              (NSString *)kCVPixelBufferCGBitmapContextCompatibilityKey : @YES,
                              (NSString *)kCVPixelBufferIOSurfacePropertiesKey: [NSDictionary dictionary]
                              };
    CVPixelBufferRef pxbuffer = NULL;
    
    CGFloat frameWidth = CGImageGetWidth(image);
    CGFloat frameHeight = CGImageGetHeight(image);
    
    CVReturn status = CVPixelBufferCreate(kCFAllocatorDefault,
                                          frameWidth,
                                          frameHeight,
                                          kCVPixelFormatType_32BGRA,
                                          (__bridge CFDictionaryRef) options,
                                          &pxbuffer);
    
    NSParameterAssert(status == kCVReturnSuccess && pxbuffer != NULL);
    
    CVPixelBufferLockBaseAddress(pxbuffer, 0);
    void *pxdata = CVPixelBufferGetBaseAddress(pxbuffer);
    NSParameterAssert(pxdata != NULL);
    
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(pxdata,
                                                 frameWidth,
                                                 frameHeight,
                                                 8,
                                                 CVPixelBufferGetBytesPerRow(pxbuffer),
                                                 rgbColorSpace,
                                                 (CGBitmapInfo)kCGImageAlphaNoneSkipFirst);
    NSParameterAssert(context);
    CGContextConcatCTM(context, CGAffineTransformIdentity);
    CGContextDrawImage(context, CGRectMake(0,
                                           0,
                                           frameWidth,
                                           frameHeight),
                       image);
    CGColorSpaceRelease(rgbColorSpace);
    CGContextRelease(context);
    
    CVPixelBufferUnlockBaseAddress(pxbuffer, 0);
    
    return pxbuffer;
}

@end
