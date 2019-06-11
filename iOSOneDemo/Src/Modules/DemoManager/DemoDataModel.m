//
// DemoDataModel.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import "DemoDataModel.h"

@implementation DemoDataModel

#pragma mark - < Init Methods >

- (instancetype)initWithName:(NSString *)name displayName:(NSString *)disName parane:(NSString *)parentName type:(DemoType)type priority:(NSString *)priority{
    if (self = [super init]) {
        _name = name;
        _displayName = disName;
        _parentName = parentName;
        _type = type;
        _demos = [NSMutableArray arrayWithCapacity:10];
        _priority = priority;
        
        _isSpread = NO;
        _deep = 0;
    }
    return self;
}


#pragma mark - < Interfaces >

- (NSInteger)spreadDemosCount {
    if (!_isSpread) {
        return 0;
    }
    
    NSInteger childrenCount = 0;
    for (DemoDataModel *demo in _demos) {
        childrenCount++;
        childrenCount += [demo spreadDemosCount];
    }
    return childrenCount;
}

- (NSArray<DemoDataModel *> *)spreadDemos {
    if (!_isSpread) {
        return nil;
    }
    
    NSMutableArray<DemoDataModel *> *demos = [NSMutableArray arrayWithCapacity:10];
    for (DemoDataModel *demo in _demos) {
        [demos addObject:demo];
        NSArray *childrenDemos = [demo spreadDemos];
        if (childrenDemos.count > 0) {
             [demos addObjectsFromArray:childrenDemos];
        }
    }
    return [demos copy];
}

#pragma mark - < Main Logic >


#pragma mark - < Delegate Methods >


#pragma mark - < Private Methods >


#pragma mark - < Lazy Initialize Methods >

@end


















