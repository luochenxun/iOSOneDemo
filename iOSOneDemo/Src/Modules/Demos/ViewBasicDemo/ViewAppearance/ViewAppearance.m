//
//  ViewAppearance.m
//  iOSOneDemo
//
//  Created by luochenxun on 2018/1/3.
//  Copyright © 2018年 Kacha-Mobile. All rights reserved.
//

#import "ViewAppearance.h"
#import "DemoManager.h"

@implementation ViewAppearance


+ (void)load {
    [[DemoManager sharedManager] registerDemo:ViewAppearance.class];
}

+ (NSString *)displayName { 
    return @"View 的外观";
}

+ (NSString *)name {
    return @"ViewAppearance";
}

+ (NSString *)parentName {
    return @"ViewBasicDemo";
}

+ (NSString *)prioritySerial {
    return @"1.1";
}

@end
