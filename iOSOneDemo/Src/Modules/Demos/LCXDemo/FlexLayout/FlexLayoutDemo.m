//
//  FlexLayoutDemo.m
//  iOSOneDemo
//
//  Created by luochenxun on 2018/1/8.
//  Copyright © 2018年 Kacha-Mobile. All rights reserved.
//

#import "FlexLayoutDemo.h"

@implementation FlexLayoutDemo

+ (void)load {
    [[DemoManager sharedManager] registerDemo:FlexLayoutDemo.class];
}

+ (NSString *)displayName {
    return @"FlexLayout - iOS上的flexbox布局";
}

+ (NSString *)name {
    return @"FlexLayoutDemo";
}

+ (NSString *)parentName {
    return @"LCXDemo";
}

@end
