//
// FlexlayoutMacro.h
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

//  The main-properties of FlexLayout
//
//    FlexDirection
//    FlexJustityContent
//    FlexAlignItems
//    XXAlignSelf


#ifndef FlexlayoutMacro_h
#define FlexlayoutMacro_h


typedef NS_ENUM(NSUInteger, FlexDirection) {
    FlexDirection_row = 0,
    FlexDirection_column,
};

typedef NS_ENUM(NSUInteger, FlexJustityContent) {
    FlexJustityContent_flexStart = 0,
    FlexJustityContent_flexEnd,
    FlexJustityContent_center,
    FlexJustityContent_spaceBetween,
    FlexJustityContent_spaceAround,
    FlexJustityContent_spaceAverage,
    FlexJustityContent_stretch,
    FlexJustityContent_flex,
};

typedef NS_ENUM(NSUInteger, FlexAlignItems) {
    FlexAlignItems_flexStart = 0,
    FlexAlignItems_flexEnd,
    FlexAlignItems_center,
    FlexAlignItems_stretch,
};

typedef NS_ENUM(NSUInteger, FlexAlignSelf) {
    FlexAlignSelf_none = 0,
    FlexAlignSelf_flexStart,
    FlexAlignSelf_flexEnd,
    FlexAlignSelf_center,
    FlexAlignSelf_stretch,
};

#endif /* FlexlayoutMacro_h */
