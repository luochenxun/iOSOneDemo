//
// AppDelegate.h
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import <UIKit/UIKit.h>
#import "XXXXAppContext.h"
#import "XXXXBaseViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>


#pragma mark - < UI Components >

@property(nonatomic, strong) UIWindow *window;

#pragma mark - < Global Components >

/**
 *  全局管理对象
 */
@property(nonatomic, strong) XXXXAppContext *appContext;



@end
