//
// XXLocationManager.h
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void (^XXLocationUpdateLocationCallback)(NSArray *locations);
typedef void (^XXLocationUpdateDirectionCallback)(CLHeading *heading);
typedef void (^XXLocationUpdateRegionCallback)(CLRegion *region);

@interface XXLocationManager : NSObject

#pragma mark - 成员

/**
 *  @author luochenxun(luochenxun@gmail.com), 15-12-05 16:12:04
 *  @brief 定位精度
 */
@property(nonatomic, assign) CLLocationAccuracy locationAccuracy;

/**
 *  @author luochenxun(luochenxun@gmail.com), 15-12-05 17:12:29
 *  @brief 定位的访问权限
 */
@property(nonatomic, assign) CLAuthorizationStatus locationAuth;

/**
 *  @author luochenxun(luochenxun@gmail.com), 15-12-05 17:12:09
 *  @brief 定位频率（隔多远定位一次，只有移动大于这个距离才更新位置信息）
 */
@property(assign, nonatomic) CLLocationDistance locationDistance;

#pragma mark - 回调Block

/**
 *  @brief 跟踪定位代理方法(每次定位有更新回调)
 */
- (void)addUpdateLocationListener:(XXLocationUpdateLocationCallback)updateLocationListener;

/**
 *  @brief 方向改变后的代理方法回调
 */
 - (void)addDirectionListener:(XXLocationUpdateDirectionCallback)directionListener;

/**
 *  @brief 进入某个区域之后执行
 */
- (void)addEnterRegionListener:(XXLocationUpdateRegionCallback)enterRegionListener;

/**
 *  @brief 走出某个区域之后执行
 */
- (void)addExitRegionListener:(XXLocationUpdateRegionCallback)exitRegionListener;

#pragma mark - 接口方法

/**
 *  @author luochenxun(luochenxun@gmail.com), 15-12-05 17:12:21
 *  @brief 打开定位
 */
- (void)open;

/**
 *  @brief 打开定位
 *
 *  @param authoStatus 定位的访问权限
 *  @param aAccuracy   定位精度
 *  @param aDistance   定位频率
 */
- (void)open:(CLAuthorizationStatus)authoStatus
    withAccuracy:(CLLocationAccuracy)aAccuracy
    withDistance:(double)aDistance;
    
/**
 *  @author luochenxun(luochenxun@gmail.com), 15-12-05 17:12:38
 *  @brief 关闭定位服务
 */
- (void)close;

@end
