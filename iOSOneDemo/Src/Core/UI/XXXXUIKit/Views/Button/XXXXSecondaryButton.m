//
// XXXXSecondaryButton.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import "XXXXSecondaryButton.h"

@implementation XXXXSecondaryButton

- (instancetype)initWithTheme:(XXXXAppTheme *)theme{
    if (self = [super initWithTheme:theme]) {
        [XXXXSecondaryButton resetUIOfButton:self];
    }
    return self;
}

- (void)setTheme:(XXXXAppTheme *)theme {
    [super setTheme:theme];
    
    [XXXXSecondaryButton resetUIOfButton:self];
}

+ (void)resetUIOfButton:(XXXXButton *)button {
    button.layer.borderWidth = XXXX_SIZE_LINE;
    button.layer.borderColor = [XXXX_COLOR_HEX(0xcccccc) CGColor];
    button.layer.cornerRadius = 3;
    button.layer.masksToBounds = YES;
    
    [button setButtonBackgroundColor:button.theme.colorStyle.buttonLight
                   hightLightColor:button.theme.colorStyle.buttonLightPress
                 disableImageColor:button.theme.colorStyle.disable];
    
    [button setButtonFont:button.theme.fontStyle.h4
              textColor:button.theme.colorStyle.buttonLightText
          textHighlight:button.theme.colorStyle.buttonLightTextPress
                onPress:button.block];

}

@end
