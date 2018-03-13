//
//  FrameworkDemo.m
//  iOSOneDemo
//
//  Created by luochenxun on 2018/1/11.
//  Copyright © 2018年 Kacha-Mobile. All rights reserved.
//

#import "FrameworkDemo.h"

@interface FrameworkDemo ()

@end

@implementation FrameworkDemo


+ (void)load {
    [[DemoManager sharedManager] registerDemo:FrameworkDemo.class];
}

+ (NSString *)displayName {
    return @"Framework";
}

+ (NSString *)name {
    return @"FrameworkDemo";
}

+ (NSString *)parentName {
    return @"root";
}

+ (NSString *)prioritySerial {
    return @"3.0";
}

@end
