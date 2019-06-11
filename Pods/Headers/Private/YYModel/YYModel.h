//
// YYModel.h
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import <Foundation/Foundation.h>

#if __has_include(<YYModel/YYModel.h>)
FOUNDATION_EXPORT double YYModelVersionNumber;
FOUNDATION_EXPORT const unsigned char YYModelVersionString[];
#import <YYModel/NSObject+YYModel.h>
#import <YYModel/YYClassInfo.h>
#else
#import "NSObject+YYModel.h"
#import "YYClassInfo.h"
#endif
