//
//  LanguageDemo.m
//  iOSOneDemo
//
//  Created by luochenxun on 2018/1/3.
//  Copyright © 2018年 Kacha-Mobile. All rights reserved.
//

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
