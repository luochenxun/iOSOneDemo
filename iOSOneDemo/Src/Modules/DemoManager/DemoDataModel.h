//
// DemoDataModel.h
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger,DemoType) {
    DemoTypeController, // Demo 示例
    DemoTypeCategory, // Demo分组
};


@interface DemoDataModel : NSObject


#pragma mark - < Properties >

@property (nonatomic, readonly, copy) NSString *name; // demo 名
@property (nonatomic, copy) NSString *displayName; // demo 显示名
@property (nonatomic, readonly, copy) NSString *parentName;
@property (nonatomic, strong) NSMutableArray<DemoDataModel *> *demos; // 分类下面的Demos
@property (nonatomic, readonly, assign) DemoType type; // 示例或分类
@property (nonatomic, assign) BOOL isSpread; // 是否展开
@property (nonatomic, assign) NSInteger deep; // 深度（在Demo）
@property (nonatomic, copy) NSString *priority; // demo在列表中排序的优先级


#pragma mark - < Interfaces >

- (instancetype)initWithName:(NSString *)name displayName:(NSString *)disName parane:(NSString *)parentName type:(DemoType)type priority:(NSString *)priority;

// 获得其中展开的Demo数量
- (NSInteger)spreadDemosCount;

- (NSArray<DemoDataModel *> *)spreadDemos;

@end
