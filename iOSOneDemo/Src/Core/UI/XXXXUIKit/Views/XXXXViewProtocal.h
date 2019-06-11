//
// XXXXViewProtocal.h
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#ifndef XXXXViewProtocal_h
#define XXXXViewProtocal_h

#import "XXXXAppTheme.h"

@protocol XXXXViewProtocal <NSObject>

@required

- (instancetype)initWithTheme:(XXXXAppTheme *)theme;

/** 设置控件的主题 */
- (void)setTheme:(XXXXAppTheme *)theme;

@end

#endif /* XXXXViewProtocal_h */
