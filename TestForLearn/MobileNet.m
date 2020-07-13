//
// MobileNet.m
//
// This file was automatically generated and should not be edited.
//

#import "MobileNet.h"

@implementation MobileNetInput

- (instancetype)initWithData:(CVPixelBufferRef)data {
    if (self) {
        _data = data;
    }
    return self;
}

- (NSSet<NSString *> *)featureNames {
    return [NSSet setWithArray:@[@"data"]];
}

- (nullable MLFeatureValue *)featureValueForName:(NSString *)featureName {
    if ([featureName isEqualToString:@"data"]) {
        return [MLFeatureValue featureValueWithPixelBuffer:_data];
    }
    return nil;
}

@end

@implementation MobileNetOutput

- (instancetype)initWithProb:(NSDictionary<NSString *, NSNumber *> *)prob classLabel:(NSString *)classLabel {
    if (self) {
        _prob = prob;
        _classLabel = classLabel;
    }
    return self;
}

- (NSSet<NSString *> *)featureNames {
    return [NSSet setWithArray:@[@"prob", @"classLabel"]];
}

- (nullable MLFeatureValue *)featureValueForName:(NSString *)featureName {
    if ([featureName isEqualToString:@"prob"]) {
        return [MLFeatureValue featureValueWithDictionary:_prob error:nil];
    }
    if ([featureName isEqualToString:@"classLabel"]) {
        return [MLFeatureValue featureValueWithString:_classLabel];
    }
    return nil;
}

@end

@implementation MobileNet

+ (NSURL *)urlOfModelInThisBundle {
    NSString *assetPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"MobileNet" ofType:@"mlmodelc"];
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

- (nullable MobileNetOutput *)predictionFromFeatures:(MobileNetInput *)input error:(NSError * _Nullable __autoreleasing * _Nullable)error {
    return [self predictionFromFeatures:input options:[[MLPredictionOptions alloc] init] error:error];
}

- (nullable MobileNetOutput *)predictionFromFeatures:(MobileNetInput *)input options:(MLPredictionOptions *)options error:(NSError * _Nullable __autoreleasing * _Nullable)error {
    id<MLFeatureProvider> outFeatures = [_model predictionFromFeatures:input options:options error:error];
    return [[MobileNetOutput alloc] initWithProb:(NSDictionary<NSString *, NSNumber *> *)[outFeatures featureValueForName:@"prob"].dictionaryValue classLabel:[outFeatures featureValueForName:@"classLabel"].stringValue];
}

- (nullable MobileNetOutput *)predictionFromData:(CVPixelBufferRef)data error:(NSError * _Nullable __autoreleasing * _Nullable)error {
    MobileNetInput *input_ = [[MobileNetInput alloc] initWithData:data];
    return [self predictionFromFeatures:input_ error:error];
}

- (nullable NSArray<MobileNetOutput *> *)predictionsFromInputs:(NSArray<MobileNetInput*> *)inputArray options:(MLPredictionOptions *)options error:(NSError * _Nullable __autoreleasing * _Nullable)error {
    id<MLBatchProvider> inBatch = [[MLArrayBatchProvider alloc] initWithFeatureProviderArray:inputArray];
    id<MLBatchProvider> outBatch = [_model predictionsFromBatch:inBatch options:options error:error];
    NSMutableArray<MobileNetOutput*> *results = [NSMutableArray arrayWithCapacity:(NSUInteger)outBatch.count];
    for (NSInteger i = 0; i < outBatch.count; i++) {
        id<MLFeatureProvider> resultProvider = [outBatch featuresAtIndex:i];
        MobileNetOutput * result = [[MobileNetOutput alloc] initWithProb:(NSDictionary<NSString *, NSNumber *> *)[resultProvider featureValueForName:@"prob"].dictionaryValue classLabel:[resultProvider featureValueForName:@"classLabel"].stringValue];
        [results addObject:result];
    }
    return results;
}

@end
