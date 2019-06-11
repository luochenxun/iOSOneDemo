//
// UIViewDemo.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import "UIViewDemo.h"

@implementation UIViewDemo

+ (void)load {
    [[DemoManager sharedManager] registerDemo:UIViewDemo.class];
}

+ (NSString *)displayName {
    return @"iOS View 基础";
}

+ (NSString *)name {
    return @"UIViewDemo";
}

+ (NSString *)parentName {
    return @"ViewAppearance";
}

+ (NSString *)prioritySerial {
    return @"1.1";
}


@end
