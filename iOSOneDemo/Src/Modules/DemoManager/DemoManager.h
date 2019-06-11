//
// DemoManager.h
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import <Foundation/Foundation.h>
#import "DemoController.h"
#import "DemoProtocol.h"

@interface DemoManager : NSObject

#pragma mark - < Properties >


#pragma mark - < Interfaces >

+ (instancetype)sharedManager;

- (void)registerDemo:(Class)demoClass;

- (NSArray *)exportDemos; // 输出Demo树结构

@end
