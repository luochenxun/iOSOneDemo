//
// TestService.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import "TestService.h"

@interface TestService()

@end

@implementation TestService

+ (void)load {
    [AppServiceManager registerService:[TestService new]];
}

+ (NSString *)serviceName {
    return [TestService className];
}

- (AppServicePriority)servicePriority{
    return AppServicePriorityLow;
}

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    NSLog(@"Test Service Launch...");
    
    
    return YES;
}

@end




























