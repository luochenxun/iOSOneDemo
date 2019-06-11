//
// CALayerDemo.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import "CALayerDemo.h"

@implementation CALayerDemo

+ (void)load {
    [[DemoManager sharedManager] registerDemo:CALayerDemo.class];
}

+ (NSString *)displayName {
    return @"CALayer Demo";
}

+ (NSString *)name {
    return @"CALayerDemo";
}

+ (NSString *)parentName {
    return @"ViewAppearance";
}

+ (NSString *)prioritySerial {
    return @"1.3";
}

@end
