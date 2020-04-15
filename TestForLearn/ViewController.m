//
//  ViewController.m
//  TestForLearn
//
//  Created by Qu,Ke on 2020/4/10.
//  Copyright © 2020 baidu. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

+ (void)test {
    NSLog(@"xxx");
}

- (void)test {
    NSLog(@"----");
}

- (void)loadView {
    NSLog(@"");
}
@end
