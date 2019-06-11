//
// ViewAppearance.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import "ViewAppearance.h"
#import "DemoManager.h"

@implementation ViewAppearance


+ (void)load {
    [[DemoManager sharedManager] registerDemo:ViewAppearance.class];
}

+ (NSString *)displayName { 
    return @"View 的外观";
}

+ (NSString *)name {
    return @"ViewAppearance";
}

+ (NSString *)parentName {
    return @"ViewBasicDemo";
}

+ (NSString *)prioritySerial {
    return @"1.1";
}

@end
