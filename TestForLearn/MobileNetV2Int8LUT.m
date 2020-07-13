//
// MobileNetV2Int8LUT.m
//
// This file was automatically generated and should not be edited.
//

#import "MobileNetV2Int8LUT.h"

@implementation MobileNetV2Int8LUTInput

- (instancetype)initWithImage:(CVPixelBufferRef)image {
    if (self) {
        _image = image;
    }
    return self;
}

- (NSSet<NSString *> *)featureNames {
    return [NSSet setWithArray:@[@"image"]];
}

- (nullable MLFeatureValue *)featureValueForName:(NSString *)featureName {
    if ([featureName isEqualToString:@"image"]) {
        return [MLFeatureValue featureValueWithPixelBuffer:_image];
    }
    return nil;
}

@end

@implementation MobileNetV2Int8LUTOutput

- (instancetype)initWithClassLabelProbs:(NSDictionary<NSString *, NSNumber *> *)classLabelProbs classLabel:(NSString *)classLabel {
    if (self) {
        _classLabelProbs = classLabelProbs;
        _classLabel = classLabel;
    }
    return self;
}

- (NSSet<NSString *> *)featureNames {
    return [NSSet setWithArray:@[@"classLabelProbs", @"classLabel"]];
}

- (nullable MLFeatureValue *)featureValueForName:(NSString *)featureName {
    if ([featureName isEqualToString:@"classLabelProbs"]) {
        return [MLFeatureValue featureValueWithDictionary:_classLabelProbs error:nil];
    }
    if ([featureName isEqualToString:@"classLabel"]) {
        return [MLFeatureValue featureValueWithString:_classLabel];
    }
    return nil;
}

@end

@implementation MobileNetV2Int8LUT

+ (NSURL *)urlOfModelInThisBundle {
    NSString *assetPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"MobileNetV2Int8LUT" ofType:@"mlmodelc"];
    return [NSURL fileURLWithPath:assetPath];
}

- (nullable instancetype)init {
        return [self initWithContentsOfURL:self.class.urlOfModelInThisBundle error:nil];
}

- (nullable instancetype)initWithContentsOfURL:(NSURL *)url error:(NSError * _Nullable __autoreleasing * _Nullable)error {
    self = [super init];
    if (!self) { return nil; }
    _model = [MLModel modelWithContentsOfURL:url error:error];
    if (_model == nil) { return nil; }
    return self;
}

- (nullable instancetype)initWithConfiguration:(MLModelConfiguration *)configuration error:(NSError * _Nullable __autoreleasing * _Nullable)error {
        return [self initWithContentsOfURL:self.class.urlOfModelInThisBundle configuration:configuration error:error];
}

- (nullable instancetype)initWithContentsOfURL:(NSURL *)url configuration:(MLModelConfiguration *)configuration error:(NSError * _Nullable __autoreleasing * _Nullable)error {
    self = [super init];
    if (!self) { return nil; }
    _model = [MLModel modelWithContentsOfURL:url configuration:configuration error:error];
    if (_model == nil) { return nil; }
    return self;
}

- (nullable MobileNetV2Int8LUTOutput *)predictionFromFeatures:(MobileNetV2Int8LUTInput *)input error:(NSError * _Nullable __autoreleasing * _Nullable)error {
    return [self predictionFromFeatures:input options:[[MLPredictionOptions alloc] init] error:error];
}

- (nullable MobileNetV2Int8LUTOutput *)predictionFromFeatures:(MobileNetV2Int8LUTInput *)input options:(MLPredictionOptions *)options error:(NSError * _Nullable __autoreleasing * _Nullable)error {
    id<MLFeatureProvider> outFeatures = [_model predictionFromFeatures:input options:options error:error];
    return [[MobileNetV2Int8LUTOutput alloc] initWithClassLabelProbs:(NSDictionary<NSString *, NSNumber *> *)[outFeatures featureValueForName:@"classLabelProbs"].dictionaryValue classLabel:[outFeatures featureValueForName:@"classLabel"].stringValue];
}

- (nullable MobileNetV2Int8LUTOutput *)predictionFromImage:(CVPixelBufferRef)image error:(NSError * _Nullable __autoreleasing * _Nullable)error {
    MobileNetV2Int8LUTInput *input_ = [[MobileNetV2Int8LUTInput alloc] initWithImage:image];
    return [self predictionFromFeatures:input_ error:error];
}

- (nullable NSArray<MobileNetV2Int8LUTOutput *> *)predictionsFromInputs:(NSArray<MobileNetV2Int8LUTInput*> *)inputArray options:(MLPredictionOptions *)options error:(NSError * _Nullable __autoreleasing * _Nullable)error {
    id<MLBatchProvider> inBatch = [[MLArrayBatchProvider alloc] initWithFeatureProviderArray:inputArray];
    id<MLBatchProvider> outBatch = [_model predictionsFromBatch:inBatch options:options error:error];
    NSMutableArray<MobileNetV2Int8LUTOutput*> *results = [NSMutableArray arrayWithCapacity:(NSUInteger)outBatch.count];
    for (NSInteger i = 0; i < outBatch.count; i++) {
        id<MLFeatureProvider> resultProvider = [outBatch featuresAtIndex:i];
        MobileNetV2Int8LUTOutput * result = [[MobileNetV2Int8LUTOutput alloc] initWithClassLabelProbs:(NSDictionary<NSString *, NSNumber *> *)[resultProvider featureValueForName:@"classLabelProbs"].dictionaryValue classLabel:[resultProvider featureValueForName:@"classLabel"].stringValue];
        [results addObject:result];
    }
    return results;
}

@end
