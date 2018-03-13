//
//  DemoProtocol.h
//  XXXX
//
//  Created by luochenxun on 2018/1/3.
//  Copyright © 2018年 Kacha-Mobile. All rights reserved.
//

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
