//
//  main.m
//  TestForLearn
//
//  Created by Qu,Ke on 2020/4/10.
//  Copyright © 2020 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "fishhook.h"
#import "NSMYBlock.h"

static void (*orig_nslog)(NSString *format, ...);
    
void my_NSLog(NSString *format, ...){
    return orig_nslog(format);
}


int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
        
    /*
    b: 获取cmd, 查找到section(__DATA,__la_symbol_prt)

            因此动态库中函数的地址在一开始是不知道的，所以这些函数的地址存放在__DATA,__la_symbol_prt表中，也就是所谓的PIC(位置无关代码)。在函数第一次调用的时候例如NSLog()函数，这个表中的地址不是直接指向NSLog的正确地址，而是指向了dyld_stub_binder函数地址，它的作用就是去计算出NSLog的真正地址，然后将__DATA,__la_symbol_prt中NSLog对应的地址改为它的实际地址，这样第二次调用的时候就是直接调用到NSLog

            获取__la_symbol_prt 地址

            void **indirect_symbol_bindings = (void **)((uintptr_t)slide + section->addr);

    c: 计算symtab 地址，strtab地址，indirect Symbols 地址


            symtab                  base + symtab_cmd->symoff
            strtab                 base + symtab_cmd->stroff
            indirect_symtab      base + dysymtab_cmd->indirectsymoff

    d:  相互关系

            indirect_symtab[index + section.reverse1] 获取symtab对于的index
            
            //从Symbol Table中找到符号在String Table中的偏移量
            uint32_t strtab_offset = symtab[symtab_index].n_un.n_strx;

            //String Table的起始地址 + 偏移量，得到符号的名称
            char *symbol_name = strtab + strtab_offset;

            //函数实现地址
            indirect_symbol_bindings[index];
    */
    
//    struct rebinding rebn;
//    rebn.name = "NSLog";
//    rebn.replacement = my_NSLog;
//    rebn.replaced = (void *) &orig_nslog;
//
//    rebind_symbols((struct rebinding[1]){rebn}, 1);
//
//    NSLog(@"HEllo");
//    NSMYBlock *hock = [NSMYBlock new];
//    NSMYBlock *hockc = [hock copy];
    
    NSMutableString * m = [NSMutableString stringWithFormat:@"222"];
    NSLog(@"0x%p copy:0x%p",m,[m copy]);
    
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
