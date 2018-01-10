//
//  AppDelegate.m
//  XXXX
//
//  Created by luochenxun on 15/12/3.
//  Copyright © 2015年 Kacha-Mobile. All rights reserved.
//

#import "AppDelegate.h"
#import "AppServiceManager.h"
#import "XXXXBaseNavigationController.h"
#import "DemoTableController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


#pragma mark - < Life circle >

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions {
    //------ 先于所有服务执行的方法  -------
    [[NSThread currentThread] setName:@"com.luo.demo"];
    
    if ([AppServiceManager managerResponseToSelector:@selector(application:willFinishLaunchingWithOptions:)]) {
        [[AppServiceManager sharedManager] performSelector:@selector(application:willFinishLaunchingWithOptions:)
                                                withObject:application withObject:launchOptions];
    }
    
    // init appContext
    _appContext = [XXXXAppContext sharedInstance];

    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    DemoTableController *rootController = [DemoTableController new];
    XXXXBaseNavigationController *navi = [[XXXXBaseNavigationController alloc] initWithRootViewController:rootController];
    _window.rootViewController = navi;
    [_window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"will terminate");
}

@end
