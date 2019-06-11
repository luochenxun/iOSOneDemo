//
// ViewInteraction.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import "ViewInteraction.h"
#import "DemoManager.h"

@implementation ViewInteraction


+ (void)load {
    [[DemoManager sharedManager] registerDemo:ViewInteraction.class];
}

+ (NSString *)displayName { 
    return @"View 的交互";
}

+ (NSString *)name {
    return @"ViewInteraction";
}

+ (NSString *)parentName {
    return @"ViewBasicDemo";
}

+ (NSString *)prioritySerial {
    return @"1.2.0";
}

@end
