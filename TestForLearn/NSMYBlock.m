//
//  NSBlock.m
//  TestForLearn
//
//  Created by Qu,Ke on 2020/4/24.
//  Copyright © 2020 baidu. All rights reserved.
//

#import "NSMYBlock.h"

/*
  * http://clang.llvm.org/docs/Block-ABI-Apple.html
  * clang -rewrite-objc MyClass.m
    support weak https://stackoverflow.com/questions/40946716/how-to-use-weak-reference-in-clang
  * clang -rewrite-objc -fobjc-arc -stdlib=libc++ -mmacosx-version-min=10.7 -fobjc-runtime=macosx-10.7 -Wno-deprecated-declarations keke.m
 */

@implementation NSMYBlock

- (void)testBlock { //global
    
//    __weak typeof(self) weakSelf = self;
    __block int qka = 12;
    void (^myTestBlok)(void) = ^{
//        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSLog(@"%@ hello %d",self, qka);
    };
    self.block = myTestBlok;
    
    myTestBlok();
}


@end
