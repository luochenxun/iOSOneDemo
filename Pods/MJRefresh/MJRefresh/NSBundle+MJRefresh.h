//
// NSBundle+MJRefresh.h
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import <UIKit/UIKit.h>

@interface NSBundle (MJRefresh)
+ (instancetype)mj_refreshBundle;
+ (UIImage *)mj_arrowImage;
+ (NSString *)mj_localizedStringForKey:(NSString *)key value:(NSString *)value;
+ (NSString *)mj_localizedStringForKey:(NSString *)key;
@end
