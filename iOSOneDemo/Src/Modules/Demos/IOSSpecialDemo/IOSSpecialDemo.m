//
//  IOSSpecialDemo.m
//  iOSOneDemo
//
//  Created by luochenxun on 2018/1/3.
//  Copyright © 2018年 Kacha-Mobile. All rights reserved.
//

#import "IOSSpecialDemo.h"
#import "DemoManager.h"

@implementation IOSSpecialDemo


+ (void)load {
    [[DemoManager sharedManager] registerDemo:IOSSpecialDemo.class];
}

+ (NSString *)displayName { 
    return @"iOS 特殊功能";
}

+ (NSString *)name {
    return @"IOSSpecialDemo";
}

+ (NSString *)parentName {
    return @"root";
}

+ (NSString *)prioritySerial {
    return @"4.0";
}

@end
