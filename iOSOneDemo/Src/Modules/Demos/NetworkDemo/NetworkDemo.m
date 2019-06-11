//
// NetworkDemo.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import "NetworkDemo.h"
#import "DemoManager.h"

@implementation NetworkDemo

+ (void)load {
    [[DemoManager sharedManager] registerDemo:NetworkDemo.class];
}

+ (NSString *)displayName { 
    return @"网络与多线程";
}

+ (NSString *)name {
    return @"NetworkDemo";
}

+ (NSString *)parentName {
    return @"root";
}

+ (NSString *)prioritySerial {
    return @"3.1";
}

@end
