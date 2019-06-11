//
// ControllerManageService.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import "ControllerManageService.h"
#import "XXXXBaseNavigationController.h"
#import "DemoTableController.h"
#import "DemoMainController.h"

@implementation ControllerManageService

+ (void)load {
    [AppServiceManager registerService:[ControllerManageService sharedInstance]];
}

+ (NSString *)serviceName {
    return [ControllerManageService className];
}

- (AppServicePriority)servicePriority
{
    return AppServicePriorityHight;
}

+ (instancetype)sharedInstance {
    static ControllerManageService *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[ControllerManageService alloc] init];
    });
    return instance;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // primary
    _primaryController = [DemoTableController new];
    XXXXBaseNavigationController *primaryNavi = [[XXXXBaseNavigationController alloc] initWithRootViewController:_primaryController];
    // detail
    _detailController = [DemoMainController new];
    XXXXBaseNavigationController *detailNavi = [[XXXXBaseNavigationController alloc] initWithRootViewController:_detailController];
    // splitViewController
    _splitViewController = [[UISplitViewController alloc] init];
    [_splitViewController setPresentsWithGesture:YES];
    _splitViewController.viewControllers = @[primaryNavi,detailNavi];
    _splitViewController.preferredPrimaryColumnWidthFraction = 0.5;
    _splitViewController.maximumPrimaryColumnWidth = [UIScreen mainScreen].bounds.size.width;
    _splitViewController.delegate = self;
    
    // window
    APP_DELEGATE.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    APP_DELEGATE.window.rootViewController = _splitViewController;
    [APP_DELEGATE.window makeKeyAndVisible];
    
    return YES;
}


#pragma mark - < Delegates >

#pragma mark [ UISplitViewControllerDelegate ]

//// 主控制器将要隐藏时触发的方法
//-(void)splitViewController:(UISplitViewController *)svc
//    willHideViewController:(UIViewController *)aViewController
//         withBarButtonItem:(UIBarButtonItem *)barButtonItem
//      forPopoverController:(UIPopoverController *)pc
//{
//    barButtonItem.title = @"Master";
//    //master将要隐藏时，给detail设置一个返回按钮
//    UINavigationController *Nav = [self.splitViewController.viewControllers lastObject];
//    DetailViewController *Detail = (DetailViewController *)[Nav topViewController];
//
//    Detail.navigationItem.leftBarButtonItem = barButtonItem;
//}

// 开始时取消二级控制器,只显示主控制器
- (BOOL)splitViewController:(UISplitViewController *)splitViewController
    collapseSecondaryViewController:(UIViewController *)secondaryViewController
  ontoPrimaryViewController:(UIViewController *)primaryViewController
{
    return YES;
}


//// 主控制器将要显示时触发的方法
//-(void)splitViewController:(UISplitViewController *)sender willShowViewController:(UIViewController *)master
// invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
//{
//    //master将要显示时,取消detail的返回按钮
//    UINavigationController *Nav = [self.splitViewController.viewControllers lastObject];
//    DetailViewController *Detail = (DetailViewController *)[Nav topViewController];
//
//    Detail.navigationItem.leftBarButtonItem = nil;
//}

@end

