//
// MobileNet.h
//
// This file was automatically generated and should not be edited.
//

#import <Foundation/Foundation.h>
#import <CoreML/CoreML.h>
#include <stdint.h>

NS_ASSUME_NONNULL_BEGIN


/// Model Prediction Input Type
API_AVAILABLE(macos(10.13), ios(11.0), watchos(4.0), tvos(11.0)) __attribute__((visibility("hidden")))
@interface MobileNetInput : NSObject<MLFeatureProvider>

/// Input image to be classified as color (kCVPixelFormatType_32BGRA) image buffer, 224 pixels wide by 224 pixels high
@property (readwrite, nonatomic) CVPixelBufferRef data;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithData:(CVPixelBufferRef)data;
@end


/// Model Prediction Output Type
API_AVAILABLE(macos(10.13), ios(11.0), watchos(4.0), tvos(11.0)) __attribute__((visibility("hidden")))
@interface MobileNetOutput : NSObject<MLFeatureProvider>

/// Probability of each category as dictionary of strings to doubles
@property (readwrite, nonatomic, strong) NSDictionary<NSString *, NSNumber *> * prob;

/// Most likely image category as string value
@property (readwrite, nonatomic, strong) NSString * classLabel;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithProb:(NSDictionary<NSString *, NSNumber *> *)prob classLabel:(NSString *)classLabel;
@end


/// Class for model loading and prediction
API_AVAILABLE(macos(10.13), ios(11.0), watchos(4.0), tvos(11.0)) __attribute__((visibility("hidden")))
@interface MobileNet : NSObject
@property (readonly, nonatomic, nullable) MLModel * model;
- (nullable instancetype)init;
- (nullable instancetype)initWithContentsOfURL:(NSURL *)url error:(NSError * _Nullable __autoreleasing * _Nullable)error;
- (nullable instancetype)initWithConfiguration:(MLModelConfiguration *)configuration error:(NSError * _Nullable __autoreleasing * _Nullable)error API_AVAILABLE(macos(10.14), ios(12.0), watchos(5.0), tvos(12.0)) __attribute__((visibility("hidden")));
- (nullable instancetype)initWithContentsOfURL:(NSURL *)url configuration:(MLModelConfiguration *)configuration error:(NSError * _Nullable __autoreleasing * _Nullable)error API_AVAILABLE(macos(10.14), ios(12.0), watchos(5.0), tvos(12.0)) __attribute__((visibility("hidden")));

/**
    Make a prediction using the standard interface
    @param input an instance of MobileNetInput to predict from
    @param error If an error occurs, upon return contains an NSError object that describes the problem. If you are not interested in possible errors, pass in NULL.
    @return the prediction as MobileNetOutput
*/
- (nullable MobileNetOutput *)predictionFromFeatures:(MobileNetInput *)input error:(NSError * _Nullable __autoreleasing * _Nullable)error;

/**
    Make a prediction using the standard interface
    @param input an instance of MobileNetInput to predict from
    @param options prediction options
    @param error If an error occurs, upon return contains an NSError object that describes the problem. If you are not interested in possible errors, pass in NULL.
    @return the prediction as MobileNetOutput
*/
- (nullable MobileNetOutput *)predictionFromFeatures:(MobileNetInput *)input options:(MLPredictionOptions *)options error:(NSError * _Nullable __autoreleasing * _Nullable)error;

/**
    Make a prediction using the convenience interface
    @param data Input image to be classified as color (kCVPixelFormatType_32BGRA) image buffer, 224 pixels wide by 224 pixels high:
    @param error If an error occurs, upon return contains an NSError object that describes the problem. If you are not interested in possible errors, pass in NULL.
    @return the prediction as MobileNetOutput
*/
- (nullable MobileNetOutput *)predictionFromData:(CVPixelBufferRef)data error:(NSError * _Nullable __autoreleasing * _Nullable)error;

/**
    Batch prediction
    @param inputArray array of MobileNetInput instances to obtain predictions from
    @param options prediction options
    @param error If an error occurs, upon return contains an NSError object that describes the problem. If you are not interested in possible errors, pass in NULL.
    @return the predictions as NSArray<MobileNetOutput *>
*/
- (nullable NSArray<MobileNetOutput *> *)predictionsFromInputs:(NSArray<MobileNetInput*> *)inputArray options:(MLPredictionOptions *)options error:(NSError * _Nullable __autoreleasing * _Nullable)error API_AVAILABLE(macos(10.14), ios(12.0), watchos(5.0), tvos(12.0)) __attribute__((visibility("hidden")));
@end

NS_ASSUME_NONNULL_END
