//
//  TestService.m
//  XXXX
//
//  Created by luochenxun on 2017/8/29.
//  Copyright © 2017年 Kacha-Mobile. All rights reserved.
//

#import "TestService.h"

@interface TestService()

@end

@implementation TestService

+ (void)load {
    [AppServiceManager registerService:[TestService new]];
}

+ (NSString *)serviceName {
    return [TestService className];
}

- (AppServicePriority)servicePriority{
    return AppServicePriorityLow;
}

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    NSLog(@"Test Service Launch...");
    
    
    return YES;
}

@end




























