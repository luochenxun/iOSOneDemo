//
//  XXXXAppContext.h
//  jiayoubao
//
//  Created by luochenxun on 16/4/22.
//  Copyright © 2016年 jtjr99. All rights reserved.
//

//  应用全局对象运行环境。
//  单实例模型，生命周期为应用程序运行期间整个生命周期。
//
//  目的：减少程序中的单实例，对全局对象进行全局控制。当运存较少时对部分全局对象进行释放
//
//  Usage:
//         [ [XXAppContext sharedInstance].cache ...] // 直接调单例方法引用全局对象

#import <Foundation/Foundation.h>
#import "YYCache.h"
#import "XXXXAppTheme.h"

@interface XXXXAppContext : NSObject

/** 单实例方法 */
+ (instancetype)sharedInstance;
- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;


#pragma mark - < Global object >

/**
 *  全局缓存对象, 以键值对的方式缓存实现了 NSCoding的对象，实现内存与本地二级缓存
 *  <p>
 *  要缓存的对象可以继承 JYBModel基类，将自动实现 NSCoding协议
 *
 *  Usage: <p>
 *
 *  [[XXAppContext sharedInstance].cache setObject:id<NSCoding> forKey:NSString] // 设缓存<br>
 *
 *  [[XXAppContext sharedInstance].cache objectForKey:NSString] // 读缓存<br>
 *
 *  [[XXAppContext sharedInstance].cache removeObjectForKey:key] // 清缓存<br>
 */
@property (nonatomic, strong) YYCache *cache;


/**
 App主题类
 */
@property (nonatomic, strong) XXXXAppTheme *theme;

@end
