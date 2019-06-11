//
// XXXXTextButton.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import "XXXXTextButton.h"

@implementation XXXXTextButton

- (instancetype)initWithTheme:(XXXXAppTheme *)theme{
    if (self = [super initWithTheme:theme]) {
        [self setButtonFont:kAppFont.h5
                  textColor:kAppColor.s2
              textHighlight:XXXX_COLOR_HEX(0x0000cc)];
    }
    return self;
}

@end
