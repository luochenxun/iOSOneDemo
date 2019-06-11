//
// IOSSpecialDemo.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import "IOSSpecialDemo.h"
#import "DemoManager.h"

@implementation IOSSpecialDemo


+ (void)load {
    [[DemoManager sharedManager] registerDemo:IOSSpecialDemo.class];
}

+ (NSString *)displayName { 
    return @"iOS 特殊功能";
}

+ (NSString *)name {
    return @"IOSSpecialDemo";
}

+ (NSString *)parentName {
    return @"root";
}

+ (NSString *)prioritySerial {
    return @"4.0";
}

@end
