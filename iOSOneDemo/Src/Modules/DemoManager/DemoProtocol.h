//
// DemoProtocol.h
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#ifndef DemoProtocol_h
#define DemoProtocol_h


@protocol DemoProtocol <NSObject>

@required

/** Demo名称 */
+ (NSString *)name;

/** Demo名称 */
+ (NSString *)displayName;

/** Demo父类别名称 */
+ (NSString *)parentName;

/** Demo在列表中排序的优先级序号 */
+ (NSString *)prioritySerial;

@end


#endif /* DemoProtocol_h */
