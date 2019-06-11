//
// XXXXAppTheme.h
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import "XXXXBaseTheme.h"


#pragma mark - < 子类定义 >


/**
 字体大小风格基类
 */
@interface XXXXAppFontStyle : XXXXBaseFontStyle

@end


/**
 颜色风格基类
 */
@interface XXXXAppColorStyle : XXXXBaseColorStyle

// -- Demo 模块
@property (nonatomic, readonly, strong) UIColor *demoSectionBg;
@property (nonatomic, readonly, strong) UIColor *demoCategoryBg;
@property (nonatomic, readonly, strong) UIColor *demoControllerBg;

@end


/**
 屏幕尺寸风格基类
 */
@interface XXXXAppDimensionStyle : XXXXBaseDimensionStyle

@end


#pragma mark - < 主类定义 >


/**
 主题基类
 */
@interface XXXXAppTheme : XXXXBaseTheme

@property (nonatomic, readonly, strong) XXXXAppFontStyle *fontStyle;
@property (nonatomic, readonly, strong) XXXXAppColorStyle *colorStyle;
@property (nonatomic, readonly, strong) XXXXAppDimensionStyle *dimensionStyle;

- (void)switchAppThemeWithComplete:(void (^)(void))block;

@end
