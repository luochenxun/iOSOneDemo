//
//  AnimationDemo.m
//  iOSOneDemo
//
//  Created by luochenxun on 2018/1/3.
//  Copyright © 2018年 Kacha-Mobile. All rights reserved.
//

#import "AnimationDemo.h"

@implementation AnimationDemo

+ (void)load {
    [[DemoManager sharedManager] registerDemo:AnimationDemo.class];
}

+ (NSString *)displayName {
    return @"动画 Animation";
}

+ (NSString *)name {
    return @"AnimationDemo";
}

+ (NSString *)parentName {
    return @"ViewAppearance";
}

+ (NSString *)prioritySerial {
    return @"1.4";
}

@end
