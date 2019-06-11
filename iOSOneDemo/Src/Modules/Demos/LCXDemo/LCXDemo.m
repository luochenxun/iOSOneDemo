//
// LCXDemo.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import "LCXDemo.h"

@implementation LCXDemo

+ (void)load {
    [[DemoManager sharedManager] registerDemo:LCXDemo.class];
}

+ (NSString *)displayName {
    return @"我的作品";
}

+ (NSString *)name {
    return @"LCXDemo";
}

+ (NSString *)parentName {
    return @"root";
}

+ (NSString *)prioritySerial {
    return @"5.0";
}

@end
