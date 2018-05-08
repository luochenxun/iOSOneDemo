//
//  NetworkDemo.m
//  iOSOneDemo
//
//  Created by luochenxun on 2018/1/3.
//  Copyright © 2018年 Kacha-Mobile. All rights reserved.
//

#import "NetworkDemo.h"
#import "DemoManager.h"

@implementation NetworkDemo

+ (void)load {
    [[DemoManager sharedManager] registerDemo:NetworkDemo.class];
}

+ (NSString *)displayName { 
    return @"网络与多线程";
}

+ (NSString *)name {
    return @"NetworkDemo";
}

+ (NSString *)parentName {
    return @"root";
}

+ (NSString *)prioritySerial {
    return @"3.1";
}

@end
