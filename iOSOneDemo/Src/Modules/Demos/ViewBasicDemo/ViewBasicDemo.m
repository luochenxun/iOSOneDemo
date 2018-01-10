//
//  ViewBasicDemo.m
//  iOSOneDemo
//
//  Created by luochenxun on 2018/1/3.
//  Copyright © 2018年 Kacha-Mobile. All rights reserved.
//

#import "ViewBasicDemo.h"
#import "DemoManager.h"

@implementation ViewBasicDemo

+ (void)load {
    [[DemoManager sharedManager] registerDemo:ViewBasicDemo.class];
}

+ (NSString *)displayName { 
    return @"View 基础";
}

+ (NSString *)name {
    return @"ViewBasicDemo";
}

+ (NSString *)parentName {
    return @"root";
}

@end
