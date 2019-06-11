//
// XXLocationManager.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import "XXLocationManager.h"

@interface XXLocationManager () <CLLocationManagerDelegate> {
    CLLocationManager *_locationManager;
    XXLocationUpdateLocationCallback _updateLocationListener;
    XXLocationUpdateDirectionCallback _directionListener;
    XXLocationUpdateRegionCallback _enterRegionListener;
    XXLocationUpdateRegionCallback _exitRegionListener;
}
@end

@implementation XXLocationManager

- (instancetype)init {
    if (self = [super init]) {
        // 精度
        _locationAccuracy = kCLLocationAccuracyBest;
        // 定位权限
        _locationAuth = kCLAuthorizationStatusAuthorizedWhenInUse;
        // 定位频率
        CLLocationDistance distance = 10.0;
        _locationDistance = distance;
    }
    return self;
}

- (void)open {
    // 初始化定位管理器
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"定位服务当前可能尚未打开，请设置打开！");
        return;
    }
    
    [self startTrackingLocation];
}

- (void)open:(CLAuthorizationStatus)authoStatus
    withAccuracy:(CLLocationAccuracy)aAccuracy
    withDistance:(double)aDistance {
    // 初始化定位类参数
    _locationAuth = authoStatus;
    _locationAccuracy = aAccuracy;
    CLLocationDistance distance = aDistance;
    _locationDistance = distance;
    
    [self open];
}

- (void)startTrackingLocation {
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusNotDetermined) {
        [_locationManager requestWhenInUseAuthorization];
    } else if (status == kCLAuthorizationStatusAuthorizedWhenInUse ||
               status == kCLAuthorizationStatusAuthorizedAlways) {
        //设置定位精度
        _locationManager.desiredAccuracy = _locationAccuracy;
        //定位频率,每隔多少米定位一次
        _locationManager.distanceFilter = _locationDistance;
        //启动跟踪定位
        [_locationManager startUpdatingLocation];
        [_locationManager startUpdatingLocation];
    }
}

- (void)close {
    [_locationManager stopUpdatingLocation];
    _locationManager = nil;
}

#pragma mark - CoreLocation 代理

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    if (_updateLocationListener) {
        _updateLocationListener(locations);
    }
}

//导航方向发生变化后执行
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    if (_directionListener) {
        _directionListener(newHeading);
    }
}

// 进入某个区域之后执行
- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    if (_enterRegionListener) {
        _enterRegionListener(region);
    }
}
// 走出某个区域之后执行
- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    if (_exitRegionListener) {
        _exitRegionListener(region);
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status) {
    case kCLAuthorizationStatusAuthorizedAlways:
    case kCLAuthorizationStatusAuthorizedWhenInUse:
        [self startTrackingLocation];
        break;
    case kCLAuthorizationStatusNotDetermined:
        [_locationManager requestWhenInUseAuthorization];
    default:
        break;
    }
}

/**
 *  @brief 跟踪定位代理方法(每次定位有更新回调)
 */
- (void)addUpdateLocationListener:(XXLocationUpdateLocationCallback)updateLocationListener {
    _updateLocationListener = updateLocationListener;
}

- (void)addDirectionListener:(XXLocationUpdateDirectionCallback)directionListener {
    _directionListener = directionListener;
}

- (void)addEnterRegionListener:(XXLocationUpdateRegionCallback)enterRegionListener {
    _enterRegionListener = enterRegionListener;
}

- (void)addExitRegionListener:(XXLocationUpdateRegionCallback)exitRegionListener{
    _exitRegionListener = exitRegionListener;
}

@end






















