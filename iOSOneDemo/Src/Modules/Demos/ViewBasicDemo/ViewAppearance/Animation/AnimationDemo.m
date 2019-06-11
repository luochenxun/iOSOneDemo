//
// AnimationDemo.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import "AnimationDemo.h"

@implementation AnimationDemo

+ (void)load {
    [[DemoManager sharedManager] registerDemo:AnimationDemo.class];
}

+ (NSString *)displayName {
    return @"动画 Animation";
}

+ (NSString *)name {
    return @"AnimationDemo";
}

+ (NSString *)parentName {
    return @"ViewAppearance";
}

+ (NSString *)prioritySerial {
    return @"1.4";
}

@end
