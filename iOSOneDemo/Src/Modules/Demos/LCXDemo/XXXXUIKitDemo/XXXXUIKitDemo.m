//
// XXXXUIKitDemo.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import "XXXXUIKitDemo.h"
#import "DemoManager.h"

@implementation XXXXUIKitDemo


+ (void)load {
    [[DemoManager sharedManager] registerDemo:XXXXUIKitDemo.class];
}

+ (NSString *)displayName { 
    return @"自定义UIKit";
}

+ (NSString *)name {
    return @"XXXXUIKitDemo";
}

+ (NSString *)parentName {
    return @"LCXDemo";
}

+ (NSString *)prioritySerial {
    return @"1.1";
}

@end
