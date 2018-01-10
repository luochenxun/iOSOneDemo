//
//  AppDelegate.h
//  XXXX
//
//  Created by luochenxun on 15/12/3.
//  Copyright © 2015年 Kacha-Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XXXXAppContext.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property(nonatomic, strong) UIWindow *window;


/**
 *  全局管理对象
 */
@property(nonatomic, strong) XXXXAppContext *appContext;



@end
