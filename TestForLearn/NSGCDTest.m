//
//  NSGCDTest.m
//  TestForLearn
//
//  Created by Qu,Ke on 2020/5/28.
//  Copyright © 2020 baidu. All rights reserved.
//

#import "NSGCDTest.h"

@interface NSGCDTest(){
    dispatch_queue_t _queue;
}

@end

@implementation NSGCDTest

- (void)testAsyRead {
    NSLog(@"testAsyRead %ld",[self count]);
}


- (NSInteger)count {
    
    if (!_queue) {
        _queue = dispatch_queue_create("testAsyRead_quene", DISPATCH_QUEUE_CONCURRENT);
    }
    __block NSInteger tempCountFlag = 0;
    dispatch_sync(_queue, ^{
        sleep(1);
        tempCountFlag = 20;
    });
    return tempCountFlag;
}

- (void)gcdGroudTest {
        
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_apply(3, queue, ^(size_t i) {
//        NSLog(@"%d",i);
//    });
//
//
//    return;
    
    __block NSInteger number = 0;
    
    dispatch_group_t group = dispatch_group_create();
    
    //A耗时操作
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"A耗时操作");
        sleep(3);
        number += 2222;
    });
    
    //B网络请求
    dispatch_group_enter(group);
    [self sendRequestWithCompletion:^(id response) {
        number += [response integerValue];
        
        NSLog(@"B耗时操作");

        dispatch_group_leave(group);
    }];
    
    //C网络请求
    dispatch_group_enter(group);
    [self sendRequestWithCompletion:^(id response) {
        number += [response integerValue];
        NSLog(@"C耗时操作");
        dispatch_group_leave(group);
    }];
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"Cdispatch_group_notify");
    });
    
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    NSLog(@"dispatch_group_wait");

}

- (void)sendRequestWithCompletion:(void (^)(id response))completion {
      //模拟一个网络请求
      dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
      dispatch_async(queue, ^{
          sleep(2);
          if (completion) completion(@1111);

      });
  }

@end
