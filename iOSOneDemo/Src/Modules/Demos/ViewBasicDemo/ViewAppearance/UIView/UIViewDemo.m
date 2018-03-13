//
//  UIViewDemo.m
//  iOSOneDemo
//
//  Created by luochenxun on 2018/1/6.
//  Copyright © 2018年 Kacha-Mobile. All rights reserved.
//

#import "UIViewDemo.h"

@implementation UIViewDemo

+ (void)load {
    [[DemoManager sharedManager] registerDemo:UIViewDemo.class];
}

+ (NSString *)displayName {
    return @"iOS View 基础";
}

+ (NSString *)name {
    return @"UIViewDemo";
}

+ (NSString *)parentName {
    return @"ViewAppearance";
}

+ (NSString *)prioritySerial {
    return @"1.1";
}


@end
