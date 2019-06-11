//
// FlexLayoutDemo.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import "FlexLayoutDemo.h"

@implementation FlexLayoutDemo

+ (void)load {
    [[DemoManager sharedManager] registerDemo:FlexLayoutDemo.class];
}

+ (NSString *)displayName {
    return @"FlexLayout - iOS上的flexbox布局";
}

+ (NSString *)name {
    return @"FlexLayoutDemo";
}

+ (NSString *)parentName {
    return @"LCXDemo";
}

+ (NSString *)prioritySerial {
    return @"1.2";
}

@end
