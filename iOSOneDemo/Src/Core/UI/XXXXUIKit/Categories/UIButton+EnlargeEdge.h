//
// UIButton+EnlargeEdge.h
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import <UIKit/UIKit.h>

@interface UIButton (EnlargeEdge)

- (void)setEnlargeEdgeWithSize:(CGFloat)size;
- (void)setEnlargeEdgeWithTop:(CGFloat)top withLeft:(CGFloat)left withBottom:(CGFloat)bottom withRight:(CGFloat)right;

@end
