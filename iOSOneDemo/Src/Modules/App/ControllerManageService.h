//
//  RootControllerService.h
//  iOSOneDemo
//
//  Created by luochenxun on 2018/1/10.
//  Copyright © 2018年 Kacha-Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ControllerManageService : NSObject <AppService, UISplitViewControllerDelegate>

@property(nonatomic, strong) UISplitViewController *splitViewController;
@property(nonatomic, strong) XXXXBaseViewController *primaryController;
@property(nonatomic, strong) XXXXBaseViewController *detailController;

+ (instancetype)sharedInstance;

@end
