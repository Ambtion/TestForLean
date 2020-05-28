//
//  ViewController.m
//  TestForLearn
//
//  Created by Qu,Ke on 2020/4/10.
//  Copyright © 2020 baidu. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "NSMYBlock.h"
#import "NSGCDTest.h"


@interface MYNSNode : NSObject
@property (nonatomic, strong)NSString * name;
@property (nonatomic, strong)id next;
@end

@implementation MYNSNode
@end



@interface ViewController ()
@property (nonatomic, strong)MYNSNode * node;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSGCDTest new] testAsyRead];
    
//    NSLog(@"class_isMetaClass %d",class_isMetaClass([MYNSNode class]));
    
//    NSMutableString * a = [NSMutableString stringWithString:@"aaa"];
//    NSMutableSet * set = [NSMutableSet setWithCapacity:0];
//    [set addObject:a];
//    [a appendString:@"b"];
//    NSLog(@"%@",set);
//
//    NSHashTable *hashTable = [NSHashTable hashTableWithOptions:NSPointerFunctionsCopyIn];
//    [hashTable addObject:@"hello"];
////    [hashTable addObject:self];
//    [hashTable addObject:@"world"];
//    [hashTable removeObject:@"world"];
//    NSLog(@"Members: %@", [hashTable allObjects]);
//
//    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
//    [array addObject:a];
//    [a appendString:@"b"];
//    NSLog(@"%@",array);
//
//    NSString * fileS = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
//                                                            NSUserDomainMask, YES) lastObject];
//    NSLog(@"fileS %@",fileS);
//
////    NSArray * urls = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
////
////    NSLog(@"urlS %@",urls);
//
//
//    [[NSFileManager defaultManager] createFileAtPath:[NSString stringWithFormat:@"%@/tmp1",fileS] contents:nil attributes:nil];
//    NSMutableDictionary * dic =  [NSMutableDictionary dictionaryWithCapacity:0];
//    [dic setValue:nil forKey:@"aaa"];
    
//    return;
//    [self createNodelList];
//    [self printNode];
//
//    self.node = [self reverNode:self.node];
//    [self printNode];
//
//    self.node = [self reverNode2:self.node];
//    [self printNode];
   
//    [self initTestButton];
    
//    [[NSMYBlock new] gcdGroudTest];
    
    
}

- (void)initTestButton {
#ifdef DEBUG
    UIButton *testButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    testButton.frame = CGRectMake(0, 100, 44, 44);
    testButton.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
    testButton.layer.cornerRadius = 22.f;
    [testButton addTarget:self action:@selector(testButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:testButton];
    
#endif

}

- (void)testButtonDidClick:(id)sender {
    
    UIApplication *appll =  [UIApplication sharedApplication];
    id oneOc = [appll valueForKeyPath:@"_statusBar"];
}

- (void)createNodelList {
    MYNSNode * node1 = [MYNSNode new];
    node1.name = @"1";
    
    MYNSNode * node2 = [MYNSNode new];
    node2.name = @"2";
    
    MYNSNode * node3 = [MYNSNode new];
    node3.name = @"3";
    
    MYNSNode * node4 = [MYNSNode new];
    node4.name = @"4";
    
    self.node = node1;
    node1.next = node2;
    node2.next = node3;
    node3.next = node4;
    
    
    
}

- (void)printNode {
    
    MYNSNode * node = self.node;
    while (node) {
        NSLog(@"node %@",node.name);
        node = node.next;
    }
}

- (MYNSNode *)reverNode:(MYNSNode *)node {
    
    MYNSNode * result =  [MYNSNode new];
    MYNSNode * curNode = node;
    
    while (curNode) {
        
        MYNSNode * temp = curNode.next;
        
        curNode.next = result.next;
        result.next = curNode;
        
        curNode = temp;
    }
    
    return result.next;
}


- (MYNSNode *)reverNode2:(MYNSNode *)node {
    
    MYNSNode * result =  nil;
    MYNSNode * curNode = node;

    
    while (curNode) {
        
        MYNSNode * temp = curNode.next;
        
        curNode.next = result;
        result = curNode;
        
        curNode = temp;
    }
    
    return result;
}





@end
