//
// XXXXDefaultRoundButton.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import "XXXXDefaultRoundButton.h"

@implementation XXXXDefaultRoundButton


- (instancetype)initWithTheme:(XXXXAppTheme *)theme{
    if (self = [super initWithTheme:theme]) {
        self.flex_layoutHeight = 50;
        self.flex_layoutWidth = kAppDimension.screenWidth - 30;
        
        self.layer.cornerRadius = 3;
        self.layer.masksToBounds = YES;
    }
    return self;
}

@end
