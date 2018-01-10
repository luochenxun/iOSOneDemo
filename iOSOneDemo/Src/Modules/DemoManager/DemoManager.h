//
//  DemoManager.h
//  XXXX
//
//  Created by luochenxun on 2018/1/3.
//  Copyright © 2018年 Kacha-Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DemoController.h"
#import "DemoProtocol.h"

@interface DemoManager : NSObject

#pragma mark - < Properties >


#pragma mark - < Interfaces >

+ (instancetype)sharedManager;

- (void)registerDemo:(Class)demoClass;

- (NSArray *)exportDemos; // 输出Demo树结构

@end
