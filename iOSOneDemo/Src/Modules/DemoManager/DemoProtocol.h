//
//  DemoProtocol.h
//  XXXX
//
//  Created by luochenxun on 2018/1/3.
//  Copyright © 2018年 Kacha-Mobile. All rights reserved.
//

#ifndef DemoProtocol_h
#define DemoProtocol_h

typedef NS_ENUM(NSInteger, DemoPriority)
{
    DemoPriorityLow = -4,
    DemoPriorityMediumLow = -2,
    DemoPriorityDefault = 0,
    DemoPriorityMediumHight = 2,
    DemoPriorityHight = 4,
};

@protocol DemoProtocol <NSObject>

@required

/** Demo名称 */
+ (NSString *)name;

/** Demo名称 */
+ (NSString *)displayName;

/** Demo父类别名称 */
+ (NSString *)parentName;


@optional

/** Demo在列表中排序的优先级 */
+ (DemoPriority)priority;

@end


#endif /* DemoProtocol_h */
