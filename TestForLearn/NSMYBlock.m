//
//  NSBlock.m
//  TestForLearn
//
//  Created by Qu,Ke on 2020/4/24.
//  Copyright © 2020 baidu. All rights reserved.
//

#import "NSMYBlock.h"

@implementation NSMYBlock

+ (void)testBlock { //global
    
    void (^uncatch)(void) = ^{ // __NSGlobalBlock__
        NSLog(@"block");
    };
    
    static int b = 2;
    void (^catchLocalStaticArg)(void) = ^{ //__NSGlobalBlock__
           NSLog(@"block1 %d",b);
    };
    
    NSLog(@"catchLocalStaticArg = %@ ",[catchLocalStaticArg class]);

    static NSString * text2  = @"xxxx";
    void (^catchLocalStaticStr)(void) = ^{ //__NSGlobalBlock__
        NSLog(@"block1 %@",text2);
    };
    
    
    int a = 0;
    void (^catchLocalArg)(void) = ^{ // __NSMallocBlock__
        // int a = __cself->a; // bound by copy
        NSLog(@"block1 %d",a);
    };
    
    NSString * text = @"112";
    void(^catchLocalString)(void) = ^{ // __NSMallocBlock__
        // NSString *__strong text = __cself->text; // bound by copy
        
        NSLog(@"%s == %@",__FUNCTION__,text);
    };
    NSLog(@"catchLocalString = %@ ",[catchLocalString class]);
    
    __weak typeof(self) weakSelf = self;
    void (^catchWeak)(void) = ^{ // __NSMallocBlock__ copy_6
        NSLog(@"block1 %@",weakSelf);
        // __weak typeof (self) weakSelf = __cself->weakSelf; // bound by copy
    };
    NSLog(@"catchWeak = %@ ",[catchLocalString class]);

    NSObject * ob = [NSObject new];
    void (^catchStrong)(void) = ^{ // __NSMallocBlock__ copy
        // NSObject *__strong ob = __cself->ob; // bound by copy
        
        NSLog(@"block1 %@",ob);
    };
    
    NSLog(@"catchStrong = %@ ",[catchStrong class]);

    __block int m =  0;
    void (^cathcBlock)(void) = ^{ // __NSMallocBlock__ copy
        //   __Block_byref_m_0 *m = __cself->m; // bound by ref
        m = 2;
    };
    
    NSLog(@"+++cathcBlock %@",[cathcBlock class]);
    
//    dispatch_semaphore_t
}
/*
 * 静态全局                 global                           无copy
 * 地址在栈，                malloc block (网上说stack_block) 无copy
 * 地址在堆，                malloc block copy  ，
                _Block_object_assign函数会根据auto变量的修饰符（__strong、__weak、__unsafe_unretained）做出相应的操作，形成强引用（retain）或者弱引用
                block_dispose函数内部会调用_Block_object_dispose函数
 *
 */


@end
