//
//  DrawingDemo.m
//  iOSOneDemo
//
//  Created by luochenxun on 2018/1/6.
//  Copyright © 2018年 Kacha-Mobile. All rights reserved.
//

#import "DrawingDemo.h"

@implementation DrawingDemo

+ (void)load {
    [[DemoManager sharedManager] registerDemo:DrawingDemo.class];
}

+ (NSString *)displayName {
    return @"2D 绘图";
}

+ (NSString *)name {
    return @"DrawingDemo";
}

+ (NSString *)parentName {
    return @"ViewAppearance";
}

+ (NSString *)prioritySerial {
    return @"1.2";
}


@end
