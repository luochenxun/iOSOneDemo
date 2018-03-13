//
//  OCDemo.m
//  iOSOneDemo
//
//  Created by luochenxun on 2018/1/3.
//  Copyright © 2018年 Kacha-Mobile. All rights reserved.
//

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
