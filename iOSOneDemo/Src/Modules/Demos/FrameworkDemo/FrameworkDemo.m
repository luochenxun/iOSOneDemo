//
// FrameworkDemo.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import "FrameworkDemo.h"

@interface FrameworkDemo ()

@end

@implementation FrameworkDemo


+ (void)load {
    [[DemoManager sharedManager] registerDemo:FrameworkDemo.class];
}

+ (NSString *)displayName {
    return @"Framework";
}

+ (NSString *)name {
    return @"FrameworkDemo";
}

+ (NSString *)parentName {
    return @"root";
}

+ (NSString *)prioritySerial {
    return @"3.0";
}

@end
