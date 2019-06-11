//
// XXXXDefaultButton.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import "XXXXDefaultButton.h"

@implementation XXXXDefaultButton

- (instancetype)initWithTheme:(XXXXAppTheme *)theme{
    if (self = [super initWithTheme:theme]) {
        [XXXXDefaultButton resetUIOfButton:self];
    }
    return self;
}

- (void)setTheme:(XXXXAppTheme *)theme {
    [super setTheme:theme];
    
    [XXXXDefaultButton resetUIOfButton:self];
}

+ (void)resetUIOfButton:(XXXXButton *)button {
    [button setButtonBackgroundColor:button.theme.colorStyle.buttonDefault
                   hightLightColor:button.theme.colorStyle.buttonDefaultPress
                 disableImageColor:button.theme.colorStyle.disable];
    
    [button setButtonFont:button.theme.fontStyle.h4
                textColor:button.theme.colorStyle.buttonDefaultText
            textHighlight:button.theme.colorStyle.buttonDefaultTextPress
                  onPress:button.block];
}

@end
