//
// UserNotificationService.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import "UserNotificationService.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface UserNotificationService() <UNUserNotificationCenterDelegate>

@end

@implementation UserNotificationService

+ (void)load
{
    [AppServiceManager registerService:[UserNotificationService new]];
}

+ (NSString *)serviceName
{
    return [UserNotificationService className];
}

- (AppServicePriority)servicePriority
{
    return AppServicePriorityLow;
}


#pragma mark - < 注册 Push >

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self registerPushNotification:application];
    [self registerNotificationActions];
    
    return YES;
}

// 本地 Token
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    
}

// iOS 8 向APNs注册Push功能请求Token
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)settings
{
    NSLog(@"[UserNotification] Registering device for push notifications...");
    [application registerForRemoteNotifications];
}

// 获得 Device Token
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(nonnull NSData *)deviceToken
{
    NSString *token = [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<"withString:@""]
                                                   stringByReplacingOccurrencesOfString:@">" withString:@""]
                                                   stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"[UserNotification] Device Token: %@", token);
}

// 获得Device Token失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"[UserNotification] Fail To Register For Remote Notifications With Error: %@", error);
}


#pragma mark [ 注册主方法 ]

- (void)registerPushNotification:(UIApplication *)application
{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) { // in iOS10
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;  // 必须写代理，不然无法监听通知的接收与点击（此delegate要在application:didFinishLaunchingWithOptions:里赋值）
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) { // Agree
                NSLog(@"[UserNotification] Agree Push Notification");
                [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                    NSLog(@"[UserNotification]  %@", settings);
                }];
            } else { // UnAgree
                NSLog(@"[UserNotification] UnAgree Push Notification");
            }
        }];
    } else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0){ // iOS8 - iOS10
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge categories:nil]];
    }
    [application registerForRemoteNotifications];
}

- (void)registerNotificationActions
{
    // ----- 普通Action -----
    // 1. 创建 Action
    UNNotificationAction *action = [UNNotificationAction actionWithIdentifier:@"action-test" title:@"test" options:UNNotificationActionOptionNone];
    UNNotificationAction *authAction = [UNNotificationAction actionWithIdentifier:@"action-auth" title:@"auth-require" options:UNNotificationActionOptionAuthenticationRequired];
    UNNotificationAction *desAction = [UNNotificationAction actionWithIdentifier:@"action-des" title:@"destructive" options:UNNotificationActionOptionDestructive];
    UNNotificationAction *foreAction = [UNNotificationAction actionWithIdentifier:@"action-fore" title:@"foreground" options:UNNotificationActionOptionForeground];
    // 2. 创建 category
    UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:@"test" actions:@[action, authAction, desAction, foreAction] intentIdentifiers:@[] options:UNNotificationCategoryOptionNone];
    // 3. 把 category 添加到通知中心
    [[UNUserNotificationCenter currentNotificationCenter] setNotificationCategories:[NSSet setWithArray:@[category]]];
    
}


#pragma mark - < 处理 Push 消息的回调 >

#pragma mark [ UNUserNotificationCenterDelegate ]  iOS10+

// The method will be called on the delegate only if the application is in the foreground. If the method is not implemented or the handler is not called in a timely manner then the notification will not be presented. The application can choose to have the notification presented as a sound, badge, alert and/or in the notification list. This decision should be based on whether the information in the notification is otherwise visible to the user.
// 当应用在前台时，收到通知会回调此方法，app可以自己选择如何处理收到的通知（Notification）。
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler
{
    NSDictionary * userInfo = notification.request.content.userInfo;
    UNNotificationRequest *request = notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    // 判断是本地通知还是远程通知
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        NSLog(@"iOS10 前台收到远程通知:%@", userInfo);
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 前台收到本地通知:{\\\\nbody:%@，\\\\ntitle:%@,\\\\nsubtitle:%@,\\\\nbadge：%@，\\\\nsound：%@，\\\\nuserInfo：%@\\\\n}",body, title, subtitle, badge, sound, userInfo);
    }
    
    // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
    // 使用 UNNotificationPresentationOptionNone 则此通知不会显示
    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
//    completionHandler(UNNotificationPresentationOptionNone);
}

// The method will be called on the delegate when the user responded to the notification by opening the application, dismissing the notification or choosing a UNNotificationAction. The delegate must be set before the application returns from application:didFinishLaunchingWithOptions:.
// 当用户操作本app在通知栏上的通知时，会回调此方法（点击打开通知、消除通知或UNNotificationAction）。
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler
{
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    // Simple log
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        NSLog(@"iOS10 点击远程通知:%@", userInfo);
        
    } else {
        // 判断为本地通知
        NSLog(@"iOS10 点击本地通知:{\\\\nbody:%@，\\\\ntitle:%@,\\\\nsubtitle:%@,\\\\nbadge：%@，\\\\nsound：%@，\\\\nuserInfo：%@\\\\n}",body, title, subtitle, badge, sound, userInfo);
    }
    
    // 处理Action
    NSString *categoryIdentifier = response.notification.request.content.categoryIdentifier;
    if ([categoryIdentifier isEqualToString:@"test"]) { //识别需要被处理的拓展
        if ([response.actionIdentifier isEqualToString:@"action-test"]) { //识别用户点击的是哪个 action
            UNTextInputNotificationResponse *textResponse = (UNTextInputNotificationResponse *)response;
            NSString *msg = textResponse.userText;
            NSLog(@"test action %@", msg);
        }
    }
    
    completionHandler();  // 系统要求执行这个方法
}

#pragma mark iOS8-10

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
{
    NSLog(@"[UserNotification] Received push notification: %@, identifier: %@", userInfo, identifier);
    completionHandler();
}

#pragma mark iOS7

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)notification
{
    NSLog(@"[UserNotification] Received push notification: %@", notification);
}




@end
























