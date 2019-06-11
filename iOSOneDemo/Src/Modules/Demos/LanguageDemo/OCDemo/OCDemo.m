//
// OCDemo.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import "OCDemo.h"
#import "DemoManager.h"

@implementation OCDemo


+ (void)load {
    [[DemoManager sharedManager] registerDemo:OCDemo.class];
}

+ (NSString *)displayName { 
    return @"Objective-C 基础";
}

+ (NSString *)name {
    return @"OCDemo";
}

+ (NSString *)parentName {
    return @"LanguageDemo";
}

+ (NSString *)prioritySerial {
    return @"1.1";
}

@end
