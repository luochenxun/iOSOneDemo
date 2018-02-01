//
//  AppDelegate.h
//  XXXX
//
//  Created by luochenxun on 15/12/3.
//  Copyright © 2015年 Kacha-Mobile. All rights reserved.
//

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
