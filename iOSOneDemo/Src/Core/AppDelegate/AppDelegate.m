//
// AppDelegate.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import "AppDelegate.h"
#import "AppServiceManager.h"

@interface AppDelegate ()

@property(nonatomic, strong) AppServiceManager *serviceManager;

@end

@implementation AppDelegate


#pragma mark - < Life circle >

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions {
    //------ 先于所有服务执行的方法  -------
    [[NSThread currentThread] setName:@"com.luo.demo"];
    
    _serviceManager = [AppServiceManager sharedManager];
    if ([AppServiceManager managerResponseToSelector:@selector(application:willFinishLaunchingWithOptions:)]) {
        [_serviceManager performSelector:@selector(application:willFinishLaunchingWithOptions:)
                                                withObject:application withObject:launchOptions];
    }
    
    // init appContext
    _appContext = [XXXXAppContext sharedInstance];

    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
        
    if ([AppServiceManager managerResponseToSelector:@selector(application:didFinishLaunchingWithOptions:)]) {
        [_serviceManager performSelector:@selector(application:didFinishLaunchingWithOptions:)
                              withObject:application withObject:launchOptions];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    if ([AppServiceManager managerResponseToSelector:@selector(applicationWillResignActive:)]) {
        [_serviceManager performSelector:@selector(applicationWillResignActive:)
                              withObject:application];
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    if ([AppServiceManager managerResponseToSelector:@selector(applicationDidEnterBackground:)]) {
        [_serviceManager performSelector:@selector(applicationDidEnterBackground:)
                              withObject:application];
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    if ([AppServiceManager managerResponseToSelector:@selector(applicationWillEnterForeground:)]) {
        [_serviceManager performSelector:@selector(applicationWillEnterForeground:)
                              withObject:application];
    }
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    if ([AppServiceManager managerResponseToSelector:@selector(applicationDidBecomeActive:)]) {
        [_serviceManager performSelector:@selector(applicationDidBecomeActive:)
                              withObject:application];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
    if ([AppServiceManager managerResponseToSelector:@selector(applicationWillTerminate:)]) {
        [_serviceManager performSelector:@selector(applicationWillTerminate:)
                              withObject:application];
    }
    NSLog(@"will terminate");
}


#pragma mark - < User Notification >

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    if ([AppServiceManager managerResponseToSelector:@selector(application:didReceiveLocalNotification:)]) {
        [_serviceManager performSelector:@selector(application:didReceiveLocalNotification:)
                              withObject:application
                              withObject:notification];
    }
}

// 获得Device Token
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(nonnull NSData *)deviceToken
{
    if ([AppServiceManager managerResponseToSelector:@selector(application:didRegisterForRemoteNotificationsWithDeviceToken:)]) {
        [_serviceManager performSelector:@selector(application:didRegisterForRemoteNotificationsWithDeviceToken:)
                              withObject:application
                              withObject:deviceToken];
    }
}

// 获得Device Token失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    if ([AppServiceManager managerResponseToSelector:@selector(application:didFailToRegisterForRemoteNotificationsWithError:)]) {
        [_serviceManager performSelector:@selector(application:didFailToRegisterForRemoteNotificationsWithError:)
                              withObject:application
                              withObject:error];
    }
}

@end








