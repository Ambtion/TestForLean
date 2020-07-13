//
//  ViewController.m
//  TestForLearn
//
//  Created by Qu,Ke on 2020/4/10.
//  Copyright © 2020 baidu. All rights reserved.
//

#import "ViewController.h"
#import "TLUtils.h"
#import "MobileNetV2Int8LUT.h"

#import <AFNetworking/AFNetworking.h>

@interface ViewController ()

@property(nonatomic, strong)UILabel *label;
@property(nonatomic, strong)UIImageView *imageView;
@end


@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.imageView = [[UIImageView alloc] init];
    self.imageView.frame = CGRectMake(0, 0, 200, 200);
    self.imageView.image = [UIImage imageNamed:@"cat.jpg"];
    [self.view addSubview:self.imageView];
    
//    NSLog(@"length %lu", [TLUtils imageMemoryLength:imageView.image]);
//    UIImage * saleImage  = [TLUtils scaleImage:imageView.image ToDatalength:600000];
//    imageView.image = saleImage;
//    NSLog(@"length %lu", [TLUtils imageMemoryLength:imageView.image]);

    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 200)];
    [self.view addSubview:self.label];

    [self downModule];
    
}

- (void)downModule {
    
    __weak typeof(self) weakSelf = self;
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];

    // http_serve
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://127.0.0.1:8080/%@",[self _fileName]]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];

    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {

         NSString *tmpPath = NSTemporaryDirectory();
         NSString *tmpModelPath = [tmpPath stringByAppendingPathComponent:[self _fileName]];
         return [NSURL fileURLWithPath:tmpModelPath];
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        
        [weakSelf _compileModelWithUrl:filePath];
        [weakSelf _predict:weakSelf.imageView.image];
    }];
    

    [downloadTask resume];
    
    
}


#pragma mark - File Manu
#pragma mark dic

/*
 Document //用户生成的数据（聊天记录，下载的文件等），将应用程序的数据文件保存在该目录下。不过这些数据类型仅限于不可再生的数据，会被iTunes同步。
 Library //苹果建议用来存放默认设置或其它状态信息。
 ----Library/Cache // 主要是缓存文件，保存那些可再生的文件，比如网络请求的数据。鉴于此，应用程序通常还需要负责删除这些文件。不会被iTunes同步。
 ----Library/Preferences //应用程序的偏好设置文件。我们使用NSUserDefaults写的设置数据都会保存到该目录下的一个plist文件中。会被iTunes同步
 Temp //各种临时文件，保存应用再次启动时不需要的文件。该目录下的东西随时有可能被系统清理掉。不会被iTunes同步
 
 https://medium.com/@lucideus/understanding-the-structure-of-an-ios-application-a3144f1140d4#:~:text=The%20Bundle%20directory%20or%20the,particular%20version%20of%20an%20application.
 
 https://developer.apple.com/library/archive/documentation/General/Conceptual/iCloudDesignGuide/Chapters/iCloudFundametals.html
 
 https://www.jianshu.com/p/50348b35c986
 
 */

- (NSString *)_modulDecoment {
    
    NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *moduleDic = [document stringByAppendingPathComponent:@"Module"];
    [self _tryCreateDic:moduleDic];
    return moduleDic;
}

- (void)_tryCreateDic:(NSString *)dirPath {
    
    NSError *error;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:dirPath]) {
       return;
    }

    NSInteger try = 1;
    do {
        
        [[NSFileManager defaultManager] createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:&error];
        
        if (error) {
            NSLog(@"%@ ",error);
        }
        
    } while (--try);
    
}

#pragma mark - 编译文件 mlmodelc
- (NSString *)_mlmoduelcPath {
    return  [[self _modulDecoment] stringByAppendingPathComponent:@"MobileNet.mlmodelc"];;
}

- (NSString *)_fileName {
    return @"MobileNetV2Int8LUT.mlmodel";
}

- (void)_removeItemAtPath:(NSString *)path {
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    }
}

/*
    https://developer.apple.com/documentation/coreml/reducing_the_size_of_your_core_ml_app
 
 */

- (void)_compileModelWithUrl:(NSURL *)modleUrl {
    
    NSError *error;
        
    NSURL *tmpModelcPathURL = [MLModel compileModelAtURL:modleUrl error:&error];
    if (error) {
        NSLog(@"%@", error);
        return;
    }
   
    NSString * docModelcPath = [self _mlmoduelcPath];
    [self _removeItemAtPath:docModelcPath];
   
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isSucess = [fileManager moveItemAtURL:tmpModelcPathURL toURL:[NSURL fileURLWithPath:docModelcPath] error:&error];
    if (error || !isSucess) {
        NSLog(@"%@", error);
    }
    
}

- (void)_predict:(UIImage *)image {

    NSString *docPath = [self _mlmoduelcPath];
    NSURL *url = [NSURL fileURLWithPath:docPath];
    
    NSError *error = nil;
    
    MobileNetV2Int8LUT *model = [[MobileNetV2Int8LUT alloc] initWithContentsOfURL:url error:&error];
    if (error) {
        NSLog(@"%@", error);
        return;
    }
      
    UIImage *scaleImage = [TLUtils scaleImage:image size:224];
    CVPixelBufferRef buffer = [TLUtils pixelBufferFromCGImage:scaleImage.CGImage];

    MobileNetV2Int8LUTInput *input = [[MobileNetV2Int8LUTInput alloc] initWithImage:buffer];

    //predict
    MobileNetV2Int8LUTOutput *output = [model predictionFromFeatures:input error:&error];
    if (error) {
        NSLog(@"%@", error);
        return;
    }
    
    //显示
    dispatch_async(dispatch_get_main_queue(), ^{
        self.label.text = output.classLabel;
    });
    
}

@end
