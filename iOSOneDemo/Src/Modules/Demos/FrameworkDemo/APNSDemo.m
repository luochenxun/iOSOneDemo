//
//  APNSDemo.m
//  iOSOneDemo
//
//  Created by luochenxun on 2018/1/6.
//  Copyright © 2018年 Kacha-Mobile. All rights reserved.
//

#import "APNSDemo.h"
#import <UserNotifications/UserNotifications.h>

@interface APNSDemo ()

@end

@implementation APNSDemo


+ (void)load {
    [[DemoManager sharedManager] registerDemo:APNSDemo.class];
}

+ (NSString *)displayName {
    return @"推送 Demo";
}

+ (NSString *)name {
    return @"APNSDemo";
}

+ (NSString *)parentName {
    return @"FrameworkDemo";
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initEnvironment];
    [self initWindow];
    [self initUI];
    [self initAction];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - < Init Methods >

- (void)initWindow {
    self.title = @"用户通知(本地通知 & push)";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)initEnvironment {
    
}

- (void)initUI {
    FlexLinearLayout *localNotiBox = [self addDemoBoxWithTitle:@"本地通知(Local Notification)"];
    [self addButtonOnView:localNotiBox withText:@"5秒之后发一条本地通知" block:^(id btn) {
        // 1. 构造本地通知 Content
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = @"本地通知标题";
        content.subtitle = @"本地通知子标题";
        content.body = @"构造一个本地通知";
        content.badge = @1;
        
        // 2. 构造本地通知trigger
        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO];
        
        // 3. 发送本地通知
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"localnotify"
                                                                              content:content
                                                                              trigger:trigger];
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            NSLog(@"[APNsDemo] send local notification success");
        }];
    }];
    
    
    [localNotiBox adjustLayoutHeightBySubviews];
}

- (void)initAction {
    
}

#pragma mark - < Public Methods >
#pragma mark - < Main Logic >
#pragma mark - < Delegate Methods >
#pragma mark - < Private Methods >
#pragma mark - < Lazy Initialize Methods >


@end













