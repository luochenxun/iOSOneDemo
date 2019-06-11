//
// LanguageDemo.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import "LanguageDemo.h"
#import "DemoManager.h"

@implementation LanguageDemo

+ (void)load {
    [[DemoManager sharedManager] registerDemo:LanguageDemo.class];
}

+ (NSString *)displayName { 
    return @"语言";
}

+ (NSString *)name {
    return @"LanguageDemo";
}

+ (NSString *)parentName {
    return @"root";
}

+ (NSString *)prioritySerial {
    return @"1.0";
}

@end
