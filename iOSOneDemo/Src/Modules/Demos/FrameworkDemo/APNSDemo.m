//
// APNSDemo.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

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

+ (NSString *)prioritySerial {
    return @"3.1.0";
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
    [self addButtonOnView:localNotiBox withText:@"马上发一条本地通知" block:[self notiBlockWithTimeout:0.1]];
    [self addButtonOnView:localNotiBox withText:@"5秒之后发一条本地通知" block:[self notiBlockWithTimeout:5]];
    
    [self addButtonOnView:localNotiBox withText:@"本地马上发条Action通知" block:[self notiActionBlockWithTimeout:0.1]];
    [self addButtonOnView:localNotiBox withText:@"本地5秒后发条Action通知" block:[self notiActionBlockWithTimeout:5]];
    
    
    [localNotiBox adjustLayoutHeightBySubviews];
}

- (XXXXButtonBlock)notiBlockWithTimeout:(NSTimeInterval)timeout {
    return ^(id btn) {
        // 1. 构造本地通知 Content
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = @"本地通知标题";
        content.subtitle = @"本地消息无论发多少个，都只显示成一个";
        content.body = @"构造一个本地通知，消息气球显示1\n相同identifier的通知只会显示一个";
        content.badge = @1;
        
        // 2. 构造本地通知trigger
        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:timeout repeats:NO];
        
        // 3. 发送本地通知
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"local_noti"
                                                                              content:content
                                                                              trigger:trigger];
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            NSLog(@"[APNsDemo] send local notification success");
        }];
    };
}

- (XXXXButtonBlock)notiActionBlockWithTimeout:(NSTimeInterval)timeout {
    return ^(id btn) {
        // 1. 构造本地通知 Content
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = @"带Action的本地通知";
        content.body = @"有一些Action供您选择";
        content.categoryIdentifier = @"test";
        // 2. 构造本地通知trigger
        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:timeout repeats:NO];
        // 3. 发送本地通知
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"local_action_noti"
                                                                              content:content
                                                                              trigger:trigger];
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            NSLog(@"[APNsDemo] send local notification success");
        }];
    };
}

- (void)initAction {
    
}

#pragma mark - < Public Methods >
#pragma mark - < Main Logic >
#pragma mark - < Delegate Methods >
#pragma mark - < Private Methods >
#pragma mark - < Lazy Initialize Methods >


@end













