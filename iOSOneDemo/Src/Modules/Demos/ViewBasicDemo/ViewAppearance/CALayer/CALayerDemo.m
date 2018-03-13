//
//  CALayerDemo.m
//  iOSOneDemo
//
//  Created by luochenxun on 2018/1/3.
//  Copyright © 2018年 Kacha-Mobile. All rights reserved.
//

#import "CALayerDemo.h"

@implementation CALayerDemo

+ (void)load {
    [[DemoManager sharedManager] registerDemo:CALayerDemo.class];
}

+ (NSString *)displayName {
    return @"CALayer Demo";
}

+ (NSString *)name {
    return @"CALayerDemo";
}

+ (NSString *)parentName {
    return @"ViewAppearance";
}

+ (NSString *)prioritySerial {
    return @"1.3";
}

@end
