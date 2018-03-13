//
//  DemoManager.m
//  XXXX
//
//  Created by luochenxun on 2018/1/3.
//  Copyright © 2018年 Kacha-Mobile. All rights reserved.
//

#import "DemoManager.h"
#import "DemoDataModel.h"
#import "DemoController.h"
#import "DemoMDController.h"

@interface DemoManager ()

/**
 管理所有App生命周期服务
 */
@property (nonatomic, strong) NSMutableArray<DemoDataModel *> *demos;

@end

@implementation DemoManager

#pragma mark - < Init Methods >

+ (instancetype)sharedManager {
    static DemoManager *demoManager = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        demoManager = [[DemoManager alloc] init];
    });
    return demoManager;
}


- (instancetype)init {
    if (self = [super init]) {
        _demos = [NSMutableArray arrayWithCapacity:10];
    }
    return self;
}


#pragma mark - < Interfaces >

- (void)registerDemo:(Class)demoClass {
    DemoType type = DemoTypeCategory;
    if ([demoClass isSubclassOfClass:[DemoController class]] || [demoClass isSubclassOfClass:[DemoMDController class]]) {
        type = DemoTypeController;
    }
    NSString *priority = ([demoClass respondsToSelector:@selector(prioritySerial)])?[demoClass prioritySerial]:@"";
    [_demos addObject:[[DemoDataModel alloc] initWithName:[demoClass name]
                                              displayName:[demoClass displayName]
                                                   parane:[demoClass parentName]
                                                     type:type
                                                 priority:priority]];
}

- (NSArray *)exportDemos {
    NSMutableArray<DemoDataModel *> *walkDemos = [_demos mutableCopy];
    NSMutableArray<DemoDataModel *> *exportDemos = [NSMutableArray arrayWithCapacity:10];
    
    // 先插入第一层Demo
    NSInteger N = walkDemos.count;
    for (NSInteger i = N - 1; i >= 0; i--) {
        DemoDataModel * demo = [walkDemos objectAtIndex:i];
        
        if (demo.parentName == nil || [demo.parentName isEqualToString:@"root"]) {
            demo.deep = 1;
            [exportDemos insertObject:demo atIndex:0];
            [walkDemos removeObject:demo];
        }
    }
    
    // 然后从第1层开始建树
    NSInteger deep = 1;
    while (walkDemos.count != 0) {
        NSMutableArray<DemoDataModel *> *nodesInDeep = [self nodesInArray:exportDemos withDeep:deep++];
        
        NSInteger N = walkDemos.count;
        for (NSInteger i = N - 1; i >= 0; i--) {
            DemoDataModel * demo = [walkDemos objectAtIndex:i];
            
            for (DemoDataModel *nodeDemo in nodesInDeep) {
                if ([demo.parentName isEqualToString:nodeDemo.name]) {
                    demo.deep = deep;
                    NSMutableString *displayName = [NSMutableString stringWithString:@""];
                    for (NSInteger i = 0; i < demo.deep; i++) {
                        [displayName appendString:@"    "];
                    }
                    [displayName appendString:demo.displayName];
                    demo.displayName = displayName;
                    [nodeDemo.demos addObject:demo];
                    [walkDemos removeObject:demo];
                    break;
                }
            }
        }
    }
    
    [self treeSortDemos:exportDemos];
    
    return [exportDemos copy];
}

#pragma mark - < Main Logic >

- (NSMutableArray<DemoDataModel *> *)nodesInArray:(NSArray<DemoDataModel *> *)array withDeep:(NSInteger)deep {
    NSMutableArray<DemoDataModel *> *tempDemos = [array mutableCopy];
    while (deep > 1) {
        NSInteger N = tempDemos.count;
        for (NSInteger i = N - 1; i >= 0; i--) {
            DemoDataModel * demo = [tempDemos objectAtIndex:i];
            if (demo.demos.count > 0) {
                [tempDemos addObjectsFromArray:demo.demos];
            }
            [tempDemos removeObject:demo];
        }
        deep--;
    }
    return tempDemos;
}

- (void)treeSortDemos:(NSMutableArray<DemoDataModel *> *)demos {
    if (demos.count > 0) {
        [demos sortUsingComparator:^NSComparisonResult(DemoDataModel *obj1, DemoDataModel *obj2) {
            return [obj1.priority compare:obj2.priority];
        }];
        
        for (DemoDataModel *demo in demos) {
            [self treeSortDemos:demo.demos];
        }
    }
}


#pragma mark - < Delegate Methods >


#pragma mark - < Private Methods >


#pragma mark - < Lazy Initialize Methods >


@end


























