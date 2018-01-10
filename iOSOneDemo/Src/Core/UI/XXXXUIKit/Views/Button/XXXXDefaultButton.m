//
//  XXXXBaseButton.m
//  jiayoubao
//
//  Created by luochenxun on 2017/6/23.
//  Copyright © 2017年 jiayoubao. All rights reserved.
//

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
