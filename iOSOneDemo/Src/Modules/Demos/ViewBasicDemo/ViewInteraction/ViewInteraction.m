//
//  ViewInteraction.m
//  iOSOneDemo
//
//  Created by luochenxun on 2018/1/3.
//  Copyright © 2018年 Kacha-Mobile. All rights reserved.
//

#import "ViewInteraction.h"
#import "DemoManager.h"

@implementation ViewInteraction


+ (void)load {
    [[DemoManager sharedManager] registerDemo:ViewInteraction.class];
}

+ (NSString *)displayName { 
    return @"View 的交互";
}

+ (NSString *)name {
    return @"ViewInteraction";
}

+ (NSString *)parentName {
    return @"ViewBasicDemo";
}

+ (NSString *)prioritySerial {
    return @"1.2.0";
}

@end
