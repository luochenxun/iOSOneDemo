//
//  XXXXAppContext.m
//  jiayoubao
//
//  Created by luochenxun on 16/4/22.
//  Copyright © 2016年 jtjr99. All rights reserved.
//

#define kGlobalCacheName @"global_cache"

#import "XXXXAppContext.h"

// ------------------
// 配置项
// ---------
// 本地数据缓存的大小上限 10m
#define kDiskCacheMaxSize ( 10 * 1024 * 1024 )
// 本地数据缓存的时间上限 1周
#define kDiskCacheMaxAge ( 60 * 60 * 24 * 7 )


@implementation XXXXAppContext

+ (instancetype)sharedInstance {
    static XXXXAppContext *sharedInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
        
        [[NSNotificationCenter defaultCenter] addObserver:sharedInstance selector:@selector(_appDidReceiveMemoryWarningNotification) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:sharedInstance selector:@selector(_appDidEnterBackgroundNotification) name:UIApplicationDidEnterBackgroundNotification object:nil];
        
    });
    
    return sharedInstance;
}

#pragma mark - < Runtime >

// 应用低运存时执行, 可以在这里将一些耗费内存效大的对象释放之
- (void)_appDidReceiveMemoryWarningNotification {
}

// 应用进入后台后执行
- (void)_appDidEnterBackgroundNotification {
}


#pragma mark - < Lazy initilize >

// 全局缓存对象懒加载
- (YYCache *)cache{
    if (!_cache) {
        _cache = [YYCache cacheWithName:kGlobalCacheName];
        
        // memory config
        _cache.memoryCache.countLimit = 40;
        _cache.memoryCache.shouldRemoveAllObjectsWhenEnteringBackground = NO;
        // disk config
        _cache.diskCache.costLimit = kDiskCacheMaxSize;
        _cache.diskCache.ageLimit = kDiskCacheMaxAge;
        
    }
    return _cache;
}

- (XXXXAppTheme *)theme {
    if (_theme == nil) {
        _theme = [XXXXAppTheme sharedInstance];
    }
    return _theme;
}

@end
