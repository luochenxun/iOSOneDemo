//
// DrawingDemo.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import "DrawingDemo.h"

@implementation DrawingDemo

+ (void)load {
    [[DemoManager sharedManager] registerDemo:DrawingDemo.class];
}

+ (NSString *)displayName {
    return @"2D 绘图";
}

+ (NSString *)name {
    return @"DrawingDemo";
}

+ (NSString *)parentName {
    return @"ViewAppearance";
}

+ (NSString *)prioritySerial {
    return @"1.2";
}


@end
