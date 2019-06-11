//
// NSObject+ClassName.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import "NSObject+ClassName.h"
#import <objc/runtime.h>

@implementation NSObject (ClassName)
- (NSString *)className {
    return [NSString stringWithUTF8String:class_getName([self class])];
}
+ (NSString *)className {
    return [NSString stringWithUTF8String:class_getName(self)];
}

@end
