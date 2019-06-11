//
// ViewBasicDemo.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import "ViewBasicDemo.h"
#import "DemoManager.h"

@implementation ViewBasicDemo

+ (void)load {
    [[DemoManager sharedManager] registerDemo:ViewBasicDemo.class];
}

+ (NSString *)displayName { 
    return @"View 基础";
}

+ (NSString *)name {
    return @"ViewBasicDemo";
}

+ (NSString *)parentName {
    return @"root";
}

+ (NSString *)prioritySerial {
    return @"2.0";
}

@end
