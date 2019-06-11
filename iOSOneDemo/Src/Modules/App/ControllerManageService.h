//
// ControllerManageService.h
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import <Foundation/Foundation.h>

@interface ControllerManageService : NSObject <AppService, UISplitViewControllerDelegate>

@property(nonatomic, strong) UISplitViewController *splitViewController;
@property(nonatomic, strong) XXXXBaseViewController *primaryController;
@property(nonatomic, strong) XXXXBaseViewController *detailController;

+ (instancetype)sharedInstance;

@end
