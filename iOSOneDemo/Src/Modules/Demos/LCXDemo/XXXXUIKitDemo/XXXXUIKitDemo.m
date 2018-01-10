//
//  XXXXUIKitDemo.m
//  iOSOneDemo
//
//  Created by luochenxun on 2018/1/3.
//  Copyright © 2018年 Kacha-Mobile. All rights reserved.
//

#import "XXXXUIKitDemo.h"
#import "DemoManager.h"

@implementation XXXXUIKitDemo


+ (void)load {
    [[DemoManager sharedManager] registerDemo:XXXXUIKitDemo.class];
}

+ (NSString *)displayName { 
    return @"自定义UIKit";
}

+ (NSString *)name {
    return @"XXXXUIKitDemo";
}

+ (NSString *)parentName {
    return @"LCXDemo";
}

@end
