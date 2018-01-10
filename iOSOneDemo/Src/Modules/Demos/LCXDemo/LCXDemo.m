//
//  LCXDemo.m
//  iOSOneDemo
//
//  Created by luochenxun on 2018/1/8.
//  Copyright © 2018年 Kacha-Mobile. All rights reserved.
//

#import "LCXDemo.h"

@implementation LCXDemo

+ (void)load {
    [[DemoManager sharedManager] registerDemo:LCXDemo.class];
}

+ (NSString *)displayName {
    return @"我的作品";
}

+ (NSString *)name {
    return @"LCXDemo";
}

+ (NSString *)parentName {
    return @"root";
}

@end
